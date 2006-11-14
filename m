Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966290AbWKNTfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966290AbWKNTfQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 14:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966295AbWKNTfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 14:35:16 -0500
Received: from sycorax.lbl.gov ([128.3.5.196]:12819 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S966290AbWKNTfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 14:35:14 -0500
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1 (+ide-cd patches) regression: unable to rip cd
References: <20061110161355.GB15031@kernel.dk>
	<87u01717qw.fsf@sycorax.lbl.gov> <20061113200256.GC15031@kernel.dk>
	<87lkmfcdci.fsf@sycorax.lbl.gov> <20061113203523.GE15031@kernel.dk>
	<87ejs5dib1.fsf@sycorax.lbl.gov> <20061114190425.GE23770@kernel.dk>
Date: Tue, 14 Nov 2006 11:35:10 -0800
In-Reply-To: <20061114190425.GE23770@kernel.dk> (message from Jens Axboe on
	Tue, 14 Nov 2006 20:04:25 +0100)
Message-ID: <87ac2tddox.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <jens.axboe@oracle.com> writes:

> When cdparanoia gets stuck, how is it stuck? Can you give me a
> backtrace of that? If you can abort it, sounds like it isn't stuck
> in the kernel.

i don't have my laptop with me but the error message i get in syslog
is somewhere along the lines of (this is copied from the initial bug
report):

kernel: ATAPI device hdc:
kernel:   Error: Aborted command -- (Sense key=0x0b)
kernel:   (reserved error code) -- (asc=0x11, ascq=0x11)
kernel:   The failed "Read CD" packet command was: 
kernel:   "be 00 00 00 51 93 00 00 0d f8 00 00 00 00 00 00 "
kernel: hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
kernel: hdc: packet command error: error=0x30 { LastFailedSense=0x03 }
kernel: ide: failed opcode was: unknown
kernel: ATAPI device hdc:
kernel:   Error: Medium error -- (Sense key=0x03)
kernel:   Unrecovered read error -- (asc=0x11, ascq=0x00)
kernel:   The failed "Read CD" packet command was: 
kernel:   "be 00 00 00 51 a0 00 00 07 f8 00 00 00 00 00 00 "
kernel: hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
kernel: hdc: packet command error: error=0xb4 { AbortedCommand LastFailedSense=0x0b }
kernel: ide: failed opcode was: unknown
kernel: ATAPI device hdc:
kernel:   Error: Aborted command -- (Sense key=0x0b)
kernel:   (reserved error code) -- (asc=0x11, ascq=0x11)
kernel:   The failed "Read CD" packet command was: 
kernel:   "be 00 00 00 51 9b 00 00 0d f8 00 00 00 00 00 00 "

and i assume cdparanoia has problems reading that particular sector
and then it retries and i get similar messages every 5 seconds.
sometimes it recovers from this, at other times it's just stuck there
trying to read the same sector over and over again.

but after i get this message the ripping speed is greatly reduced
until i eject/insert the cd. then the speed goes back to normal. it
doesn't matter if cdparanoia recovers, or if i start a new cdparanoia
process, only if i eject/insert the cd. does this make sense?

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
