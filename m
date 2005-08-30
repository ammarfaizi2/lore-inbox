Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbVH3AMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbVH3AMr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 20:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbVH3AMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 20:12:47 -0400
Received: from smtp1.brturbo.com.br ([200.199.201.163]:61846 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1751137AbVH3AMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 20:12:46 -0400
Subject: Re: [PATCH 2.6] I2C: Drop I2C_DEVNAME and i2c_clientname
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com,
       Greg KH <greg@kroah.com>
In-Reply-To: <20050825001958.63b2525c.khali@linux-fr.org>
References: <20050815195704.7b61206e.khali@linux-fr.org>
	 <1124741348.4516.51.camel@localhost>
	 <20050825001958.63b2525c.khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 29 Aug 2005 21:12:42 -0300
Message-Id: <1125360762.6186.29.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-6mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jean,
Em Qui, 2005-08-25 às 00:19 +0200, Jean Delvare escreveu:
> Hi Mauro,
> 

> > That's not true. We keep V4L tree compatible with older kernel
> > releases. Each change like this does generate a lot of work at V4L
> > side to provide #ifdefs to check for linux version and provide a
> > compatible way to compile with older versions.
> 
> I'm sorry but we will not stop updating the various Linux 2.6 subsystems
> to keep them compatible with 2.4 - else one would wonder why there is a
> 2.6 kernel tree at all. 
	I don't expect so, but it would be nice not to have a different I2C API
for every single 2.6 version :-) It would be nice to change I2C API once
and keep it stable for a while.

> As time goes, the differences bwteen 2.4 and 2.6
> will only increase. You seem to be trying to keep common driver code
> across incompatible trees. I'm not surprised that it is a lot of work.
> That's your choice, live with it.
	It is not just a matter of choice. V4L stuff is mostly used by end
users. There are a few professional users, like those working on CATV
and video broadcasting. They don't have much knowledge and generally
uses distro-provided kernels. It is not like I2C or PCI that most boards
has something inside.
	Also: boards are country-specific. There are dozens of different analog
standards. So, the same brand name (even the same model on some cases)
have different tuners for different video standards.
	For us to have people to test all variations, we need to provide
backward support. Otherwise, we'll suffer a lot to test our patches,
since nobody on V4L devel is currently payed for doing his job and don't
have a lab with a bunch of cards and models.
> 
> > I don't see any sense on applying this patch, since it will not reduce
> > code size or increase execution time.
> 
> Code size and execution time are not the only factors to take into
> account. Code readability and compilation time are two other ones that I
> mentioned already.
Agreed.
> 
> Anyway, it doesn't look like you actually read what I wrote in the first
> place. My comment about common driver code was really only by the way.
> The reason why I have been proposing this patch is that I2C_DEVNAME and
> i2c_clientname were only needed between Linux 2.5.68 and 2.6.0-test3,
> which are unsupported by now, as they were development releases. As far
> as i2c_client.name is concerned, 2.4 and 2.6.0+ trees are compatible.
> 
	Ok. I didn't understood this from your previous email. So, for me, it
is perfect to apply it. We do want to keep V4L tree compatibility with
2.6.x and with the latest 2.4 version. Currently, we lost compat with
2.4, but I plan to provide a backport soon to the latest 2.4 release.

	I have a question for you about I2C: why i2c_driver doesn't have a
generic pointer to keep priv data (like i2c_adapter) ? 

	It would be nice to have such pointer (like have on other I2C
structures), in order to support multiple tuners for each function. This
is required for modern boards that have a TV analog tuner, a digital one
and a radio chip, it would be nice to have such structure to keep a
tuner table on it, and make easier to detect this.

> Thanks,
Thanks,
Mauro.

