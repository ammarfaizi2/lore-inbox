Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262620AbSJTIDC>; Sun, 20 Oct 2002 04:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbSJTIDC>; Sun, 20 Oct 2002 04:03:02 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:33032 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262620AbSJTIDB>;
	Sun, 20 Oct 2002 04:03:01 -0400
Date: Sun, 20 Oct 2002 10:08:51 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: More Makefile Misery
Message-ID: <20021020100851.A2191@mars.ravnborg.org>
Mail-Followup-To: Russell King <rmk@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org
References: <20021020012750.C21819@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021020012750.C21819@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sun, Oct 20, 2002 at 01:27:50AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 01:27:50AM +0100, Russell King wrote:
> When running make clean on an ARM tree, I get:
> 
> make[1]: *** No rule to make target `arch/arm/mach-/Makefile'.  Stop.
> 
> Seeing as we have many mach-* directories, and the relevant one is
> selected by the relevant .config file.
> 
> I see two options:
> 
> - recurse into the correct one somehow, given that the .config file may
>   have changed since the kernel tree was built.
> - recurse into all mach-* directories for make clean and not for the
>   normal build
The cure is simple.
Make sure that MACHINE is always assined a sensible value.

MACHINE := sa1100 # Default value to avoid invalid pathnames with no .config

The recursion into the subdirectories does only take care of files listed
with EXTRA_TARGETS, host-progs, and clean-files.
Only EXTRA_TARGETS are used in the mach- Makefile, and since this is a
*.o file it will anyway be deleted by the find that searches the full
tree when you do a make clean.
Make clean execute a find -name '*.[oas]' and remove all such files,
and use the recursion only to take care of other generated files
spread out over the kernel src tree.

	Sam
