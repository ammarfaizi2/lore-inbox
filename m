Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264209AbTIIPAi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 11:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264214AbTIIPAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 11:00:37 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:49813 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264209AbTIIPA3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 11:00:29 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Phil Dibowitz <phil@ipom.com>
Subject: Re: Linux IDE bug in 2.4.21 and 2.4.22 ?
Date: Tue, 9 Sep 2003 17:01:48 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20030908225107.GE17108@earthlink.net> <200309091448.36231.bzolnier@elka.pw.edu.pl> <3F5DE49E.50500@ipom.com>
In-Reply-To: <3F5DE49E.50500@ipom.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309091701.48993.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 of September 2003 16:33, Phil Dibowitz wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Tuesday 09 of September 2003 00:51, Phil Dibowitz wrote:
> >>Hey folks,
> >>
> >>I think I may have found a bug in the Linux IDE subsystem
> >>introduced in 2.4.21 and still present in 2.4.22.
> >
> > Nope, user error :-).
>
> I thought there was a reasonable chance of that! =)
>
> > Nope, your CMD649 was handled by generic PCI IDE driver.
>
> Ah, OK. Makes sense.
>
> >>As of 2.4.21, this configuration no longer works -- which is not
> >>necessarily a bug. I'm almost there, stay with me. =)
> >
> > Assumption that current .config will work with future kernel versions is
> > *false*.
>
> Agreed. I said that wasn't a bug. =)
>
> > Just add these two lines to your .config:
> > CONFIG_BLK_DEV_VIA82CXXX=y
> > CONFIG_BLK_DEV_CMD64X=y
>
> Doh!! Didn't see the VIA driver down there at the bottom. Double doh! My
> appologies, I should have been able to figure that out.
>
> That works quite well, thank you! Still have a question though...

No problem, thanks for report.

> > Your VIA IDE controller was handled by generic IDE chipset driver which
> > did probe devices *after* PCI controllers are probed, so CMD649 took
> > ide0 and ide1 first.
>
> But, what about the case when I built in the generic driver, but made
> the CMD649 driver a module, and loaded it after boot. That shouldn't
> have *changed* what ide0 and ide1 are, right? I had ide0 and ide1
> assigned, did a modprobe, and CMD649 changed what ide0 adn ide1 where,
> and then forgot about the previous ones.. like all of a sudden it told
> the generic driver "no, no, you were wrong, there's no VIA chipset here,
> go back to sleep."

Hmm. please send me dmesg.

--bartlomiej

> I may well be misunderstanding something precedence in the kernel here,
> but I figured while I'm bugging you, I might as well get the full picture.
>
> Thanks for your time!

