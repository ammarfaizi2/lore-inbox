Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267068AbTBHT0z>; Sat, 8 Feb 2003 14:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267072AbTBHT0z>; Sat, 8 Feb 2003 14:26:55 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:62871 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267068AbTBHT0y>; Sat, 8 Feb 2003 14:26:54 -0500
Date: Sat, 8 Feb 2003 13:36:27 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Thomas Molina <tmolina@cox.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: compile error with 2.5.59-bk latest
In-Reply-To: <Pine.LNX.4.44.0302081017260.3031-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0302081332120.25000-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Feb 2003, Thomas Molina wrote:

> ld:arch/i386/kernel/.tmp_i386_ksyms.ver:7: ignoring invalid character `#' in expression
> ld:arch/i386/kernel/.tmp_i386_ksyms.ver:7: parse error
> make[1]: *** [arch/i386/kernel/i386_ksyms.o] Error 1
> make: *** [arch/i386/kernel] Error 2

> arch/i386/kernel/.tmp_i386_ksyms.ver shows:
> 
> __crc_cpu_gdt_table = 0x08a58dfb ;
> __crc_drive_info = 0x744aa133 ;
> __crc_boot_cpu_data = 0xd1395717 ;
> __crc_EISA_bus = 0x7413793a ;
> __crc_MCA_bus = 0xf48a2c4c ;
> __crc___verify_write = 0x203afbeb ;
> #define __verify_write	_set_ver(__verify_write)
> __crc_dump_thread = 0xae90b20c ;
> __crc_dump_fpu = 0xc708c72b ;

Whoops, the grep to filter out the _set_ver lines wasn't quite right.
This patch fixes it.

Thanks for the report,

--Kai


===== scripts/Makefile.build 1.27 vs edited =====
--- 1.27/scripts/Makefile.build	Fri Feb  7 21:27:28 2003
+++ edited/scripts/Makefile.build	Sat Feb  8 13:30:23 2003
@@ -91,7 +91,7 @@
 	else								      \
 		$(CPP) -D__GENKSYMS__ $(c_flags) $<			      \
 		| $(GENKSYMS) -k $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)	      \
-		| grep __ver						      \
+		| grep -v _set_ver					      \
 		| sed 's/\#define __ver_\([^ 	]*\)[ 	]*\([^ 	]*\)/__crc_\1 = 0x\2 ;/g' \
 		> $(@D)/.tmp_$(@F:.o=.ver);				      \
 									      \


