Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262787AbULQLX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbULQLX4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 06:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbULQLXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 06:23:55 -0500
Received: from canuck.infradead.org ([205.233.218.70]:49670 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262787AbULQLXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 06:23:53 -0500
Subject: Re: Linux 2.6.9-ac16
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1103222616.21920.12.camel@localhost.localdomain>
References: <1103222616.21920.12.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 17 Dec 2004 12:23:39 +0100
Message-Id: <1103282619.4138.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-16 at 18:43 +0000, Alan Cox wrote:
> o	Acenic must use __devinitdata for hotplug	(Alan Cox)
> 	| based on an RH patch

diff -u --new-file --recursive --exclude-from /usr/src/exclude
linux.vanilla-2.6.9/drivers/net/acenic.c
linux-2.6.9/drivers/net/acenic.c
--- linux.vanilla-2.6.9/drivers/net/acenic.c    2004-10-20
23:16:54.000000000 +0100
+++ linux-2.6.9/drivers/net/acenic.c    2004-12-16 17:13:10.799818288
+0000
@@ -444,7 +444,7 @@
 MODULE_PARM_DESC(tx_ratio, "AceNIC/3C985/GA620 ratio of NIC memory used
for TX/RX descriptors (range 0-63)");


-static char version[] __initdata =
+static char version[] __devinitdata =
   "acenic.c: v0.92 08/05/2002  Jes Sorensen, linux-acenic@SunSITE.dk\n"
   "
http://home.cern.ch/~jes/gige/acenic.html\n";



you broke this one... :-)
the version var *cannot* be initdata of any kind, since the ethtool
ioctl uses the variable. End Of Story(tm)


