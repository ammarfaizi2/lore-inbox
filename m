Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267202AbSKXMIj>; Sun, 24 Nov 2002 07:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267203AbSKXMIj>; Sun, 24 Nov 2002 07:08:39 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:15881 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267202AbSKXMIi>; Sun, 24 Nov 2002 07:08:38 -0500
Date: Sun, 24 Nov 2002 13:15:46 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Jerry McBride <mcbrides9@comcast.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: LEX = flex
Message-ID: <20021124121546.GA16407@louise.pinerecords.com>
References: <0H6200FDECOBEI@mtaout05.icomcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0H6200FDECOBEI@mtaout05.icomcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's an old one... and it's STILL HERE!
> 2.4.20-rc3... 
> make kernel on i386 fails in /drivers/scsi/aic7xxx/aicasm/Makefile
> LEX is not assigned a value... 
> However making LEX=flex works and make modules completes 100%... 

Just do
(cd $(dirname $(which flex)) && ln -s flex lex)

There's another problem, though:

make[5]: Entering directory `/home/kala/lx/linux-2.4.20-rc3/drivers/scsi/aic7xxx/aicasm'
yacc -d -b aicasm_gram aicasm_gram.y
mv aicasm_gram.tab.c aicasm_gram.c
mv aicasm_gram.tab.h aicasm_gram.h
yacc -d -b aicasm_macro_gram -p mm aicasm_macro_gram.y
mv aicasm_macro_gram.tab.c aicasm_macro_gram.c
mv aicasm_macro_gram.tab.h aicasm_macro_gram.h
yacc -d -b aicasm_macro_gram -p mm aicasm_macro_gram.y
mv aicasm_macro_gram.tab.c aicasm_macro_gram.c
mv aicasm_macro_gram.tab.h aicasm_macro_gram.h
lex  -oaicasm_scan.c aicasm_scan.l
lex  -Pmm -oaicasm_macro_scan.c aicasm_macro_scan.l
gcc -I/usr/include -I. -ldb aicasm.c aicasm_symbol.c aicasm_gram.c aicasm_macro_gram.c aicasm_scan.c aicasm_macro_scan.c -o aicasm
/tmp/ccwpPZ3E.o: In function `symtable_open':
/tmp/ccwpPZ3E.o(.text+0x1df): undefined reference to `__db185_open'
collect2: ld returned 1 exit status
make[5]: *** [aicasm] Error 1
make[5]: Leaving directory `/home/kala/lx/linux-2.4.20-rc3/drivers/scsi/aic7xxx/aicasm'

-- 
Tomas Szepe <szepe@pinerecords.com>
