Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVC0Ivb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVC0Ivb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 03:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVC0Ivb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 03:51:31 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:10187 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261476AbVC0Iv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 03:51:27 -0500
Date: Sun, 27 Mar 2005 10:51:24 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Squashfs without ./..
In-Reply-To: <200503270811.j2R8BxJ12538@freya.yggdrasil.com>
Message-ID: <Pine.LNX.4.61.0503271037480.22393@yvahk01.tjqt.qr>
References: <200503270811.j2R8BxJ12538@freya.yggdrasil.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>[...] . and .. do not need to show up (even they have been the 
>>"leaders" of ls -l ;-), Midnight Commander (`mc`) for example synthesizes ".." 
>>nevertheless.
>>
>>So - what about removing . and .. in readdir for all "standard harddisk 
>>filesystems" (ext*,reiser*, [jx]fs)? I mean, one party always has to loose...~v

H. Peter Anvin wrote:
>Are you seriously suggesting changing our behaviour of all the
>conventional filesystems to a non-Unix behaviour, to match cramfs and
>squashfs?

Only one can be right - either with ./.. or without it. And the one[s] who
is/are wrong should be fixed. Take it as a cosmetical issue, though.


Adam J. Richter wrote:
>
>	Eliminating the "." and ".." emulation in many individual
>file systems would probably eliminate a moderate amount of code
>from libfs/fs.c, a number of other virtual file systems and probably
>every physical file system that does not actually store "." and "..".
>It is very appealing to me.

As a side note, I am only discussing about ./.. for readdir; removing it from
the entire VFS would probably break things like /etc/mail/../../lib/libc.so.6
_in_ the kernel.

>	The first way would be to change the kernel so that the
>underlying readdir system call does not return "." or "..", but
>have the C library do the emulation.  The C library can maintain
>the state information for this purpose easily because opendir()
>returns a pointer to an opaque structure that the C library
>allocates.

Sounds "good", because ./.. could always be made the first two entries, and
people could optimize <shrug>. That brings up the point if - despite all sus
specs - we really need . and ...

The explorer.exe in the Neighbor OS also does not show . and ..;
and I doubt any app is using it in FindFile{First,} (open-/readdir),
maybe only for dentry lookup.

>but having an
>interface that the client file systems could easily accomodate might
>take some care (for example, accomodating their locking schemes while
>keeping the interface simple enough so that the client file system
>drivers are still made smaller by using it).

Also a nice idea.



Jan Engelhardt
-- 
No TOFU for me, please.
