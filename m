Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267494AbRGZBqE>; Wed, 25 Jul 2001 21:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267500AbRGZBpy>; Wed, 25 Jul 2001 21:45:54 -0400
Received: from zok.SGI.COM ([204.94.215.101]:1203 "EHLO zok.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S267494AbRGZBpj>;
	Wed, 25 Jul 2001 21:45:39 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Leif Sawyer <lsawyer@gci.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Sparc-64 kernel build fails on version.h during 'make oldconfig' 
In-Reply-To: Your message of "Wed, 25 Jul 2001 09:39:46 PST."
             <BF9651D8732ED311A61D00105A9CA315053E1265@berkeley.gci.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 26 Jul 2001 11:45:38 +1000
Message-ID: <15723.996111938@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, 25 Jul 2001 09:39:46 -0800, 
Leif Sawyer <lsawyer@gci.com> wrote:
>When 'bootstrapping' a new kernel:
>
>cp ../oldlinux/.config .
>make oldconfig
>make dep
>...
>/usr/src/linux/include/linux/udf_fs_sb.h:22: linux/version.h: No such file
>or directory

Ignore it, the kernel build design is wrong.  make dep is supposed to
pick up all dependencies on included files but, at the time make dep is
run, generated files have not been created yet.  make dep issues lots
of spurious warning and error messages.  The 2.5 makefile rewrite fixes
the design.  This is not a failure condition, make dep keeps going.

I have no idea why udf_fs_sb.h includes versions.h, it does not use it.
I will follow up with the UDF group.

