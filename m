Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276867AbSIVIuG>; Sun, 22 Sep 2002 04:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276878AbSIVIuG>; Sun, 22 Sep 2002 04:50:06 -0400
Received: from apollo.nbase.co.il ([194.90.137.2]:53254 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP
	id <S276867AbSIVIuF>; Sun, 22 Sep 2002 04:50:05 -0400
Message-ID: <3D8D8660.80905@nbase.co.il>
Date: Sun, 22 Sep 2002 11:59:12 +0300
From: eran@nbase.co.il (Eran Man)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: bart.de.schuymer@pandora.be
Subject: Kernel 2.5.38 EBTables breakage
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems like the EBTables merge in 2.5.38 is incomplete:
....
   gcc -Wp,-MD,./.ebtables.o.d -D__KERNEL__ 
-I/usr/src/linux-2.5.25/include -Wall -Wstrict-prototypes -Wno-trigraphs 
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 
-I/usr/src/linux-2.5.25/arch/i386/mach-generic -nostdinc -iwithprefix 
include -DMODULE   -DKBUILD_BASENAME=ebtables -DEXPORT_SYMTAB  -c -o 
ebtables.o ebtables.c
ebtables.c:25:45: linux/netfilter_bridge/ebtables.h: No such file or 
directory
ebtables.c:85: variable `ebt_standard_target' has initializer but 
incomplete type
ebtables.c:86: extra brace group at end of initializer
ebtables.c:86: (near initialization for `ebt_standard_target')
ebtables.c:86: warning: excess elements in struct initializer
ebtables.c:86: warning: (near initialization for `ebt_standard_target')
ebtables.c:86: `EBT_STANDARD_TARGET' undeclared here (not in a function)
ebtables.c:86: warning: excess elements in struct initializer
ebtables.c:86: warning: (near initialization for `ebt_standard_target')
ebtables.c:86: warning: excess elements in struct initializer
ebtables.c:86: warning: (near initialization for `ebt_standard_target')
ebtables.c:86: warning: excess elements in struct initializer
ebtables.c:86: warning: (near initialization for `ebt_standard_target')
ebtables.c:86: warning: excess elements in struct initializer
ebtables.c:86: warning: (near initialization for `ebt_standard_target')
ebtables.c:86: warning: excess elements in struct initializer
ebtables.c:86: warning: (near initialization for `ebt_standard_target')
ebtables.c:90: warning: `struct ebt_entry_watcher' declared inside 
parameter list
ebtables.c:90: warning: its scope is only this definition or 
declaration, which is probably not what you want.
ebtables.c: In function `ebt_do_watcher':
ebtables.c:92: dereferencing pointer to incomplete type
ebtables.c:92: dereferencing pointer to incomplete type
ebtables.c:93: dereferencing pointer to incomplete type
ebtables.c: At top level:
ebtables.c:100: warning: `struct ebt_entry_match' declared inside 
parameter list
ebtables.c: In function `ebt_do_match':
ebtables.c:102: dereferencing pointer to incomplete type
ebtables.c:102: dereferencing pointer to incomplete type
ebtables.c:103: dereferencing pointer to incomplete type
.....
This goes on for a couple more pages...
On the otherhand, there is no real sign of the ebtables in include/linux:
[eran@eran linux-2.5]$ grep -ri EBT_STANDARD_TARGET include/linux/
[eran@eran linux-2.5]$ grep -ri ebtables include/linux/
include/linux/netfilter_bridge.h:/* Not really a hook, but used for the 
ebtables broute table */
include/linux/autoconf.h:#undef  CONFIG_BRIDGE_NF_EBTABLES
[eran@eran linux-2.5]$
-- 
Eran Mann                 Direct  : 972-4-9936297
Senior Software Engineer  Fax     : 972-4-9890430
Optical Access            Email   : emann@opticalaccess.com




