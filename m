Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265837AbUFTIkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265837AbUFTIkg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 04:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265840AbUFTIkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 04:40:35 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:5001 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S265837AbUFTIkM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 04:40:12 -0400
From: Rob Landley <rob@landley.net>
To: "Nick Bartos" <spam99@2thebatcave.com>, linux-kernel@vger.kernel.org
Subject: Re: Using kernel headers that are not for the running kernel
Date: Sat, 19 Jun 2004 05:46:50 -0500
User-Agent: KMail/1.5.4
References: <53712.192.168.1.12.1087514884.squirrel@192.168.1.12>
In-Reply-To: <53712.192.168.1.12.1087514884.squirrel@192.168.1.12>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406190546.50166.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 June 2004 18:28, Nick Bartos wrote:
> I have a little distro that I am trying to upgrade to 2.6.x.
>
> The problem is that when I use the headers for 2.6.x, glibc 2.2.5 won't
> compile.  Eventually I want to upgrade glibc/gcc, but not at the moment.
> If I use the headers from 2.4.26 for the system, but just compile the
> 2.6.7 kernel, things do compile fine for everything.

The linux-kernel maintainers apparently decided that C libraries using kernel 
headers to actually interface with the kernel was a bad idea.  Apparently, 
interfacing with the kernel from a C library is not a proper use for kernel 
headers, or something.  (I tried to follow the logic in this discussion, but 
never actually found any, despite repeated attempts.  It always seemed to 
boil down to "can't be bothered", "userspace shouldn't use kernel headers and 
this includes the C library", etc...)

On a pragmatic level, you want the cleaned up 2.6 kernel headers maintained by 
Mariusz Mazur <mmazur@kernel.pl> which you can download from:

http://ep09.pld-linux.org/~mmazur/linux-libc-headers/

> I see that a lot of distros use a separate package for the kernel headers,
> which do not necessarily coincide with the running kernel.

Yup.  It sucks, but there's no alternative for 2.6.

Mazur does a good job, though.

> I am wondering what (if any) are the side effects of doing this are,
> especially when the kernel versions are so different.

You're generally safe using older header versions.  (Heck, you can use 2.4 
headers to build your C library if you like.  The resulting C library just 
won't be able to use various new features like more than 256 minor numbers 
for devices, or possibly the ability to burn with ATA CD-ROM drives without 
SCSI emulation...)

> I was thinking that
> there may be issues with some progs if the prototypes for certain kernel
> functions weren't the same.  However people are doing it and it does seem
> to work, but I am wondering how it fends for stability.

If using old headers didn't work on new kernels then using old binaries 
wouldn't work on new kernels.  And that would be noticed big time.  (We can 
still run binaries that ran on Linux 0.01.  A couple minor things have been 
ripped out over the years, but not much.  The big backwards compatability 
issue is generally making sure you have the relevant old versions of the C 
library installed if you really want to run WordPerfect 6 or Netscape or 
such....)

Rob
-- 
www.linucon.org: Linux Expo and Science Fiction Convention
October 8-10, 2004 in Austin Texas.  (I'm the con chair.)

