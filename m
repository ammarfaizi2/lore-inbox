Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965168AbVHJPqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbVHJPqb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 11:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbVHJPqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 11:46:31 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:36502 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S965158AbVHJPqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 11:46:30 -0400
Subject: Re: Linux-2.6.13-rc6: aic7xxx testers please..
From: James Bottomley <James.Bottomley@SteelEye.com>
To: John Stoffel <john@stoffel.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <17146.7454.818003.464185@smtp.charter.net>
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
	 <200508081954.52638.jesper.juhl@gmail.com>
	 <17145.1417.329260.524528@smtp.charter.net>
	 <1123617516.5170.42.camel@mulgrave>
	 <17145.3629.933024.963438@smtp.charter.net>
	 <1123635010.5170.75.camel@mulgrave>
	 <17146.7454.818003.464185@smtp.charter.net>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 10:46:18 -0500
Message-Id: <1123688778.5134.3.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-10 at 11:28 -0400, John Stoffel wrote:
> Is there any more info I can provide here for you?  dmesg output?
> Here's the latest output from dmesg with the lockup of the drive,
> which takes a power cycle to clear now.

Well, I suspect the tape is hanging the bus, from which no card can
recover.

Just to test this, can you try sending a bus reset with sgutils (from
the debain package sg3-utils):

sg_reset -b /dev/sg3

Then remove and re-add the device with

echo scsi remove-single-device 1 0 6 0 > /proc/scsi/scsi
echo scsi add-single-device 1 0 6 0 > /proc/scsi/scsi

And see if that brings it back.  If it doesn't I'm afraid the tape has
the bus locked and nothing can free it.

James


