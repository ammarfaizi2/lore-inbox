Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318043AbSHDBLK>; Sat, 3 Aug 2002 21:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318044AbSHDBLK>; Sat, 3 Aug 2002 21:11:10 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:12734 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S318043AbSHDBLJ>;
	Sat, 3 Aug 2002 21:11:09 -0400
Date: Sun, 4 Aug 2002 03:14:37 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Skip Ford <skip.ford@verizon.net>
Cc: linux-kernel@vger.kernel.org, johninsd@san.rr.com
Subject: Re: 2.5.30 LILO FreeBSD partition problems
Message-ID: <20020804011437.GA29028@win.tue.nl>
References: <200208032300.g73N0Pix000183@pool-141-150-241-241.delv.east.verizon.net> <20020803233035.GA29008@win.tue.nl> <200208040017.g740HF5K000181@pool-141-150-241-241.delv.east.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208040017.g740HF5K000181@pool-141-150-241-241.delv.east.verizon.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 03, 2002 at 08:17:14PM -0400, Skip Ford wrote:

> > Which LILO version is this?
> 
> 21.4-3
> 
> > What are the kernel boot messages for this disk
> 
> 2.5.29:
> hda: Maxtor 2B020H1, DISK drive
>  hda: 39876480 sectors w/2048KiB Cache, CHS=39560/16/63, UDMA(33)
>  hda: [PTBL] [2482/255/63] hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
>
> 2.5.30:
>  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
> 
> > Probably some LILO option like "ignore-table" or "linear" or "lba32"
> > would help.
> 
> lba32 and linear each didn't work.  I didn't try ignore-table.  I see
> the difference above between .29 and .30 with [PTBL] but I don't know
> what it means.

LILO wants to check that what it sees in the partition table
corresponds to the truth. The kernel has first decided that
the truth is CHS=39560/16/63, but then looks at the partition table
and sees that some programs are going to be unhappy if it reveals
this truth, and instead it returns what it finds in the partition
table. That is what this "[PTBL] [2482/255/63]" means.

Since 2.5.30 the kernel no longer looks at the partition table to
guess what would make fdisk and lilo happy. These programs can
(and do) look at the partition table themselves and need no
kernel help. Now fdisk already knows this, but maybe lilo doesn't.

If you want the kernel to provide lilo with some random numbers,
add boot parameters to the kernel invocation: hda=C,H,S.
If you want lilo to ignore the discrepancy between what the
disk said and the kernel repeated and what it sees in the
partition table, try the global option "ignore-table".
(I never tried, this is just from the man page.)

If lilo tries to check 3D addresses in spite of the fact that
it got a "linear" or "lba32" option, then that is a lilo bug,
especially if it aborts on a difference.
Let me cc the maintainer - maybe John Coffman.

Andries
