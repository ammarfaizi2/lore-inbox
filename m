Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266451AbUGUPVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266451AbUGUPVA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 11:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266505AbUGUPVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 11:21:00 -0400
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:14821 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S266451AbUGUPUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 11:20:52 -0400
Message-ID: <313680C9A886D511A06000204840E1CF08F4304E@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'Hollis Blanchard'" <hollisb@us.ibm.com>
Cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>,
       crossgcc <crossgcc@sources.redhat.com>,
       "'bertrand marquis'" <bertrand_marquis@yahoo.fr>,
       "'trevor_scroggins@hotmail.com'" <trevor_scroggins@hotmail.com>,
       "'Dan Kegel'" <dank@kegel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: RE:  Re: missing elf.h (for mk_elfconfig.c)  while  building zIma
	ge for PPC on Intel platform (windows XP) using cygwin
Date: Wed, 21 Jul 2004 11:16:09 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hollis,

You are correct. It looks for /usr/include/elf.h. It is not a case of
missing (altogether) elf.h - it is just misconfiguration issue (files are
looked in a wrong directories - another menuconfig problem ?)

As a proof of that - I copied existent elf.h include file from
\linux-2.6.7\include\linux 
to /usr/include/elf.h (there was no elf.h there originally ...) - and
compilation moved forward for one step -
now it can not find linux/types.h, the one which "lives" (I think) in
\linux-2.6.7\include\linux, and asm/elf.h, the one which "lives" (I think)
in \linux-2.6.7\include\asm-ppc 

$ make zImage
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/split-include
  HOSTCC  scripts/basic/docproc
  HOSTCC  scripts/conmakehash
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/mk_elfconfig
In file included from scripts/mk_elfconfig.c:4:
/usr/include/elf.h:4:25: linux/types.h: No such file or directory
/usr/include/elf.h:5:21: asm/elf.h: No such file or directory
In file included from scripts/mk_elfconfig.c:4:
/usr/include/elf.h:8: error: syntax error before "Elf32_Addr"
/usr/include/elf.h:9: error: syntax error before "Elf32_Half"
/usr/include/elf.h:10: error: syntax error before "Elf32_Off"
/usr/include/elf.h:11: error: syntax error before "Elf32_Sword"
/usr/include/elf.h:12: error: syntax error before "Elf32_Word"
/usr/include/elf.h:15: error: syntax error before "Elf64_Addr"
/usr/include/elf.h:16: error: syntax error before "Elf64_Half"
/usr/include/elf.h:17: error: syntax error before "Elf64_SHalf"
/usr/include/elf.h:18: error: syntax error before "Elf64_Off"
/usr/include/elf.h:19: error: syntax error before "Elf64_Sword"
/usr/include/elf.h:20: error: syntax error before "Elf64_Word"
/usr/include/elf.h:21: error: syntax error before "Elf64_Xword"
/usr/include/elf.h:22: error: syntax error before "Elf64_Sxword"
/usr/include/elf.h:170: error: syntax error before "Elf32_Sword"
/usr/include/elf.h:172: error: syntax error before "Elf32_Sword"
/usr/include/elf.h:175: error: syntax error before '}' token
/usr/include/elf.h:178: error: syntax error before "Elf64_Sxword"
/usr/include/elf.h:180: error: syntax error before "Elf64_Xword"
/usr/include/elf.h:183: error: syntax error before '}' token
/usr/include/elf.h:193: error: syntax error before "Elf32_Addr"
/usr/include/elf.h:198: error: syntax error before "Elf64_Addr"
/usr/include/elf.h:203: error: syntax error before "Elf32_Addr"
/usr/include/elf.h:205: error: syntax error before "r_addend"
/usr/include/elf.h:209: error: syntax error before "Elf64_Addr"
/usr/include/elf.h:211: error: syntax error before "r_addend"
/usr/include/elf.h:215: error: syntax error before "Elf32_Word"
/usr/include/elf.h:217: error: syntax error before "st_size"
/usr/include/elf.h:220: error: syntax error before "st_shndx"
/usr/include/elf.h:224: error: syntax error before "Elf64_Word"
/usr/include/elf.h:227: error: syntax error before "st_shndx"
/usr/include/elf.h:228: error: syntax error before "st_value"
/usr/include/elf.h:229: error: syntax error before "st_size"
/usr/include/elf.h:237: error: syntax error before "Elf32_Half"
/usr/include/elf.h:239: error: syntax error before "e_version"
/usr/include/elf.h:240: error: syntax error before "e_entry"
/usr/include/elf.h:241: error: syntax error before "e_phoff"
/usr/include/elf.h:242: error: syntax error before "e_shoff"
/usr/include/elf.h:243: error: syntax error before "e_flags"
/usr/include/elf.h:244: error: syntax error before "e_ehsize"
/usr/include/elf.h:245: error: syntax error before "e_phentsize"
/usr/include/elf.h:246: error: syntax error before "e_phnum"
/usr/include/elf.h:247: error: syntax error before "e_shentsize"
/usr/include/elf.h:248: error: syntax error before "e_shnum"
/usr/include/elf.h:249: error: syntax error before "e_shstrndx"
/usr/include/elf.h:254: error: syntax error before "Elf64_Half"
/usr/include/elf.h:256: error: syntax error before "e_version"
/usr/include/elf.h:257: error: syntax error before "e_entry"
/usr/include/elf.h:258: error: syntax error before "e_phoff"
/usr/include/elf.h:259: error: syntax error before "e_shoff"
/usr/include/elf.h:260: error: syntax error before "e_flags"
/usr/include/elf.h:261: error: syntax error before "e_ehsize"
/usr/include/elf.h:262: error: syntax error before "e_phentsize"
/usr/include/elf.h:263: error: syntax error before "e_phnum"
/usr/include/elf.h:264: error: syntax error before "e_shentsize"
/usr/include/elf.h:265: error: syntax error before "e_shnum"
/usr/include/elf.h:266: error: syntax error before "e_shstrndx"
/usr/include/elf.h:276: error: syntax error before "Elf32_Word"
/usr/include/elf.h:278: error: syntax error before "p_vaddr"
/usr/include/elf.h:279: error: syntax error before "p_paddr"
/usr/include/elf.h:280: error: syntax error before "p_filesz"
/usr/include/elf.h:281: error: syntax error before "p_memsz"
/usr/include/elf.h:282: error: syntax error before "p_flags"
/usr/include/elf.h:283: error: syntax error before "p_align"
/usr/include/elf.h:287: error: syntax error before "Elf64_Word"
/usr/include/elf.h:289: error: syntax error before "p_offset"
/usr/include/elf.h:290: error: syntax error before "p_vaddr"
/usr/include/elf.h:291: error: syntax error before "p_paddr"
/usr/include/elf.h:292: error: syntax error before "p_filesz"
/usr/include/elf.h:293: error: syntax error before "p_memsz"
/usr/include/elf.h:294: error: syntax error before "p_align"
/usr/include/elf.h:332: error: syntax error before "Elf32_Word"
/usr/include/elf.h:334: error: syntax error before "sh_flags"
/usr/include/elf.h:335: error: syntax error before "sh_addr"
/usr/include/elf.h:336: error: syntax error before "sh_offset"
/usr/include/elf.h:337: error: syntax error before "sh_size"
/usr/include/elf.h:338: error: syntax error before "sh_link"
/usr/include/elf.h:339: error: syntax error before "sh_info"
/usr/include/elf.h:340: error: syntax error before "sh_addralign"
/usr/include/elf.h:341: error: syntax error before "sh_entsize"
/usr/include/elf.h:345: error: syntax error before "Elf64_Word"
/usr/include/elf.h:347: error: syntax error before "sh_flags"
/usr/include/elf.h:348: error: syntax error before "sh_addr"
/usr/include/elf.h:349: error: syntax error before "sh_offset"
/usr/include/elf.h:350: error: syntax error before "sh_size"
/usr/include/elf.h:351: error: syntax error before "sh_link"
/usr/include/elf.h:352: error: syntax error before "sh_info"
/usr/include/elf.h:353: error: syntax error before "sh_addralign"
/usr/include/elf.h:354: error: syntax error before "sh_entsize"
/usr/include/elf.h:405: error: syntax error before "Elf32_Word"
/usr/include/elf.h:407: error: syntax error before "n_type"
/usr/include/elf.h:412: error: syntax error before "Elf64_Word"
/usr/include/elf.h:414: error: syntax error before "n_type"
/usr/include/elf.h:426: error: syntax error before "_DYNAMIC"
/usr/include/elf.h:426: warning: array `_DYNAMIC' assumed to have one eleme
make[1]: *** [scripts/mk_elfconfig] Error 1
make: *** [scripts] Error 2

-----Original Message-----
From: Hollis Blanchard [mailto:hollisb@us.ibm.com]
Sent: Wednesday, July 21, 2004 10:01 AM
To: Povolotsky, Alexander
Cc: 'linuxppc-dev@lists.linuxppc.org'; crossgcc; 'bertrand marquis';
'trevor_scroggins@hotmail.com'; 'Dan Kegel'; Linux Kernel list
Subject: Re: missing elf.h (for mk_elfconfig.c) while building zImage
for PPC on Intel platform (windows XP) using cygwin


On Jul 21, 2004, at 6:28 AM, Povolotsky, Alexander wrote:
>
> Now I am facing the next problem: missing elf.h (for mk_elfconfig.c) 
> while
> building zImage for PPC on Intel platform (windows XP) using cygwin.
>
> $ make zImage
>   SPLIT   include/linux/autoconf.h -> include/config/*
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/basic/split-include
>   HOSTCC  scripts/basic/docproc
>   HOSTCC  scripts/conmakehash
>   HOSTCC  scripts/kallsyms
>   CC      scripts/empty.o
>   HOSTCC  scripts/mk_elfconfig
> scripts/mk_elfconfig.c:4:17: elf.h: No such file or directory

I also saw this problem when trying to cross-build from Mac OS X a 
while ago. A couple build tools assume the existence of 
/usr/include/elf.h ... (adding LKML to cc)

-- 
Hollis Blanchard
IBM Linux Technology Center
-----Original Message-----
From: Dan Kegel [mailto:dank@kegel.com]
Sent: Wednesday, July 21, 2004 8:44 AM
To: Povolotsky, Alexander
Cc: 'crossgcc@sources.redhat.com'
Subject: Re: missing elf.h for mk_elfconfig.c while building zImage for
PPC on Intel platform (windows XP) using cygwin


Povolotsky, Alexander wrote:
> I have made changes in linux-2.6/scripts/kconfig/Makefile as advised and
it
> did fix menuconfig problem - thank you very much for being kind and
patient
> helping - much appreciated !
> 
> Now I am facing the next problem: missing elf.h (for mk_elfconfig.c) while
> building zImage for PPC on Intel platform (windows XP) using cygwin.
> ...
> scripts/mk_elfconfig.c:4:17: elf.h: No such file or directory
>
> From where I could pick-up this include file ?

In other words, download and install
   http://www.gnu.org/directory/libs/misc/libelf.html
which will I think provide <gelf.h>;
you can then make an elf.h that just does
   #include <gelf.h>
and you should be good to go.  (I haven't tried it myself.)
- Dan
