Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291355AbSBNKDz>; Thu, 14 Feb 2002 05:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291397AbSBNKDk>; Thu, 14 Feb 2002 05:03:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48655 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291355AbSBNKCd>;
	Thu, 14 Feb 2002 05:02:33 -0500
Message-ID: <3C6B8B01.E0A3B194@zip.com.au>
Date: Thu, 14 Feb 2002 02:01:37 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: lkml <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] compile fixes
In-Reply-To: <3C6A2F86.E5C322D4@zip.com.au> <Pine.NEB.4.44.0202141036020.25879-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> 
> On Wed, 13 Feb 2002, Andrew Morton wrote:
> 
> > This patch should fix all the remaining .text.exit problems
> > which have resulted from recent binutils changes.   For all
> > files which are accessible to an x86 build.
> >...
> 
> Thanks for your work, I tried to compile non-modular 2.4.18-pre9 with this
> patch and as much as possible enabled. The .text.exit errors are now gone
> with one exception:
> 
> drivers/char/char.o(.data+0xacf4): undefined reference to `local symbols
> in discarded section .text.exit'
> 

Well that's odd.  Perhaps something is configured differently.
Please do this:

	make bzImage

Near the end of the build, see the line 

	ld -m elf_i386 -T  <lots of .o files> -o vmlinux

delete all the .o files which appear that command line.

Now, run

ld -m elf_i386 -T arch/i386/vmlinux.lds $(find . -name '*.o') 2> /tmp/1

Now, go through all the junk in /tmp/1 and search for the text "discarded".
It will mention a filename.   That's the info we want.


Thanks.


-
