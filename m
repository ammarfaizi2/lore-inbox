Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVB1NgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVB1NgT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 08:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVB1Neg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 08:34:36 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:57230 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261594AbVB1Nd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 08:33:59 -0500
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch ide-dev 7/9] convert disk flush functions to use REQ_DRIVE_TASKFILE
Date: Sun, 27 Feb 2005 17:39:16 +0100
User-Agent: KMail/1.7.1
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Pine.GSO.4.58.0502241545041.13534@mion.elka.pw.edu.pl> <20050227045125.GA25723@htj.dyndns.org>
In-Reply-To: <20050227045125.GA25723@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502271739.16076.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sunday 27 February 2005 05:51, Tejun Heo wrote:
>  Hello, Bartlomiej,
> 
> On Thu, Feb 24, 2005 at 03:45:39PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Original patch from Tejun Heo <htejun@gmail.com>,
> > ported over recent IDE changes by me.
> > 
> > * teach ide_tf_get_address() about CHS
> 
>  IMHO, as patch #4 moves LBA/CHS selection into taskfile, I think
> using taskfile->device to determine whether LBA or CHS is used instead
> of drive->select makes more sense.
>
> > * use ide_tf_get_address() and remove ide_get_error_location()
> 
>  IIRC, error responses for WIN_FLUSH_CACHE is in CHS if the LBA bit in
> the device register is zero; likewise, in LBA if the LBA bit is one.
> I don't know if drives can change the LBA bit when posting error
> result.  The original code reads back the device register on error to
> determine whether to interpret the error response in CHS or LBA.
> (ATA/ATAPI-6 isn't clear on this issue.  Is ATA/ATAPI-7 updated?)

The thing is that LBA bit is marked as "na" for FLUSH CACHE
in all ATA/ATAPI drafts that I've seen.

>  This change combined with patch #2/#5 can make error address
> calculation wrong on LBA28 drives.  I think setting the LBA bit in the
> device register according to the drive's addressing mode in
> ide_task_init_flush() and use taskfile->device in ide_tf_get_address()
> should fix the problem.

I will change the code to set LBA bit, it shouldn't hurt. :-)
