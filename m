Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbTE0CVm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 22:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbTE0CVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 22:21:42 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:13072 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262473AbTE0CVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 22:21:38 -0400
Date: Mon, 26 May 2003 23:34:44 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       ncorbic@sangoma.com, dm@sangoma.com
Subject: [PATCH] wanrouter: fix bug introduced by latest namespace fix
Message-ID: <20030527023444.GB8900@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, Adrian Bunk <bunk@fs.tum.de>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-net@vger.kernel.org, ncorbic@sangoma.com, dm@sangoma.com
References: <20030525042759.6edacd62.akpm@digeo.com> <20030525205409.GF16791@fs.tum.de> <20030526131528.GA1178@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030526131528.GA1178@conectiva.com.br>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 26, 2003 at 10:15:28AM -0300, Arnaldo C. Melo escreveu:
> My fault, will send a fix to DaveM shortly.
> 
> Em Sun, May 25, 2003 at 10:54:09PM +0200, Adrian Bunk escreveu:
> > It seems the following link error comes from Linus' tree:
> > 
> > <--  snip  -->
> > 
> > ...
> > 386/oprofile/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
> > ...
> > net/built-in.o(.text+0x10b278): In function `r_start':
> > : undefined reference to `router_devlist'
> > net/built-in.o(.text+0x10b321): In function `r_next':

Here it is, David, please pull from:

bk://kernel.bkbits.net/acme/net-2.5

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1426, 2003-05-26 23:31:51-03:00, acme@conectiva.com.br
  o wanrouter: fix bug introduced by latest namespace fix
  
  Thanks to Adrian Bunk for reporting.


 include/linux/wanrouter.h |    3 ++-
 net/wanrouter/wanproc.c   |    5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)


diff -Nru a/include/linux/wanrouter.h b/include/linux/wanrouter.h
--- a/include/linux/wanrouter.h	Mon May 26 23:32:56 2003
+++ b/include/linux/wanrouter.h	Mon May 26 23:32:56 2003
@@ -534,7 +534,8 @@
 
 
 /* Public Data */
-extern struct wan_device *router_devlist;	/* list of registered devices */
+/* list of registered devices */
+extern struct wan_device *wanrouter_router_devlist;
 
 #endif	/* __KERNEL__ */
 #endif	/* _ROUTER_H */
diff -Nru a/net/wanrouter/wanproc.c b/net/wanrouter/wanproc.c
--- a/net/wanrouter/wanproc.c	Mon May 26 23:32:56 2003
+++ b/net/wanrouter/wanproc.c	Mon May 26 23:32:56 2003
@@ -87,7 +87,8 @@
 	lock_kernel();
 	if (!l--)
 		return (void *)1;
-	for (wandev = router_devlist; l-- && wandev; wandev = wandev->next)
+	for (wandev = wanrouter_router_devlist; l-- && wandev;
+	     wandev = wandev->next)
 		;
 	return wandev;
 }
@@ -96,7 +97,7 @@
 {
 	struct wan_device *wandev = v;
 	(*pos)++;
-	return (v == (void *)1) ? router_devlist : wandev->next;
+	return (v == (void *)1) ? wanrouter_router_devlist : wandev->next;
 }
 
 static void r_stop(struct seq_file *m, void *v)

===================================================================


This BitKeeper patch contains the following changesets:
1.1426
## Wrapped with gzip_uu ##


M'XL( %C.TCX  ]5676^;,!1]CG_%E2I5;2; GT"HTK5=IVW:I%7=^EP1XR0H
M"41@TE;BQ^]"IJ3M1J*U>RD@8[CVN5_G( [@IC1%U(OUPI #^)R7-NKI/#/:
MIJO8U?G"'15HN,YS-'C3?&&\T<S+C'6XJPA:KF*KI[ R11GUF"LV;^S#TD2]
MZX^?;KZ=7Q,R',*':9Q-S ]C83@D-B]6\3PISV([G>>9:XLX*Q?&MC[KS=*:
M4\KQ5"P05/DU\ZD,:LT2QF+)3$*Y#'VY16L"W(6%(#R@5 6()>5 !.02F,LD
M]X$*CRH/)UQ$@D6*.51$E$)3FK/G)8%W'!Q*+N#_YO&!:,CA+LZ*O++8%QBG
M]S"J)I!FMLB32IL$1@\PCZTI+63QPI3+6)MF&>[$ZR<ZG)48%9PG11IG<%%E
M,QCG!11FF1<VS28N^0J8NN3D:ML2XOSC00B-*3G=DS_RQ-MDT\R61:Y=_;@:
M S6H?:'"L![0$0L2YDLC1G0LS=\KOPMSW5W.0ZYJSE4H]@:89GI>)<:;IUEU
MOX5UIT]"E*SV^8"+.@CDF%&9&*U"/3:J(\2=J-L@9<V%$F$KCLXM^\7RRAS(
MRW)@BJ-L:("%EE*T,@J?:(B'$9=[-<3>K(;6O?L.3G'77JB)J^XVOD!@ETH$
MP,B7YL:)UX=YB@'G8PQC@C-38"*)6:7:E-#WB+G'5QF4MJBT;?*_71NAOPGC
M]O<-#0W62<N\#CWMY]VKQ-W!NMWB9B&3*N0#?,1>MYSC] _2J=VD$^#PMTNZ
M]JOVC'0=17L)Y0:T81R.G/0:YT>(AFR!(722".:. X>'L%YY0GK0'(_WX<0Y
MS9"?Q^A@T#IHQEYA;(6,/<)E0QSS-('^,3N&]YW.('J"=[+] =%3HV=EM1AJ
/*E3LFX#\ H?^-!7;"   
 
