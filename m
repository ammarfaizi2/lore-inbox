Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTECWt7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 18:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263459AbTECWt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 18:49:59 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:25872 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S263455AbTECWty
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 18:49:54 -0400
Date: Sat, 03 May 2003 17:01:51 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Aic7xxx and Aic79xx Driver Updates
Message-ID: <1430020000.1052002911@aslan.scsiguy.com>
In-Reply-To: <1051898880.1819.63.camel@mulgrave>
References: <1866260000.1051828092@aslan.btc.adaptec.com>	<1051885837.1820.34.camel@mulgrave>
 	<2274070000.1051897888@aslan.btc.adaptec.com> <1051898880.1819.63.camel@mulgrave>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The answer to this and your other issues you raise about the driver are
>> the same.  I do not want to fork the driver.  I still have to maintain
>> support all the way back to 2.4.7 and branching the driver for every
>> different supported kernel would be a nightmare to maintain.  As it stands
>> now, other than the Makefile and kernel config files, there is just one
>> set of files that supports all of these kernels.  It makes it much
>> easier for everyone involved including the primary maintainer of the
>> driver.
> 
> Well, you do keep a 2.4 and a 2.5 tree, so you still have to apply your
> patches twice.

Linux has finally started to use revision control, so I try to take
advantage of that by breaking up my changes and providing complete
changelogs.  Yes, it is a pain since I have to do three commits (Perforce,
BK linux-2.4, BK linux-2.5), but there is only one "version" of the driver
that I have to keep in my head, rather than two or twenty.  The 2.4.X code
also encourages those "upgrading" the drivers for 2.5.X features to do so in
a 2.4.X compatible fashion.  It's usually not that hard.

> You also seem to have two drivers: aic7xxx and aic79xx
> which seem to duplicate about 80% of the code between them, so you have
> to further patch each of these drivers for each of your fixes.

80% is a bit of an overstatement.  Yes, the OSMs are similar because
the author is the same.  Where code can be factored it is put into the
aiclib files - a process that is not fully complete.  The concentration
has been on keeping the drivers up to date with 2.5 and fixing bugs, but
some bit of code moves to common files in almost every version bump.

> I'm not asking for any changes to the way you do 2.4, just for 2.5 where
> we have no vendor versions to support and there should only be a single
> tree.

And as the maintainer, I know that maintaining a single driver is
far easier than splitting it up.  Other maintainers may feel differently,
but they are not maintaining these drivers.

>> I've tried hard to make most of the API differences similarly transparent
>> within the driver to avoid messy ifdefs.  I haven't succeeded everywhere,
>> but this is the price you pay when APIs change so often.  All of the code
>> is also setup so that the backwards compatibility hooks have no impact on
>> the driver's performance under any support kernel (i.e. each kernel is
>> supported as best as it can be supported).
> 
> Well, for 2.4, where there are multiple vendor versions, I'm OK with
> this.  For 2.5 it's not necessary (yet).

If at some point there becomes an official policy that all backward
compatibility code must be removed, I will do so.  I'm sure I'm not
the only driver maintainer that will complain if/when this happens.  Until
then, I hope that the level of "obscurity" this adds to the code doesn't
prevent you or others from providing substantive reviews of my drivers.

--
Justin

