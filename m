Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261294AbSJ1O4h>; Mon, 28 Oct 2002 09:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261293AbSJ1O4f>; Mon, 28 Oct 2002 09:56:35 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50840 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261291AbSJ1OzZ>;
	Mon, 28 Oct 2002 09:55:25 -0500
Date: Mon, 28 Oct 2002 15:58:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Markus Plail <plail@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug] 2.5.44-ac2 cdrom eject panic
Message-ID: <20021028145850.GE2937@suse.de>
References: <20021025103631.GA588@giantx.co.uk> <20021025103938.GN4153@suse.de> <87adl2is1u.fsf@gitteundmarkus.de> <20021025144224.GW4153@suse.de> <87pttyh3r5.fsf@gitteundmarkus.de> <20021025165354.GG4153@suse.de> <874rb71xfc.fsf@gitteundmarkus.de> <20021027185636.GJ3966@suse.de> <20021028121433.GA872@suse.de> <87lm4iegtg.fsf@gitteundmarkus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lm4iegtg.fsf@gitteundmarkus.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28 2002, Markus Plail wrote:
> * Jens Axboe writes:
> >On Sun, Oct 27 2002, Jens Axboe wrote:
> >>> Now if C2 scans would work that'd be great ;-)
> >>> 
> >>> [plail@plailis_lfs:plail]$ readcd dev=/dev/hdc -c2scan
> >>> Read  speed:  7056 kB/s (CD  40x, DVD  5x).
> >>> Write speed:     0 kB/s (CD   0x, DVD  0x).
> >>> Capacity: 4116432 Blocks = 8232864 kBytes = 8039 MBytes = 8430 prMB
> >>> Sectorsize: 2048 Bytes
> >>> Copy from SCSI (0,0,0) disk to file '/dev/null'
> >>> end:   4116432
> >>> addr:        0 cnt: 99^Mreadcd: Operation not permitted. Cannot send SCSI cmd vi
> >>> readcd: Operation not permitted. Cannot send SCSI cmd via ioctl
> >>
> >>Interesting, have no tried readcd at all myself. Will give it a spin and
> >>fix this tomorrow.
> 
> >It uses SCSI_IOCTL_SEND_COMMAND ioctl, an old piece of crap interface
> >instead of libscg. I can add the 50 lines or so to emulate that ioctl,
> >but it would probably be better if readcd just got converted to use
> >libscg instead.
> 
> OK. Can you get in touch with Jörg to get that sorted out? Or should I
> post to cdwrite ML?

I'm trying to get it fixed, it looks as though I may have been premature
in saying that it uses SCSI_IOCTL_SEND_COMMAND is the reason it doesn't
work (of course I found this out after doing the complete emulation!).
Basically, from an strace, it looks as if ioctl(.., SG_IO, ..) returns
-ENOTTY after another ioctl does so even though it has completed many
times in the past on the same fd. Strange.

So no worries, I'll get it sorted. And I do talk to Joerg from time to
time myself.

-- 
Jens Axboe

