Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131133AbRAMDEH>; Fri, 12 Jan 2001 22:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135556AbRAMDD6>; Fri, 12 Jan 2001 22:03:58 -0500
Received: from linuxcare.com.au ([203.29.91.49]:21515 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S131133AbRAMDDr>; Fri, 12 Jan 2001 22:03:47 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Sat, 13 Jan 2001 14:00:58 +1100
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Mauelshagen@sistina.com, linux-kernel@vger.kernel.org,
        linux-lvm@sistina.com, lvm@sistina.com
Subject: Re: *** ANNOUNCEMENT *** LVM 0.9.1 beta1 available at www.sistina.com
Message-ID: <20010113140058.E15915@linuxcare.com>
In-Reply-To: <20010113114507.D15915@linuxcare.com> <200101130143.f0D1hNF19829@webber.adilger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200101130143.f0D1hNF19829@webber.adilger.net>; from adilger@turbolinux.com on Fri, Jan 12, 2001 at 06:43:23PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> What is the reason for all this?  Alignment/wordsize/other?  If you look
> at the IOP10 code, much of the in-core data structs were changed to int
> or long, so this sparc code may not be necessary.  It may in fact be
> damaging, because I don't know if any of the LVM developers even know it
> is there, and surely it will be out of sync...

Two things:

Structures used in ioctls should have explicit sizes (eg u32, not unsigned
long). Remember on sparc64 we have a 32 bit userspace and 64 bit kernel.

Having pointers to other structures is considered bad form again due to the
32bit/64bit differences. Think 32 bit pointers vs 64 bit pointers :)

When either of these happen we have to write up translation code. Of
the two, having pointers to other structs is definitely the worst. 

Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
