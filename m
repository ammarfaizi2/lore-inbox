Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266919AbRGTKxa>; Fri, 20 Jul 2001 06:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266921AbRGTKxU>; Fri, 20 Jul 2001 06:53:20 -0400
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:4349 "EHLO
	tabby.cats-chateau.net") by vger.kernel.org with ESMTP
	id <S266919AbRGTKxK>; Fri, 20 Jul 2001 06:53:10 -0400
From: Jesse Pollard <jesse@cats-chateau.net>
Reply-To: jesse@cats-chateau.net
To: stimits@idcomm.com, "D. Stimits" <stimits@idcomm.com>,
        kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: bzImage, root device Q
Date: Fri, 20 Jul 2001 05:46:52 -0500
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <3B57E0AB.F5D6B2E2@idcomm.com>
In-Reply-To: <3B57E0AB.F5D6B2E2@idcomm.com>
MIME-Version: 1.0
Message-Id: <01072005531200.07975@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, 20 Jul 2001, D. Stimits wrote:
>When booting to a bzImage kernel, bytes 508 and 509 can be used to name
>the minor and major number of the intended root device (although it can
>be overridden with a command line parameter). Other characteristics are
>also available this way, through bytes in the kernel. rdev makes a
>convenient way to hex edit those bytes.
>
>What I'm more curious about is how does the kernel know what filesystem
>_type_ the root is? Are there similar bytes in the bzImage, and can rdev
>change this? And is there a command line syntax to allow specifying
>filesystem type (e.g., something like "vmlinuz root=/dev/scd0,iso9660"
>or "vmlinuz root=/dev/scd0,xfs")? Or is this limited in some way,
>requiring mount on one or a few known filesystem types ("linux native"
>subset comes to mind), followed by a chroot or pivot_root style command
>(which in turn means no direct root mount of some filesystem types)?

Take a look at fs/super.c - function mount_root().

It reads the file system superblock (from the major/minor specified root
device) and determines the filesystem from that. There is a loop that
cycles through all known (ie built in) file systems until one works.

If none do, then it panics.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: jesse@cats-chateau.net

Any opinions expressed are solely my own.
