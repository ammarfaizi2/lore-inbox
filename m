Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272092AbRIOGjX>; Sat, 15 Sep 2001 02:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272093AbRIOGjM>; Sat, 15 Sep 2001 02:39:12 -0400
Received: from [24.254.60.20] ([24.254.60.20]:22426 "EHLO
	femail30.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S272092AbRIOGjG>; Sat, 15 Sep 2001 02:39:06 -0400
Mime-Version: 1.0
Message-Id: <p05100301b7c8a0bb9015@[10.0.0.42]>
Date: Fri, 14 Sep 2001 23:39:22 -0700
To: linux-kernel@vger.kernel.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: How errorproof is ext2 fs?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Otto Wyss <otto.wyss@bluewin.ch> wrote:

>At least ext2 and probably all the journalling fs lacks a feature the HFS+
>from the Mac has (bad tongues might say "needs"), to keep open files
>without activity in a state where a crash has no effect. I don't know how
>it is done since I'm no fs expert but my experience with my Mac (resetting
>about once a month without loosing anything) shows that it's possible.

HFS+ (the file system, as opposed to implementations of it) has no 
such feature.

In fact, HFS+ is probably more vulnerable to file system damage than 
a FS like ext2, simply because it uses a B-Tree structure.  B-Trees 
have their purposes (such as searching the whole FS for a file 
quickly, a capability very important to classic MacOS), but are 
generally not as robust as a simple inode FS like ext2.

The only thing which prevents damage from being common on MacOS 9 is 
the slow and unsophisticated MacOS 9 *implementation* of HFS+.  I'm 
pretty sure it is synchronous and single-threaded.  And the MacOS 
cache doesn't keep dirty buffers for any significant amount of time 
(no more than ~0.5s I think).  These things mean that at any given 
point in time, the state of the HFS+ metadata on disk is probably 
coherent or close to it.

As others have mentioned -- if you want FS crash resistance somewhat 
more like MacOS 9, mount your ext2 filesystems sync.  Be prepared for 
a huge performance loss.  But the correct thing to do is to figure 
out why Linux is crashing and fix it -- Linux can and should stay up 
for months or years.

Also, under Darwin (aka the MacOS X BSD layer), the likelihood of 
damage to a HFS+ volume after a crash/reboot is significantly higher. 
Darwin has a high performance async HFS+ implementation with a real 
buffer cache behind it.

-- 
Tim Seufert
