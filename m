Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263550AbTEDHpD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 03:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263551AbTEDHpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 03:45:02 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:10512 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S263550AbTEDHpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 03:45:01 -0400
Date: Sun, 4 May 2003 04:57:48 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] list.h: implement list_for_each_entry_safe
Message-ID: <20030504075748.GD12549@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling from:

bk://kernel.bkbits.net/acme/list-2.5

	I started converting IPX to struct list_head and also to use
list_for_eache_entry to simplify the code in the network families I maintain,
and in IPX I need the _safe variation for list_for_eache_entry.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1219, 2003-05-04 04:39:21-03:00, acme@conectiva.com.br
  o list.h: implement list_for_each_entry_safe


 list.h |   13 +++++++++++++
 1 files changed, 13 insertions(+)


diff -Nru a/include/linux/list.h b/include/linux/list.h
--- a/include/linux/list.h	Sun May  4 04:43:59 2003
+++ b/include/linux/list.h	Sun May  4 04:43:59 2003
@@ -297,6 +297,19 @@
 		     prefetch(pos->member.next))
 
 /**
+ * list_for_each_entry_safe - iterate over list of given type safe against removal of list entry
+ * @pos:	the type * to use as a loop counter.
+ * @n:		another type * to use as temporary storage
+ * @head:	the head for your list.
+ * @member:	the name of the list_struct within the struct.
+ */
+#define list_for_each_entry_safe(pos, n, head, member)			\
+	for (pos = list_entry((head)->next, typeof(*pos), member),	\
+		n = list_entry(pos->member.next, typeof(*pos), member);	\
+	     &pos->member != (head); 					\
+	     pos = n, n = list_entry(n->member.next, typeof(*n), member))
+
+/**
  * list_for_each_rcu	-	iterate over an rcu-protected list
  * @pos:	the &struct list_head to use as a loop counter.
  * @head:	the head for your list.

===================================================================


This BitKeeper patch contains the following changesets:
1.1219
## Wrapped with gzip_uu ##


M'XL( +_$M#X  \U5T6K;,!1]MK[BCL)HLMB1+#N)75*R=F,;':QT]*T05%N.
MS6PIR$K:@#]^D@QMUS8M*WN8XP=S=8[.N4<7Y0 N6ZY2CV4-1P?P5;8Z]3(I
M>*:K+0LRV037RBQ<2&D6QJ5L^/CD;%Q7K?;#($9FZ9SIK(0M5VWJD8#>5?1N
MS5/OXO.7R^\?+Q":S^&T9&+%?W(-\SG24FU9G;<+ILM:BD K)MJ&:R?:W4&[
M$./0_&(RI3B>=&2"HVF7D9P0%A&>XS":32*D9,U$OE \+YE^NH.AX@B3&).D
M"RFE!'T"$I"0)(#I&,=C' &.4IJD(?$Q33$&F\CB<1+P@8"/T0G\6_>G* ,)
M-M2@3*%JUC5ON-"NLBRD6G*6E4M34;MERPJ.SB"D492@\_M,D?^7#T*8873\
M2BN5R.I-SLV)B\WMN+?XL*N$FD0)H7$7QEF>7<<XGX5QP2EY/L&]&_9'-*41
MG77A))E2-S+/H5^?GK>;1FW)FZ8RD:J%;/,ZD&KU@N6(8CR-9YAT4823R$U5
M^&BFS#M[9:;H_S)4+O<?X*L;]YHA.7_V"-XP;-_") %"$0SW.@ ?*LT5TQRD
MN4\<#F0!JVK+A;M/P,'8BE7"+"G>2!.8A3BHV\D*+-;27$:ZY#UI:)*%36N(
M+3"HI5Q#)C?"2 4.+5+/8T(:O'I*T+Q92\74#EIS/FS%':7D+.\5[!>89F G
M-[WE?M.&-]?V9K48P1IN7=IOUWRKU2;3<%/ILA*NW%<L=8P.<EY4@N_-Z="T
M-P(Q<MHCZ)4&GN==(<\ZL>LP[^F.=7AHD0/_6/!;/7(]RN)P:&"#._K(LCWQ
M)\\@_.,>$+S /;)<L,_[!PQX-X=>^ @\K[?G0+T]X_^1FMBC)>Z5!N@*C8?#
:^_^=K.39KW;3S*=LQHIBDJ#?TWDGY=,&    
 
