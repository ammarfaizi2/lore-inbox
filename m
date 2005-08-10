Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbVHJAuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbVHJAuW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 20:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbVHJAuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 20:50:22 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:2960 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751020AbVHJAuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 20:50:20 -0400
Subject: Re: Linux-2.6.13-rc6: aic7xxx testers please..
From: James Bottomley <James.Bottomley@SteelEye.com>
To: John Stoffel <john@stoffel.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <17145.3629.933024.963438@smtp.charter.net>
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
	 <200508081954.52638.jesper.juhl@gmail.com>
	 <17145.1417.329260.524528@smtp.charter.net>
	 <1123617516.5170.42.camel@mulgrave>
	 <17145.3629.933024.963438@smtp.charter.net>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 19:50:10 -0500
Message-Id: <1123635010.5170.75.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-09 at 16:12 -0400, John Stoffel wrote:
> Thank you for looking into this with me, I really appreciate it.  I'm
> kinda stumped why this suddenly started happening, but it could be
> hardware related of course...

Well ... there's something going on that your posted dmesg's don't seem
to cover.  This:

>     Vendor: SUN       Model: DLT7000           Rev: 1E48
>     Type:   Sequential-Access                  ANSI SCSI revision: 02
>    target1:0:6: asynchronous.
>    target1:0:6: Beginning Domain Validation
>    target1:0:6: wide asynchronous.
>    target1:0:6: Domain Validation skipping write tests
>    target1:0:6: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, offset 8)
>    target1:0:6: Ending Domain Validation

Say everything went OK with DV and the drive attaches wide and at 10MHz.

But in your previous posting, the aic proc routines said this:


> Target 6 Negotiation Settings
>         User: 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
>         Goal: 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
>         Curr: 3.300MB/s transfers
>         Channel A Target 6 Lun 0 Settings
>                 Commands Queued 1065
>                 Commands Active 0
>                 Command Openings 1
>                 Max Tagged Openings 0
>                 Device Queue Frozen Count 0

Which is the AIC driver's way of saying narrow async.

So something must have happened during the 1065 I/Os to cause this.
Hopefully that something left a trace in the logs.

James


