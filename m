Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129212AbRBBUB2>; Fri, 2 Feb 2001 15:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129232AbRBBUBS>; Fri, 2 Feb 2001 15:01:18 -0500
Received: from chaos.analogic.com ([204.178.40.224]:7552 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129212AbRBBUBL>; Fri, 2 Feb 2001 15:01:11 -0500
Date: Fri, 2 Feb 2001 15:00:14 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: Version 2.4.1 has ext2 problems.
In-Reply-To: <145C05227023@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.3.95.1010202145559.1715A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2001, Petr Vandrovec wrote:

> On  2 Feb 01 at 14:44, Richard B. Johnson wrote:
> 
> > # rm *
> > rm: cannot remove `#1006': Value too large for defined data type
> > rm: cannot remove `#1057': Value too large for defined data type
> > rm: cannot remove `#1140': Value too large for defined data type
> > ls: #588: Value too large for defined data type
> > [SNIPPED...]
> > 
> > lstat("#1057", 0xbffff2c0)              = -1 EOVERFLOW (Value too large for defined data type)
> 
> Too old fileutils, and maybe glibc. They do not handle >2GB files.
> And 'rm', for some strange reason, first 'lstat' file before removing
> it. As workaround, do:
> 
> cd lost+found
> for a in *; do echo > $a; done
> rm *
> 
> BTW, who created that files? Maybe there is some way to get through
> 2GB limit check without saying O_LARGEFILE? But more probably stupid 
> software using O_LARGEFILE without knowing consequences...
>                                                       Petr Vandrovec
>                                                       vandrove@vc.cvut.cz

Thanks. The work-around was to make another file-system. Unfortunately
truncating a file with `>filename` also fails. The files were created
by e2fsck after a crash with version 2.4.1. The entire file-system
was reduced to junk.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
