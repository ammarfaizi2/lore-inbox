Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315527AbSECBdg>; Thu, 2 May 2002 21:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315528AbSECBdf>; Thu, 2 May 2002 21:33:35 -0400
Received: from zok.SGI.COM ([204.94.215.101]:12978 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S315527AbSECBdf>;
	Thu, 2 May 2002 21:33:35 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: Your message of "Thu, 02 May 2002 21:19:53 -0400."
             <Pine.LNX.4.40.0205022117350.17239-100000@ccs.covici.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 May 2002 11:33:27 +1000
Message-ID: <3319.1020389607@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2002 21:19:53 -0400 (EDT), 
John Covici <covici@ccs.covici.com> wrote:
>So what should it point to?  I have had more trouble when some Debian
>package made it not a symlink and if I tried to compile something
>which needed correct headers for the version I am using I get very
>strange errors which are hard to diagnose.

Linus has spoken.  /usr/include/{linux,asm} must not be a symlink that
points to kernel code that is updated.  glibc must contain the linux
and asm files that were used to build glibc and those files must not
change until you change glibc.  glibc must take a copy of the kernel
headers at glibc build time or (much less desirable) it can symlink to
a set of kernel headers that are guaranteed to never change.

Having glibc linking to some random set of kernel headers is a recipe
for disaster.  kbuild 2.5 deliberately handles the asm symlink
differently from the old kbuild system, to detect and correct broken
installations.

