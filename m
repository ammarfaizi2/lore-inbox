Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268086AbTAIXMG>; Thu, 9 Jan 2003 18:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268081AbTAIXL2>; Thu, 9 Jan 2003 18:11:28 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:19340 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S268079AbTAIXKV>;
	Thu, 9 Jan 2003 18:10:21 -0500
Date: Fri, 10 Jan 2003 00:18:34 +0100
To: Niels den Otter <Niels.denOtter@surfnet.nl>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: 2.5.55: local symbols in net/ipv6/af_inet6.o
Message-ID: <20030109231834.GD3345@gagarin>
References: <20030109091025.GW31387@surly.surfnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030109091025.GW31387@surly.surfnet.nl>
User-Agent: Mutt/1.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *18WlwY-0003tH-00*xfOO6iAHuXc* (0x63.nu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 10:10:26AM +0100, Niels den Otter wrote:
> The reference_discarded.pl script says following:
>  pangsit:/usr/src/linux/net> perl ~otter/reference_discarded.pl 
>  Finding objects, 245 objects, ignoring 0 module(s)
>  Finding conglomerates, ignoring 11 conglomerate(s)
>  Scanning objects
>  Error: ./ipv6/af_inet6.o .init.text refers to 000003e4 R_386_PC32 .exit.text
>  Done
> 
> I tried both gcc-2.95 & gcc-3.2.2 .

This patch shoul fix it, the problem is that cleanup_ipv6_mibs can't be
__exit as it's called on ipv6_init's errorpath.


-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.901, 2003-01-10 00:10:38+01:00, andersg@0x63.nu
  cleanup_ipv6_mibs can't be __exit, it's called on ipv6_init's errorpath.


 af_inet6.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
--- a/net/ipv6/af_inet6.c	Fri Jan 10 00:11:57 2003
+++ b/net/ipv6/af_inet6.c	Fri Jan 10 00:11:57 2003
@@ -684,7 +684,7 @@
 	
 }
 
-static void __exit cleanup_ipv6_mibs(void)
+static void cleanup_ipv6_mibs(void)
 {
 	kfree_percpu(ipv6_statistics[0]);
 	kfree_percpu(ipv6_statistics[1]);

===================================================================


This BitKeeper patch contains the following changesets:
1.901
## Wrapped with gzip_uu ##


begin 664 bkpatch11850
M'XL(`+T!'CX``\V446O;,!#'GZ-/<="';G2Q[V1%L0P9V=JQC0T6,OH<9%MI
M3&PYV$K:@3_\%">T6]NUK.QALL&GT]_'3[H_.H'+UC3)0-O<-.T5.X%/=>N2
M`=[(*+!;/Y_7M9^'J[HRX5$5KDUC31FFZS`MZVOF53/MLA7L_&HRH""ZS;@?
M&Y,,YA\^7GY]-V=L,H'SE;97YKMQ,)DP5S<[7>;M5+M56=O`-=JVE7$ZR.JJ
MNY5V')'[9T3C"$>R(XEBW&64$VE!)D<N8BG8$6]ZA/_]_P@)%>=<HNI\3))=
M``4*"3`*D4)"0$P(DR@^0TH0X5XY.",8(GL/_Q;ZG&60E4;;[691;'9R415I
M"YFVIPY2`XN%N2G<&RC<Z3Y;EB:'VD*O+&R?-4U3-QL/$[`OP)6BF,WNCID-
M_W(PAAK9VV>V:8T+]Q"A7GH.XV20_;IA-5(=$<:\DZ-4"JX5C7(AXTC=/]8_
M53KT*R(?=()$%/7N>43\O(]>S,K6A2\T+6Q0I-53I?:P8T)2@G>"HQKWYB+U
MP%OXA+?H?_?6H0W?8-A<]Z_WRNRQCKS`<A<R'@.QSX=/Z[0K,MC51?Z0_]4^
;_?KNTLE6)ENWVVJ"8IF))5?L)Q<IQX;5!```
`
end
