Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbTEOCVh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 22:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263725AbTEOCVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 22:21:36 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:6151 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S263718AbTEOCVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 22:21:32 -0400
Date: Wed, 14 May 2003 23:35:50 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: [PATCH] af_netlink: netlink_proto_init has to be core_initcall
Message-ID: <20030515023550.GI6372@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, Jens Axboe <axboe@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, 

	Please pull from:

bk://kernel.bkbits.net/acme/net-2.5

	Jens, this one fixes the problem you reported, thanks!

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1115, 2003-05-14 23:19:24-03:00, acme@conectiva.com.br
  o af_netlink: netlink_proto_init has to be core_initcall
  
  As it has to happen before pktsched_init, that is called from
  net_dev_init that is a subsys_initcall, making it the same
  init level as netlink_proto_init, that ends up being called
  _after_ net_dev_init, so when pktsched_init is called it finds
  rtnetlink_links[PF_UNSPEC] as null and therefore not sets
  the ->dumpit entry for RTM_GETQDISC (and the others too):
  b00m, rtnetlink_rcv sends a failure message to tc.


 af_netlink.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
--- a/net/netlink/af_netlink.c	Wed May 14 23:29:48 2003
+++ b/net/netlink/af_netlink.c	Wed May 14 23:29:48 2003
@@ -1082,7 +1082,7 @@
        remove_proc_entry("net/netlink", NULL);
 }
 
-subsys_initcall(netlink_proto_init);
+core_initcall(netlink_proto_init);
 module_exit(netlink_proto_exit);
 
 MODULE_LICENSE("GPL");

===================================================================


This BitKeeper patch contains the following changesets:
1.1115
## Wrapped with gzip_uu ##


M'XL( )S[PCX  ^U566_:0!!^9G_%2'E)5#"[O@*NB)*2-(UZ49(\596UK->Q
MA>U%WH4(R3^^8T-"R%'4M(\! [9WOF/6,\,>7&M9!BTN<DGVX)/2)F@)54AA
MT@6WA,JM28D+8Z5PH9NH7'8GTVXA3<>V/((K(VY$ @M9ZJ#%+.?^CEG.9- :
MGYU??SD9$S(8P##AQ8V\E 8& V)4N>!9I(^Y23)56*;DA<ZE:32K^]#*IM3&
MM\<.'>KY%?.I>U@)%C'&728C:KL]WR6U_>/'MK=9$,Y<ZMH^ZU74[WL]<@K,
M8HQY0)TN];K,!=L)6#^PW0YU DKA659XQZ!#R0?XOQD,B0 %/ YQ:[.TF :P
M/@EGI3(J3(O40,(URL)$@E"E;.X)GF4(Q>-$PR8DX;.9+# RQD"838T6B8P:
M1!M,P@VD&FJLC" N58YXU LCN5@IW85PT/.)7NI[K3;D?)H6-] $2= <"T= 
M \KD0F: !IY:7XO*(M(PGZ&OFF*EC^B0QT:6X9:%-F@%MPDFL>7^@6^\B%,D
M1(+2W$G67_KGZ&-X_>UR=#;\U=B99VBKB&K#Y6I'"F5 2U-CZRPZ1]$\GZ6U
M05,N 4-@?/4U/#^[^G%Z<3F$_34:5$U1[[ Z"! [H31O/U OQ0)IZR0YQ#S-
MYBB52ZWYC:R?BA$6^0Q^WV=DM&D'TOG+%R&44W*THP+14W?MJ[NI*TL\+,B^
MUZ\8<YA7>8())W;<2$C>8\)_OOC_2%IWF$=MUD<ZQ^XQN^GZEQ"[A\"_)?#"
M3-B1 'Y\!_DJ!T]6(\)V'P\(YNT<$.QM0+P-B-<.B%7S?(=.>=L<V/&C%_OH
M%=/CE-&>!XQ<K'^W:F7_Z;,Y>+_YH\=]%E,]SP>1'=M])W+(;P3!<0E#"   
 
