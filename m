Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312601AbSFEHjC>; Wed, 5 Jun 2002 03:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312498AbSFEHjA>; Wed, 5 Jun 2002 03:39:00 -0400
Received: from rj.SGI.COM ([192.82.208.96]:39581 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S313477AbSFEHih>;
	Wed, 5 Jun 2002 03:38:37 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Joseph Pingenot <trelane@digitasaru.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Build error on 2.5.20 under unstable debian 
In-Reply-To: Your message of "Wed, 05 Jun 2002 02:25:59 EST."
             <20020605022558.A2745@ksu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 05 Jun 2002 17:38:26 +1000
Message-ID: <23055.1023262706@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002 02:25:59 -0500, 
Joseph Pingenot <trelane@digitasaru.net> wrote:
>Hey, thanks for the nifty tool.  What docs are available so that I can
>  learn the Magic of the Script?  :)

Years of hacking on ELF formats :(

>Error: ./drivers/usb/host/uhci-hcd.o .rodata refers to 00000f98 R_386_32          .text.exit
>Error: ./drivers/usb/host/built-in.o .rodata refers to 00000f98 R_386_32          .text.exit

Ignore drivers/usb/host/built-in.o, it is a conglomerate that contains
one object, the script cannot distinguish between that and a normal
object.

>Looks like uhci-hcd.o and built-in.o are the culprits.  Now, if only
>  I knew what the rest meant.  :)  They're referring to a symbol 
>  R_386_32?  I'm going to assume this is an x86-based bit of stuff
>  included from the x86-specific stuff.  Teach me.  ;)

R_386_32 is an ELF relocation type for ix86 binaries.  It means that
uhci-hcd.c has code that refers to a function defined as __exit.  The
only such function is uhci_hcd_cleanup but I cannot see where it is
being referenced.  The USB people should be able to track this one
down.

