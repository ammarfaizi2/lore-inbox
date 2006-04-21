Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWDUTTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWDUTTN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 15:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWDUTTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 15:19:13 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:55999 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932193AbWDUTTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 15:19:11 -0400
Message-ID: <44493023.4010109@pobox.com>
Date: Fri, 21 Apr 2006 15:18:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
CC: Mark Lord <lkml@rtr.ca>, David Greaves <david@dgreaves.com>,
       Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>,
       smartmontools-support@lists.sourceforge.net
Subject: Re: LibPATA code issues / 2.6.16 (previously, 2.6.15.x)
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046CE6.60803@rtr.ca> <44046D86.7050809@pobox.com> <4405DCAF.6030500@dgreaves.com> <4405DDEA.7020309@rtr.ca> <4405E42B.9040804@dgreaves.com> <4405E83D.9000906@rtr.ca> <4405EC94.2030202@dgreaves.com> <4405FAAE.3080705@dgreaves.com> <Pine.LNX.4.64.0603050637110.30164@p34> <Pine.LNX.4.64.0603050740500.3116@p34> <440B6CFE.4010503@rtr.ca> <440B76B4.5080502@pobox.com> <Pine.LNX.4.64.0604211511120.22768@p34>
In-Reply-To: <Pine.LNX.4.64.0604211511120.22768@p34>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.9 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.9 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> Yet a new problem, under 2.6.16, when I fill up the disk, smartmontools 
> reports this:
> 
> Apr 21 14:24:20 p34 smartd[1443]: Device: /dev/sdc, 1 Currently unreadable
> (pending) sectors
> Apr 21 14:54:20 p34 smartd[1443]: Device: /dev/sdc, 1 Currently unreadable
> (pending) sectors
> Apr 21 14:54:20 p34 smartd[1443]: Device: /dev/sdc, 1 Offline uncorrectable
> sectors
> 
> What made it error under 2.6.16?
> 
> $ time dd if=/dev/zero of=file.out
> dd: writing to `file.out': No space left on device
> 781118873+0 records in
> 781118872+0 records out
> 399932862464 bytes (400 GB) copied, 8873.06 seconds, 45.1 MB/s
> 
> real    147m53.092s
> user    8m1.395s
> sys     42m4.500s
> 
> $
> 
> Under 2.6.15.x, I did not see this behavior, is this going bad, or?

That's a disk-level problem.  You've got bad sectors.

You can force the disk to replace the bad sectors by doing a disk-level 
write:

	dd if=/dev/zero of=/dev/sda1 bs=4k

and then test the disk with

	smartctl -d ata -t long /dev/sda

If sectors continue to die, the disk is toast.

	Jeff



