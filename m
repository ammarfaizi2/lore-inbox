Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289344AbSAJFk1>; Thu, 10 Jan 2002 00:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289345AbSAJFkR>; Thu, 10 Jan 2002 00:40:17 -0500
Received: from rj.SGI.COM ([204.94.215.100]:33464 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S289344AbSAJFkK>;
	Thu, 10 Jan 2002 00:40:10 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Moving zlib so that others may use it 
In-Reply-To: Your message of "Wed, 09 Jan 2002 23:13:28 MDT."
             <3C3D22F8.1080201@acm.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 10 Jan 2002 16:40:00 +1100
Message-ID: <24675.1010641200@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Jan 2002 23:13:28 -0600, 
Corey Minyard <minyard@acm.org> wrote:
>Hmm.  It worked fine for me.  I made it a module, and it put it into 
>kernel/lib in
>/lib/modules/2.4.17 and it did not put it in lib/lib.a  I make it a 
>non-module, and
>it gets included in lib/lib.a. My diff was the same as yours for the 
>Makefile.

Worked for me this time as well.  I had a typo the first time then did
an ugly fix to a non-existent problem :(

>I don't know about the bootloaders.  I'm not sure you can make the 
>requirement
>to have them compiled the same as the kernel, since they may have different
>compilation requirements in the boot loader.

Probably true, but I don't want to rule it out completely.  In any case
it is easily catered for in lib/Makefile.

obj-$(CONFIG_JFFS2_FS) += zlib.o
obj-$(CONFIG_PPP_DEFLATE) += zlib.o
# Uncomment these if ppc bootloader can use the common zlib
# ifeq ($(ARCH),ppc)
#   obj-y += zlib.o
# endif

>The problem is that if you come along later and compile a new module that
>needs it, it won't work.  That's a fairly common thing I do, I expect 
>other kernel
>developers do the same.  And the dummy ref thing is a little ugly.

Any new module that requires zlib requires a change to the zlib
selection.  Whether you do it in the top level Makefile, in
lib/Config.in or lib/Makefile is irrelevant, zlib has to be selected
somewhere and the criteria must be updated for new modules.

Since lib/zlib.c works for both built in and modules, there is no need
to change the top level Makefile.  AFAICT the above lines in
lib/Makefile are the minimal change.

