Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263160AbSJHDXS>; Mon, 7 Oct 2002 23:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263157AbSJHDXS>; Mon, 7 Oct 2002 23:23:18 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:48145 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S263160AbSJHDXP>; Mon, 7 Oct 2002 23:23:15 -0400
Date: Tue, 8 Oct 2002 00:28:53 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] IPX: fix permission bogosity in create_proc_entry usage
Message-ID: <20021008032853.GD10196@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

	Please pull from:

master.kernel.org:/home/acme/BK/llc-2.5

	Now there are two outstanding changesets there.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.634, 2002-10-08 00:18:38-03:00, acme@conectiva.com.br
  o IPX: fix permission bogosity in create_proc_entry usage


 ipx_proc.c |   18 +++---------------
 1 files changed, 3 insertions(+), 15 deletions(-)


diff -Nru a/net/ipx/ipx_proc.c b/net/ipx/ipx_proc.c
--- a/net/ipx/ipx_proc.c	Tue Oct  8 00:19:05 2002
+++ b/net/ipx/ipx_proc.c	Tue Oct  8 00:19:05 2002
@@ -315,15 +315,6 @@
 	.release        = seq_release,
 };
 
-static int ipx_proc_perms(struct inode* inode, int op)
-{
-	return 0;
-}
-
-static struct inode_operations ipx_seq_inode = {
-	.permission     = ipx_proc_perms,
-};
-
 static struct proc_dir_entry *ipx_proc_dir;
 
 int __init ipx_proc_init(void)
@@ -335,24 +326,21 @@
 
 	if (!ipx_proc_dir)
 		goto out;
-	p = create_proc_entry("interface", 0, ipx_proc_dir);
+	p = create_proc_entry("interface", S_IRUGO, ipx_proc_dir);
 	if (!p)
 		goto out_interface;
 
 	p->proc_fops = &ipx_seq_interface_fops;
-	p->proc_iops = &ipx_seq_inode;
-	p = create_proc_entry("route", 0, ipx_proc_dir);
+	p = create_proc_entry("route", S_IRUGO, ipx_proc_dir);
 	if (!p)
 		goto out_route;
 
 	p->proc_fops = &ipx_seq_route_fops;
-	p->proc_iops = &ipx_seq_inode;
-	p = create_proc_entry("socket", 0, ipx_proc_dir);
+	p = create_proc_entry("socket", S_IRUGO, ipx_proc_dir);
 	if (!p)
 		goto out_socket;
 
 	p->proc_fops = &ipx_seq_socket_fops;
-	p->proc_iops = &ipx_seq_inode;
 
 	rc = 0;
 out:

===================================================================


This BitKeeper patch contains the following changesets:
1.634
## Wrapped with gzip_uu ##


begin 664 bkpatch25437
M'XL(`*E.HCT``\V476O;,!2&KZ-?<6AO-E;;1Y:L.!X>7=O1A0X:4@*["XJL
M)*:)%60U;<`_?HI+,VBRC)5>S+(1Z!P_Y^M%IS"JM<TZ4BTU.87OIG991YE*
M*U>N9:C,,IQ8;Q@:XPW1W"QUM/6-+FZBQ4(%<9@0;QY(I^:PUK;..C1DNQ.W
M6>FL,_QV/?KQ=4A(GL/E7%8S?:<=Y#EQQJ[EHJC/I9LO3!4Z*ZMZJ5T;N-FY
M-C%B[%="NPP3T5"!O-LH6E`J.=4%QCP5G&SS.G^=^RL*14S10WC2"!2]F%P!
M#07C@'%$,<(4$#.:9BP-D&6(<!`*GR@$2"[@?0NX)`H,]`<_,YB63[#2=EG6
M=6DJF)B9J4NW@;("9;5T>KRR1HUUY>P&'FHYT^0&!'81R>!WCTGPCP\A*)%\
M.5QU4VD7E:NG[=>&#]5+3X6O@-*XH4PPT?#N9$J1QKI+13'I_:&)1W!^1#1E
M2<.9A[:RV??=ZN=]TWPCCC6"QY2V2HKW=)0<UQ&#@";_G9">^WX+@7UL7R^,
MP8$1O$%>5WZPT/,;2X&2_O/664&^G\V'D[)RVDZETB=G<#?N#T?7MV?P$GY<
ME/;C9T_B#&)/XOP(R9H']Q=*KZ4D>(12&W6OW5%,DOC_=]>?FFMU7S\L<ZZY
.2FDQ);\`%-_5G'`%````
`
end
