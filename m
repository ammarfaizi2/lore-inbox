Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbUCOQsj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 11:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbUCOQsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 11:48:39 -0500
Received: from webapps.arcom.com ([194.200.159.168]:37650 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S262641AbUCOQsh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 11:48:37 -0500
Subject: [PATCH] Do not include linux/irq.h from linux/netpoll.h
From: Ian Campbell <icampbell@arcom.com>
To: netdev@oss.sgi.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Arcom Control Systems
Message-Id: <1079369568.19012.100.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 15 Mar 2004 16:52:50 +0000
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Mar 2004 16:52:54.0781 (UTC) FILETIME=[F61B22D0:01C40AAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(I hope netdev is the right place for netpoll stuff)

It seems that the changeset at
http://www.kernel.org/pub/linux/kernel/v2.6/testing/cset/cset-jgarzik@redhat.com|ChangeSet|20040302073919|27676.txt breaks the current BK tree build for ARM.

The culprit would appear to be the addition of a 
	#include <linux/netpoll.h>
to net/core/dev.c which in turn pulls in <linux/irq.h> which (as Russell
King notes in a comment therein) should not be included from generic
code.

>From what I can tell from the netpoll code used to call the drivers irq
handler to simulate a poll but now it uses the poll_controller function,
therefore I don't think the linux/irq.h needs to be included any longer.
The patch below removes the include.

I successfully built an ARM kernel with NETCONSOLE and NETPOLL enabled,
although I was not able to test it since my network driver has no poll
method.

Cheers,
Ian.

Index: linux-2.6-bkpxa/include/linux/netpoll.h
===================================================================
--- linux-2.6-bkpxa.orig/include/linux/netpoll.h        2004-03-15 15:03:30.000000000 +0000
+++ linux-2.6-bkpxa/include/linux/netpoll.h     2004-03-15 16:24:25.000000000 +0000
@@ -9,7 +9,6 @@
  
 #include <linux/netdevice.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/list.h>
  
 struct netpoll;

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200

