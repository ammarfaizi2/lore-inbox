Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVEPIgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVEPIgP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 04:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVEPIf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 04:35:27 -0400
Received: from exo1066.net2.nerim.net ([213.41.175.60]:24764 "EHLO
	mail-out1.exosec.net") by vger.kernel.org with ESMTP
	id S261459AbVEPIcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 04:32:36 -0400
Date: Mon, 16 May 2005 10:32:34 +0200
From: Willy Tarreau <wtarreau@exosec.fr>
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org, David.Monniaux@ens.fr
Subject: Re: Linux 2.4.31-pre2
Message-ID: <20050516083234.GE11282@exosec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

moxa does not compile anymore in 2.4.31-pre2, because a variable is used
before being declared. Since I fixed it on the fly in -hf, I thought that I
had reported it, but I don't find any trace of it, so I might have dreamed...

Here's the fix anyway.
Regards,
Willy

diff -urN linux-2.4.31-pre2/drivers/char/moxa.c linux-2.4.31-pre2-moxa-fix/drivers/char/moxa.c
--- linux-2.4.31-pre2/drivers/char/moxa.c	2005-05-16 10:26:12.000000000 +0200
+++ linux-2.4.31-pre2-moxa-fix/drivers/char/moxa.c	2005-05-16 10:26:29.000000000 +0200
@@ -294,6 +294,7 @@
 static int moxa_get_serial_info(struct moxa_str *, struct serial_struct *);
 static int moxa_set_serial_info(struct moxa_str *, struct serial_struct *);
 static void MoxaSetFifo(int port, int enable);
+static unsigned long moxaIntPend[MAX_BOARDS];
 
 #ifdef MODULE
 int init_module(void)
@@ -1579,7 +1580,6 @@
 
 static unsigned char moxaBuff[10240];
 static unsigned long moxaIntNdx[MAX_BOARDS];
-static unsigned long moxaIntPend[MAX_BOARDS];
 static unsigned long moxaIntTable[MAX_BOARDS];
 static char moxaChkPort[MAX_PORTS];
 static char moxaLineCtrl[MAX_PORTS];


