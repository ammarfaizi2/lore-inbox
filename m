Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315607AbSETBOZ>; Sun, 19 May 2002 21:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315611AbSETBOY>; Sun, 19 May 2002 21:14:24 -0400
Received: from zok.SGI.COM ([204.94.215.101]:20113 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S315607AbSETBOX>;
	Sun, 19 May 2002 21:14:23 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] improve interaction with ccache 
In-Reply-To: Your message of "Sun, 19 May 2002 19:11:41 EST."
             <Pine.LNX.4.44.0205191906310.30559-100000@chaos.physics.uiowa.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 20 May 2002 11:14:08 +1000
Message-ID: <1764.1021857248@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 May 2002 19:11:41 -0500 (CDT), 
Kai Germaschewski <kai-germaschewski@uiowa.edu> wrote:
>As various people pointed out, ccache is a great win for people compiling 
>a lot of kernels. (For info on ccache, see ccache.samba.org)
>
>Unfortunately, when a kernel tree is moved around / cloned / symlinked, 
>the compiler cache doesn't have many hits, since some header files use 
>BUG(), which in turn uses __FILE__, which currently includes the absolute 
>path to the header file.
>
>The appended patch solves this problem by including the headers a relative 
>path which will not change when the tree is moved.

You are fixing the symptom, not the cause.  The symptom is too many
compiles, people are using ccache to attempt to fix the symptom.  The
cause is a kernel build system that forces people to make clean or
mrproper between builds instead of reusing existing objects.

Fix the cause, not the symptom.

You will find that relative include paths completely stuff up
builds with separate source and object trees.  It will also mess up
people who compile add on code outside the kernel tree, CURDIR is not
related to TOPDIR.

All of these problems are fixed in kbuild 2.5, correctly.

