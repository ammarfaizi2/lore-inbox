Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbVKQNAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVKQNAz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 08:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVKQNAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 08:00:55 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:63644 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1750787AbVKQNAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 08:00:55 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: "Cipriani, Lawrence V (Larry)" <lvc@lucent.com>
Subject: [PATCH] Re: bugs in /usr/src/linux/net/ipv6/mcast.c
Date: Thu, 17 Nov 2005 15:00:06 +0200
User-Agent: KMail/1.8.2
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, kai.germaschewski@gmx.de,
       linux-dvb-maintainer@linuxtv.org
References: <0C6AA2145B810F499C69B0947DC5078107BCDE20@oh0012exch001p.cb.lucent.com>
In-Reply-To: <0C6AA2145B810F499C69B0947DC5078107BCDE20@oh0012exch001p.cb.lucent.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_W7HfDuZVUx4rIfo"
Message-Id: <200511171500.06910.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_W7HfDuZVUx4rIfo
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[CC: added to respective maintainers]

On Thursday 17 November 2005 00:24, Cipriani, Lawrence V (Larry) wrote:
> 
> Thanks.  We're on 2.4.x  For what it's worth, here are a few more I found:

As far as I can see, none of these exist in 2.6.

(BTW, how did you find them? That one with multi line 'while'
is hard to find with grep)

However, a few similar bugs do exist in 2.6!

Patch attached.

Patch intentionally places a comment instead of statement
in few false positives.

Please review/apply.
--
vda

--Boundary-00=_W7HfDuZVUx4rIfo
Content-Type: text/x-diff;
  charset="koi8-r";
  name="linux-2.6.14.semicolon_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.6.14.semicolon_fix.diff"

diff -urpN linux-2.6.14.org/drivers/isdn/capi/capiutil.c linux-2.6.14.semicolon_fix/drivers/isdn/capi/capiutil.c
--- linux-2.6.14.org/drivers/isdn/capi/capiutil.c	Mon Aug 29 02:41:01 2005
+++ linux-2.6.14.semicolon_fix/drivers/isdn/capi/capiutil.c	Thu Nov 17 14:41:58 2005
@@ -404,7 +404,8 @@ static unsigned command_2_index(unsigned
 {
 	if (c & 0x80)
 		c = 0x9 + (c & 0x0f);
-	else if (c <= 0x0f);
+	else if (c <= 0x0f)
+		/* do nothing */;
 	else if (c == 0x41)
 		c = 0x9 + 0x1;
 	else if (c == 0xff)
diff -urpN linux-2.6.14.org/drivers/media/dvb/frontends/ves1820.c linux-2.6.14.semicolon_fix/drivers/media/dvb/frontends/ves1820.c
--- linux-2.6.14.org/drivers/media/dvb/frontends/ves1820.c	Sat Nov  5 15:17:30 2005
+++ linux-2.6.14.semicolon_fix/drivers/media/dvb/frontends/ves1820.c	Thu Nov 17 14:41:05 2005
@@ -140,25 +140,25 @@ static int ves1820_set_symbolrate(struct
 	/* yeuch! */
 	fpxin = state->config->xin * 10;
 	fptmp = fpxin; do_div(fptmp, 123);
-	if (symbolrate < fptmp);
+	if (symbolrate < fptmp)
 		SFIL = 1;
 	fptmp = fpxin; do_div(fptmp, 160);
-	if (symbolrate < fptmp);
+	if (symbolrate < fptmp)
 		SFIL = 0;
 	fptmp = fpxin; do_div(fptmp, 246);
-	if (symbolrate < fptmp);
+	if (symbolrate < fptmp)
 		SFIL = 1;
 	fptmp = fpxin; do_div(fptmp, 320);
-	if (symbolrate < fptmp);
+	if (symbolrate < fptmp)
 		SFIL = 0;
 	fptmp = fpxin; do_div(fptmp, 492);
-	if (symbolrate < fptmp);
+	if (symbolrate < fptmp)
 		SFIL = 1;
 	fptmp = fpxin; do_div(fptmp, 640);
-	if (symbolrate < fptmp);
+	if (symbolrate < fptmp)
 		SFIL = 0;
 	fptmp = fpxin; do_div(fptmp, 984);
-	if (symbolrate < fptmp);
+	if (symbolrate < fptmp)
 		SFIL = 1;
 
 	fin = state->config->xin >> 4;
diff -urpN linux-2.6.14.org/drivers/net/tokenring/ibmtr.c linux-2.6.14.semicolon_fix/drivers/net/tokenring/ibmtr.c
--- linux-2.6.14.org/drivers/net/tokenring/ibmtr.c	Sat Nov  5 15:17:37 2005
+++ linux-2.6.14.semicolon_fix/drivers/net/tokenring/ibmtr.c	Thu Nov 17 14:42:56 2005
@@ -610,8 +610,10 @@ static int __devinit ibmtr_probe1(struct
 	ti->mapped_ram_size= /*sixteen to onehundredtwentyeight 512byte blocks*/
 	    1<< ((readb(ti->mmio+ACA_OFFSET+ACA_RW+RRR_ODD) >> 2 & 0x03) + 4);
 	ti->page_mask = 0;
-	if (ti->turbo)  ti->page_mask=0xf0;
-	else if (ti->shared_ram_paging == 0xf);  /* No paging in adapter */
+	if (ti->turbo)
+		ti->page_mask=0xf0;
+	else if (ti->shared_ram_paging == 0xf)
+		/* No paging in adapter */;
 	else {
 #ifdef ENABLE_PAGING
 		unsigned char pg_size = 0;
diff -urpN linux-2.6.14.org/net/netrom/nr_in.c linux-2.6.14.semicolon_fix/net/netrom/nr_in.c
--- linux-2.6.14.org/net/netrom/nr_in.c	Sat Nov  5 15:18:17 2005
+++ linux-2.6.14.semicolon_fix/net/netrom/nr_in.c	Thu Nov 17 14:43:53 2005
@@ -99,7 +99,7 @@ static int nr_state1_machine(struct sock
 		break;
 
 	case NR_RESET:
-		if (sysctl_netrom_reset_circuit);
+		if (sysctl_netrom_reset_circuit)
 			nr_disconnect(sk, ECONNRESET);
 		break;
 
@@ -130,7 +130,7 @@ static int nr_state2_machine(struct sock
 		break;
 
 	case NR_RESET:
-		if (sysctl_netrom_reset_circuit);
+		if (sysctl_netrom_reset_circuit)
 			nr_disconnect(sk, ECONNRESET);
 		break;
 
@@ -265,7 +265,7 @@ static int nr_state3_machine(struct sock
 		break;
 
 	case NR_RESET:
-		if (sysctl_netrom_reset_circuit);
+		if (sysctl_netrom_reset_circuit)
 			nr_disconnect(sk, ECONNRESET);
 		break;
 

--Boundary-00=_W7HfDuZVUx4rIfo--
