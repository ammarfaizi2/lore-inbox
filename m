Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267674AbUBSCVZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 21:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267687AbUBSCVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 21:21:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:40328 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267674AbUBSCVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 21:21:14 -0500
Date: Wed, 18 Feb 2004 18:13:50 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "sting sting" <zstingx@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: build error : drivers/char/char.o(__ksymtab+0x110): undefined
 reference to `
Message-Id: <20040218181350.0cdd95ab.rddunlap@osdl.org>
In-Reply-To: <Sea2-F133D4rGVcMNKW000372f6@hotmail.com>
References: <Sea2-F133D4rGVcMNKW000372f6@hotmail.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004 23:35:53 +0200 "sting sting" <zstingx@hotmail.com> wrote:

| Hello,
| I am trying to add a test module to the kernel image (2.4.20).
| I wrote a simple module, named test.c; I do succeed to build it as a module,
| perform insmod and rmmod twith it, etc.
| 
| Now I want it to be a part of the kernel Image.
| The kernel itself does pass full build successfully without this change.
| 
| I had put test.c under drivers/char;
| I had added it in the makefile under drivers/char
| in the follwoing way
| 
| obj-$(CONFIG_TEST) += test.o
| 
| In config.in under drivers/char I had put :
|    tristate 'test' CONFIG_TEST
| 
| I had run make menuconfig and selceted this character device (test) with *.
| 
| 
| Now when I try to compile it I have an error  about export_symbol.
| Since this module that have a call to the EXPORT_SYMBOL
| macro, I had tried to add it to the list of export-objs in that Makefile 
| (under /drivers/char)
| but Now , when running make , I have the follwoing error:
| 
| rivers/char/char.o(__ksymtab+0x110): undefined reference to `local symbols 
| in discarded section .text.exit'
| make: *** [vmlinux] Error 1
| 
| any idea which can help will be appreciated.

What kernel symbols are you trying to use?
What are you tring to EXPORT?

It mostly looks like something in your main .text section is calling
(or using) something that's in another code section or vice versa.

You might see if one of the scripts from
http://www.kernelnewbies.org/scripts/
will help you.  I can't reach that web site right now, but there
are a couple of scripts there (reference-discarded.pl and
reference-init.pl) that might help you.

or you can always post source code so that we won't have to guess
whatever it is you are doing.

--
~Randy
kernel-janitors project:  http://janitor.kernelnewbies.org/
