Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129727AbRCGAMT>; Tue, 6 Mar 2001 19:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129737AbRCGAMJ>; Tue, 6 Mar 2001 19:12:09 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:41477 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S129727AbRCGALw>; Tue, 6 Mar 2001 19:11:52 -0500
Message-Id: <200103070010.f270ApO14502@aslan.scsiguy.com>
To: "Phil Oester" <kernel@theoesters.com>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Error compiling aic7xxx driver on 2.4.2-ac13 
In-Reply-To: Your message of "Tue, 06 Mar 2001 15:43:22 PST."
             <000f01c0a697$3b1924f0$0200a8c0@theoesters.com> 
Date: Tue, 06 Mar 2001 17:10:51 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>make[5]: Entering directory
>`/usr/src/linux-2.4.2-ac13/drivers/scsi/aic7xxx/aicasm'
>lex  -t aicasm_scan.l > aicasm_scan.c
>gcc -I/usr/include -ldb aicasm_gram.c aicasm_scan.c aicasm.c
>aicasm_symbol.c -o aicasm
>aicasm_symbol.c:39: db/db_185.h: No such file or directory
>make[5]: *** [aicasm] Error 1
>make[5]: Leaving directory
>`/usr/src/linux-2.4.2-ac13/drivers/scsi/aic7xxx/aicasm'

Is it prudent to build the assembler from within the kernel
build?  I'd personally love to ditch the aic7xxx_seq.h and
aic7xxx_reg.h files from the kernel distribution and I even
have the makefiles for version 6.1.6 of the driver.  The only
question is, with so many distributions out there can we rely
on lex, yacc, and berkeley DB existing on the host system?

As to your *real* problem.  My guess is that the dependency
to regenerate the files is getting hit.  This often happens
during a patch upgrade where only one of the two generated files
is updated.  If you touch aic7xxx_reg.h and aic7xxx_seq.h the
build will work fine.  Alternatively, you can figure out how to
get Berekeley DB installed on your system.

--
Justin
