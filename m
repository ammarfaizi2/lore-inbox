Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262822AbSI3SCL>; Mon, 30 Sep 2002 14:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262823AbSI3SCL>; Mon, 30 Sep 2002 14:02:11 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:30222 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S262822AbSI3SCK>; Mon, 30 Sep 2002 14:02:10 -0400
Date: Mon, 30 Sep 2002 15:07:32 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Jochen Friedrich <jochen@scram.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.3.39 LLC on Alpha broken?
Message-ID: <20020930180732.GG13478@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Jochen Friedrich <jochen@scram.de>, linux-kernel@vger.kernel.org
References: <Pine.NEB.4.44.0209300934330.7633-100000@www2.scram.de> <Pine.LNX.4.44.0209301956320.1163-100000@alpha.bocc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209301956320.1163-100000@alpha.bocc.de>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 30, 2002 at 07:58:43PM +0200, Jochen Friedrich escreveu:
> Hi,
> 
> > I'll try to reboot the remaining mess and report how far it gets...
> 
> It looks like LLC is the culprit for me:

Yes, it is, this is fixed in Linus bk tree, snap_init has to be called after
llc_init, this is the patch:

diff -Nru a/net/Makefile b/net/Makefile
--- a/net/Makefile	Wed Sep 18 22:54:43 2002
+++ b/net/Makefile	Mon Sep 30 00:11:16 2002
@@ -9,6 +9,8 @@
 
 obj-y	:= socket.o core/
 
+# LLC has to be linked before the files in net/802/
+obj-$(CONFIG_LLC)		+= llc/
 obj-$(CONFIG_NET)		+= ethernet/ 802/ sched/ netlink/
 obj-$(CONFIG_INET)		+= ipv4/
 obj-$(CONFIG_UNIX)		+= unix/
@@ -31,7 +33,6 @@
 obj-$(CONFIG_DECNET)		+= decnet/
 obj-$(CONFIG_ECONET)		+= econet/
 obj-$(CONFIG_VLAN_8021Q)	+= 8021q/
-obj-$(CONFIG_LLC)		+= llc/
 obj-$(CONFIG_IP_SCTP)		+= sctp/
 
 ifeq ($(CONFIG_NET),y)
