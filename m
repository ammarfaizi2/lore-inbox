Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287781AbSAFKM0>; Sun, 6 Jan 2002 05:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287785AbSAFKMR>; Sun, 6 Jan 2002 05:12:17 -0500
Received: from dsl-213-023-043-049.arcor-ip.net ([213.23.43.49]:31236 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287781AbSAFKMC>;
	Sun, 6 Jan 2002 05:12:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Eric <eric@dragonglen.net>, Andrew Morton <akpm@zip.com.au>
Subject: Re: 2.4.17 oops - ext2/ext3 fs corruption (?)
Date: Sun, 6 Jan 2002 11:15:11 +0100
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201051528400.850-100000@fire.dragonglen.invalid>
In-Reply-To: <Pine.LNX.4.33.0201051528400.850-100000@fire.dragonglen.invalid>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16NAKo-0001K1-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 6, 2002 12:31 am, Eric wrote:
> On Sat, 5 Jan 2002, Andrew Morton wrote:
> > Eric wrote:
> > > 
> > > I seem to be having a reoccurring problem with my Red Hat 7.2 system
> > > running kernel 2.4.17.  Four times now, I have seen the kernel generate an
> > > oops.  After the oops, I find that one of file systems is no longer sane.
> > > The effect that I see is a Segmentation Fault when things like ls or du
> > > some directory (the directory is never the same).  Also, when the system
> > > is going down for a reboot, it is unable to umount the file system.  The
> > > umount command returns a "bad lseek" error.
> > 
> > Everything here points at failing hardware.  Probably memory errors.
> > People say that memtest86 is good at detecting these things.  Another
> > way to verify this is to move the same setup onto a different computer...
> 
> I ran memtest86 on the system and let it complete 4 passes before I 
> stopped it.  It found no errors.  Unfortunately, I do not have another 
> system available to test this on.  Are there any other diagnostics I can 
> run to determine if this is truly a hardware problem?

This doesn't smell like hardware to me, since your two backtraces are identical:

>>EIP; c013ee54 <d_lookup+64/120>   <===== 
Trace; c0136d40 <cached_lookup+10/50> 
Trace; c013740a <link_path_walk+4ea/730> 
Trace; c0136b1f <getname+5f/a0> 
Trace; c01379d3 <__user_walk+33/50> 
Trace; c0134bb4 <sys_lstat64+14/70> 
Trace; c0106e04 <error_code+34/40> 
Trace; c0106cf3 <system_call+33/40> 
Code;  c013ee54 <d_lookup+64/120> 
00000000 <_EIP>: 
Code;  c013ee54 <d_lookup+64/120>   <===== 
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp   <===== 
Code;  c013ee57 <d_lookup+67/120> 
   3:   39 53 44                  cmp    %edx,0x44(%ebx) 
Code;  c013ee5a <d_lookup+6a/120> 
   6:   0f 85 90 00 00 00         jne    9c <_EIP+0x9c> c013eef0 <d_lookup+100/120> 
Code;  c013ee60 <d_lookup+70/120> 
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax 
Code;  c013ee64 <d_lookup+74/120> 
  10:   39 43 0c                  cmp    %eax,0xc(%ebx) 
Code;  c013ee67 <d_lookup+77/120> 
  13:   0f 00 00                  sldt   (%eax) 

--
Daniel
