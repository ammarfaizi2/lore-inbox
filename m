Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283380AbRK2Sbp>; Thu, 29 Nov 2001 13:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283384AbRK2Sbk>; Thu, 29 Nov 2001 13:31:40 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:47375 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283380AbRK2Sav>;
	Thu, 29 Nov 2001 13:30:51 -0500
Date: Thu, 29 Nov 2001 19:30:28 +0100
From: Jens Axboe <axboe@suse.de>
To: Alvaro Lopes <alvieboy@alvie.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: UPDATE - Re: System temporary freeze (but network layer) while blanking CD-RW w/ ide-scsi [2.4.14 and 2.4.16 w/preempt]
Message-ID: <20011129193028.R10601@suse.de>
In-Reply-To: <3C065182.3090909@alvie.com> <1007058142.1837.0.camel@dwarf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1007058142.1837.0.camel@dwarf>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29 2001, Alvaro Lopes wrote:
> Well, did some sysrq show tasks while blanking and found processes
> locked (D) in:
> 
> sleep_on()
> wait_on_buffer()
> lock_page()
> ___wait_on_page()
> 
> 
> I issued a ^C to cdrecord but blanking kept on. System resumed normal
> operation after end of blanking.

Those processes are likely waiting for I/O to complete (well start,
even) on a disk that is on the same channel as the cd drive doing the
blank command. If the program you are using to do the blank is not using
the IMMED bit, you will be stuck waiting for the command to complete
(ATA has no real disconnect).

-- 
Jens Axboe

