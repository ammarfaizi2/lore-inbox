Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267263AbSK3P3w>; Sat, 30 Nov 2002 10:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267261AbSK3P3w>; Sat, 30 Nov 2002 10:29:52 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:56077 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S267263AbSK3P3v>; Sat, 30 Nov 2002 10:29:51 -0500
Date: Sat, 30 Nov 2002 13:36:00 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Serge Kuznetsov <sk@deeptown.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] arp: fix seq_file handling bug
Message-ID: <20021130153600.GF30931@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>,
	Serge Kuznetsov <sk@deeptown.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

	Please pull from:

bk://kernel.bkbits.net/acme/net-2.5

	Now there is just this outstanding changeset. Now I have
some time to devote to fixing /proc/net/tcp seq_file handling.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.864, 2002-11-30 13:30:49-02:00, acme@conectiva.com.br
  o arp: fix seq_file handling bug
  
  When midnigth commander viewer is invoked it first opens the file, read
  4 bytes (probably looking for a magic number), reading only 4 bytes makes
  state->is_pneigh not to be set neither the lock is taken, because only
  the header is being produced (v = (void *)1), so when arp_seq_stop is 
  called the lock is dropped without having being taken: b00m
  
  Thanks to Serge Kuznetsov for reporting this to me. Other seq_file
  code may have this problem, but by using mc viewer in all of /proc/net
  I haven't been able to reproduce this problem with any other file.


 arp.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/net/ipv4/arp.c b/net/ipv4/arp.c
--- a/net/ipv4/arp.c	Sat Nov 30 13:31:52 2002
+++ b/net/ipv4/arp.c	Sat Nov 30 13:31:52 2002
@@ -1282,7 +1282,7 @@
 {
 	struct arp_iter_state* state = seq->private;
 
-	if (!state->is_pneigh)
+	if (!state->is_pneigh && v != (void *)1)
 		read_unlock_bh(&arp_tbl.lock);
 }
 

===================================================================


This BitKeeper patch contains the following changesets:
1.864
## Wrapped with gzip_uu ##


begin 664 bkpatch432
M'XL(`.G9Z#T``^U6[V_;-A#];/X55Q3HTJV62?V*+<!%UG;8B@QHD*[8AV$(
M*.IL$99$C:25>=`?OZ.\I&D:(%BQ+P-J"Q9`WKU[]\A[\%/XX-`6,ZE:9$_A
M)^-\,5.F0^7U("-EVJBTM'%I#&TL:M/BXM7YHD,_CZ.,T<Z%]*J&`:TK9B)*
M;E?\H<=B=OG#CQ]^_OZ2L?4:7M>RV^)[]+!>,V_L()O*G4E?-Z:+O)6=:]%/
M-<?;T#'F/*9O)DX3GN6CR'EZ.BI1"2%3@16/TV6>LD#_[#[M>RA"Q!D7(LOB
M,1-IG+`W(")*!AXOA%@D'$12)+Q(5W,>%YS#@Z#PG8`Y9Z_@OVW@-5-@0-J^
M@(W^$QS^<;71#0+!5(WNME#NMQ1"SZ\U=M#JJM-;7P/5:BD$+0P:K^FE'>AN
M,#NL0'O"LLZ#Z;%SX&N$@/D"+,J*D%(H#QX=G/36E+)L#M`8LPO%-L:"A%9N
MM8)NWY9HGQ^SPJ;I*/(FMY4[=(3EO/0X?ZG=5=^AWM;0&4\208G4BP=:H_)V
MXM`8M0LT/:5V+RA"R;W#"9:`0D1-E8ZME!@J$K]JKZBCDP'6]&-T!=\^%\3)
M&;@.>I!P5T$SYTT?\@A(R::AE+L5*VOZGM:NB8S9>Q)WF*2=BDQT"B@Y;X]"
M_T+:[UQHXCW:+<+Y_B^Z]LX,DSP6>V/]E%CK*:K%"-Y-7=Z<7F!A*B21#J$6
M'D.#V@VVU#E1*`^P=P&E5;<G2.TT#9@-+"A4A5DCH+<30O<-I6!HF"!"4:)Q
M%.<3[*E#D-T!S$0HD(G8.="]SV)V\7$2V?Q??ACCDK.7C]Q^HKS0_9`NZ%PB
M=7<$5MERC/-,K$9,EDE*:JM8X6:59P^/VT-00B1<9`E/\S%/LRR;S.73N,<=
MYDLHLEK59XWS486_W:#__C!#<2J6G-B->4*F,UF-./W,:?)'G49\=9JO3O,_
M=)KC8+Z#N;V>'G*.BWLS^@7>\T;$RPP$>_O/>Z8W</+DLQOQ[!D,\.3N^7W\
9HZ)J5#NW;]=EG*]4OERQOP'A\EZ(`PD`````
`
end
