Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVALJui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVALJui (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 04:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVALJui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 04:50:38 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:40394 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S261318AbVALJu1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 04:50:27 -0500
Date: Wed, 12 Jan 2005 10:44:41 +0100 (CET)
To: pioppo@ferrara.linux.it
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <QyFDHyIh.1105523081.6907040.khali@localhost>
In-Reply-To: <200501112205.02322.pioppo@ferrara.linux.it>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "LM Sensors" <sensors@stimpy.netroedge.com>,
       "Jonas Munsin" <jmunsin@iki.fi>, djg@pdp8.net,
       "Greg KH" <greg@kroah.com>, "LKML" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Simone,

> > 2* I would then add a check to the it87 driver, which completely disables
> > the fan speed control interface if the initial configuration looks weird
> > (all fans supposedly stopped and polarity set to "active low"). This
> > should protect users of the driver who have a faulty BIOS.
>
> If the driver can perform a similar guess, couldn't it also activate a
> reverse polarity mode as well?  I think all systems boot with with
> full-speed fan, so any value you found at loading time should be the
> full-speed one, shouln't it?

I'm thinking about this. However, there are a couple things to keep in
mind:
1* The driver is not necessarily loaded at boot time. For example, one
might unload and reload the module. In this case, fans might have been
configured for less-then-full speed, and we have to handle this case
properly.
2* This is just a guess. If we are wrong, the user is in trouble. You
know what I mean ;) For this reason, it sounds better if the user has to
activate a module parameter by his/herself, because it means he/she is
aware that bad things might happen.
3* This is really a workaround for buggy BIOS. It would be better is
BIOSes were fixed instead. It is time that manufacturer improve the
quality of the BIOSes for the hardware monitoring parts. I have seen
brokenesses ain too many BIOSes to keep count of them. Silently working
around the bugs in the Linux driver is not going to help that.

That said, if no problems are reported after some time, we might consider
to apply the workaround by default. One thing at a time though.

> BTW:
>  I'm writing a report to giga-byte.

OK. Let us know how it goes. Feel free to direct them to me if you think
it can be of any help.

--
Jean Delvare
