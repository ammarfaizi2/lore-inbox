Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265901AbSKOIE1>; Fri, 15 Nov 2002 03:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265939AbSKOIE0>; Fri, 15 Nov 2002 03:04:26 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:49677 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265901AbSKOIEC>; Fri, 15 Nov 2002 03:04:02 -0500
Date: Fri, 15 Nov 2002 06:10:44 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: pavel@suse.cz, Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] swsuspend and CONFIG_DISCONTIGMEM=y
Message-ID: <20021115081044.GI18180@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	pavel@suse.cz, Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=suspend -DKBUILD_MODNAME=suspend -DEXPORT_SYMTAB  -c -o kernel/suspend.o kernel/suspend.c
kernel/suspend.c:295: warning: #warning This might be broken. We need to somehow wait for data to reach the disk
kernel/suspend.c: In function `free_some_memory':
kernel/suspend.c:627: `contig_page_data' undeclared (first use in this function)
kernel/suspend.c:627: (Each undeclared identifier is reported only once
kernel/suspend.c:627: for each function it appears in.)
make[1]: ** [kernel/suspend.o] Erro 1
make: ** [kernel] Erro 2
[acme@oops hell_header-2.5]$ grep CONFIG_DISCONTIGMEM .config
CONFIG_DISCONTIGMEM=y

and in ./mm/page_alloc.c

#ifndef CONFIG_DISCONTIGMEM
static bootmem_data_t contig_bootmem_data;
struct pglist_data contig_page_data = { .bdata = &contig_bootmem_data };

void __init free_area_init(unsigned long *zones_size)
{
        free_area_init_node(0, &contig_page_data, NULL, zones_size, 0, NULL);
        mem_map = contig_page_data.node_mem_map;
}
#endif

So perhaps the following patch is in order? Its kind of brute force, disabling it
altogether, but it at least fixes it for now.

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.851, 2002-11-15 06:07:56-02:00, acme@conectiva.com.br
  o swsusp: depends on CONFIG_DISCONTIGMEM=n


 Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Fri Nov 15 06:09:18 2002
+++ b/arch/i386/Kconfig	Fri Nov 15 06:09:18 2002
@@ -1518,7 +1518,7 @@
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PM
+	depends on EXPERIMENTAL && PM && !DISCONTIGMEM
 	---help---
 	  Enable the possibilty of suspendig machine. It doesn't need APM.
 	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 

===================================================================


This BitKeeper patch contains the following changesets:
1.851
## Wrapped with gzip_uu ##


begin 664 bkpatch30899
M'XL(`*ZKU#T``\V4T6K;,!2&KZ.GT"CT9M@^1[84Q>"1-LG:D*8-:0N#,8:J
M:'%H;`7+2=?AAY^=;$VW;BL;&TP2DM`11[\^_>B`7CM3Q"VE,T,.Z*EU9=S2
M-C>Z7&R4KVWFWQ1U8&IM'0A2FYG@>!2X.[=V*Y///.9S4L<GJM0IW9C"Q2WT
MPX>5\GYEXM9T<')]=C0E)$EH+U7YW%R:DB8)*6VQ4<N9ZZHR7=K<+PN5N\R4
MVY.KAZT5`V!UY=@.@8L*!43M2N,,445H9L`B*:)]MD;F+W,A(@>!(?(*H(,1
MZ5/T)4<*+$`,D%,0,;1C+CQ@,0!M^'2_YT)?(O6`'-._>XT>T=32'>*8SDS#
MV5&;T][%^>OAR?O^\+*>70U/QH-QDI,1%9P))),]6N+]9B$$%)!7]--BM3++
M[G*1KS]ZF9"WOBWF;[]>[UVE"IT&BU"*8%3#^+"8[VA""!"%#&7%(B%E)9"%
M*$'==)"W!>@?X_M9MN9M)(B052`Z`%O7/-G:N.<?J27%VI7WW:;7MEAMU:KU
M\WF;TJZ51Q5PR>3.4]\Z2L0A>]91^!\XJN%^0;WB;MMJ@TR>/L$?N*R/G"%%
M,OPRMAYI&;R9#*;#\>#\ZNB,'A[2R;CI7SS6MO]I=&KTK5MG"<=(1EPQ\AD,
'L(Q2R@0`````
`
end


