Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbTJFUrv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 16:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbTJFUr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 16:47:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:55250 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261681AbTJFUrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 16:47:03 -0400
X-Authenticated: #1033915
Message-ID: <3F81D4C4.6050004@GMX.li>
Date: Mon, 06 Oct 2003 22:47:00 +0200
From: Jan Schubert <Jan.Schubert@GMX.li>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031005
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kai Germaschewski <kai.germaschewski@unh.edu>
CC: linux-kernel@vger.kernel.org, kernelnewbies@vger.kernel.org
Subject: Re: Q: Maintainer for drivers/isdn/hisax in kernel-2.6
References: <Pine.LNX.4.44.0310061107140.16435-100000@chaos.sr.unh.edu>
In-Reply-To: <Pine.LNX.4.44.0310061107140.16435-100000@chaos.sr.unh.edu>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:

>I'm still there to take questions and review patches.
>
Kai, sorry for bothering you, but right now i'm stuck in the process of 
building an kernel-2.6-module for an Teles PCMCIA-Card. I guess my 
questions are not that ISDN-specific but more basically in building 
kernel-modules (especialy in drivers/isdn/hisax). There are some 
comments from my side about the current state of the code.

OK, but let's start:

According to David Hinds - the Maintainer of pcmcia-cs - in kernel 2.6 
it's no more possible to include any module in the pcmcia-cs package. 
There where such a module for pcmcia-cs in the past, which worked well 
in kernel 2.0, 2.2 and 2.4, Actually it was'nt included in pcmcia-cs but 
an patch against (with little extensions from my side to run in kernel 
2.2 and later in 2.4). Based on this module I've created an module for 
kernel-2.6, and there the problems begun. I've also checked some other 
modules in the kernel-tree but could'nt get enlighted. In 
drivers/isdn/hisax i added an Kernel-Option (CONFIG_) HISAX_TELES_CS to 
Kconfig, to the Makefile, to drivers/isdn/hisax/config.c and added a new 
file teles_cs.c. The Kernel-Option seems to be well interpreted in the 
Makefile, but not in config.c.
First Question: Why is that?

Second Question: What is config.c for? I defined some functions as 
extern there (which actually defined in teles_cs.c), which are not known 
by hisax.o (teles_cs.o also linked against):

scripts/modpost vmlinux drivers/isdn/hisax/hisax.o 
drivers/ide/legacy/ide-cs.o drivers/isdn/i4l/isdn.o 
drivers/isdn/i4l/isdn_bsdcomp.o drivers/isdn/hisax/teles_cs.o
*** Warning: "init_teles_cs" [drivers/isdn/hisax/hisax.ko] undefined!

Third Question: Why does my teles_cs.o knows nothing about 
hisax_init_pcmcia which is also defined in config.c (not defined by me) 
and defined external in teles_cs.c (which compiles fine):

Oct  6 22:27:06 Toral kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Oct  6 22:27:06 Toral kernel: cs: IO port probe 0x0800-0x08ff: excluding 
0x800-0x817 0x828-0x837 0x840-0x84f 0x860-0x877 0x880-0x88f 0x898-0x89f 
0x8a8-0x8cf 0x8e0-0x8ff
Oct  6 22:27:06 Toral kernel: cs: IO port probe 0x0100-0x04ff: excluding 
0x270-0x277 0x3f8-0x3ff 0x4d0-0x4d7
Oct  6 22:27:06 Toral kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Oct  6 22:27:14 Toral kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Oct  6 22:27:16 Toral kernel: ISDN subsystem initialized
Oct  6 22:27:16 Toral kernel: hisax: Unknown symbol init_teles_cs
Oct  6 22:27:16 Toral kernel: hisax: Unknown symbol init_teles_cs
Oct  6 22:27:16 Toral kernel: teles_cs: Unknown symbol hisax_init_pcmcia

Back to 2nd Question: What is config.c for and where is it used? 
Actually i've some ideas for what it is for, but the results are not as 
expected by me (see above)...

Comments: IMHO some of the files in drivers/isdn/hisax will not be used. 
Example: the Option CONFIG_HISAX_ELSA_CS will not be used outside 
Kconfig and the Makefile so you will get an "HiSax: Support for %s Card 
not selected\n" from config.c.  Also some functions from elsa_cs.c are 
outdated (IMHO) - i've tried to apply this file to my teles_cs.c which 
resulted in some compile-errors...

Thx for any help,
Jan

