Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266228AbTAJVel>; Fri, 10 Jan 2003 16:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266257AbTAJVel>; Fri, 10 Jan 2003 16:34:41 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:20714 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S266228AbTAJVed>; Fri, 10 Jan 2003 16:34:33 -0500
Date: Fri, 10 Jan 2003 15:42:16 -0600 (CST)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Adrian Bunk <bunk@fs.tum.de>
cc: Sam Ravnborg <sam@ravnborg.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5: Link errors are shown in the wrong files
In-Reply-To: <20030110202649.GP6626@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0301101538270.1754-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2003, Adrian Bunk wrote:

> I'm doing regular compile tests with 2.4 and 2.5 kernels to catch and 
> either fix or report compile errors.
> 
> Since several revisions 2.5 has the _very_ annoying behavior of showing 
> link errors in the wrong files. This makes finding the cause of the 
> problems harder.

> drivers/built-in.o(.init.text+0x51901):/home/bunk/linux/kernel-2.5/linux-2.5.55/drivers/atm/lanai.c: 
> undefined reference to `_ebss'
> [...]

> I'm using the gcc 2.95 and binutils 2.13.90.0.16 from Debian unstable.

Here I get e.g.

drivers/built-in.o: In function `isdn_audio_put_dle_code':
drivers/built-in.o(.text+0xe2247): undefined reference to `save_flags'
drivers/built-in.o(.text+0xe224c): undefined reference to `cli'
drivers/built-in.o(.text+0xe226f): undefined reference to `restore_flags'

which is actually correct. My ld doesn't output the name of the file the 
function was in at all, though. I'm rather sure that you're hitting a 
binutils bug, possibly triggered by the use of the ld during the kernel 
build, which creates multiple levels of composite objects (ld -r) before 
the final link.

Maybe you updated binutils and that's when the problems started?

--Kai



