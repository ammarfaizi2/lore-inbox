Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129101AbRBKMDT>; Sun, 11 Feb 2001 07:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129124AbRBKMDJ>; Sun, 11 Feb 2001 07:03:09 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:42347 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S129101AbRBKMC4>;
	Sun, 11 Feb 2001 07:02:56 -0500
Message-ID: <20010211130252.A27559@win.tue.nl>
Date: Sun, 11 Feb 2001 13:02:52 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Marcel Silva e Sousa <marcel@netmaxi.com.br>, linux-kernel@vger.kernel.org
Subject: Re: OOPS: CRITICAL BUG IN KERNEL 2.4.0 and 2.4.1
In-Reply-To: <01021105333500.02394@john>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <01021105333500.02394@john>; from Marcel Silva e Sousa on Sun, Feb 11, 2001 at 05:33:35AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2001 at 05:33:35AM -0200, Marcel Silva e Sousa wrote:
> Hi all, i see a critical bug in kernel version 2.4.0 and 2.4.1, look it:
> 
> My Hard Disk:
> hda: IBM-DPTA-372730, ATA DISK drive
> hda: 53464320 sectors (27374 MB) w/1961KiB Cache, CHS=3328/255/63, UDMA(33)
> 
> [root@john /]:: df -h
> Filesystem            Size  Used Avail Use% Mounted on
> /dev/hda1             5.4G  3.7G  1.5G  71% /
> /dev/hda2             143G  136G  6.8G  95% /mnt/hda2
> [root@john /]:: 
> 
> When i had kernel 2.2.18 i did not have this problem....

Hmm. df is not the kernel.

But df does a statfs system call, and something might be broken,
especially if you have an unusual filesystem type.
You might report on (i) what filesystem type lives on /dev/hda2?
(ii) what does "strace -e statfs df" say? What df outputs in the
"Size" column is the value of f_blocks.

Of course, if you write garbage to the size field of some superblock,
then the kernel will happily report it - there need not be a bug.
But now that you say "2.2.18 did not have this problem":
what is the 2.2.18 df output?
What is the "dmesg | grep hda" on both 2.4 and 2.2?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
