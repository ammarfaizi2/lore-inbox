Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264425AbTDOKJU (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 06:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264427AbTDOKJU (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 06:09:20 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:34833 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264425AbTDOKJS (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 06:09:18 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: pk@q-leap.com, linux-kernel@vger.kernel.org
Subject: Re: oops with e1000, ifenslave (bonding)
Date: Tue, 15 Apr 2003 12:20:36 +0200
User-Agent: KMail/1.5.1
References: <16027.55946.797266.771034@q-leap.com>
In-Reply-To: <16027.55946.797266.771034@q-leap.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0z9m+DO6NT4BhFL"
Message-Id: <200304151220.36148.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_0z9m+DO6NT4BhFL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 15 April 2003 12:10, Peter wrote:

Hi Peter,

> Hello,
> the following oops occurs repeatadly:
Does the attached patch fixes the problem?

Patch by: Scott Feldman <scott.feldman <located at> intel.com>

ciao, Marc
--Boundary-00=_0z9m+DO6NT4BhFL
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="e1000-bonding-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="e1000-bonding-fix.patch"

--- linux-2.4.20/drivers/net/e1000/e1000_main.c.orig	2003-03-11 13:45:26.000000000 -0800
+++ linux-2.4.20/drivers/net/e1000/e1000_main.c	2003-03-11 14:12:12.000000000 -0800
@@ -963,6 +963,9 @@
 	unsigned long size;
 	int i;
 
+	if(!adapter->tx_ring.buffer_info)
+		return;
+
 	/* Free all the Tx ring sk_buffs */
 
 	for(i = 0; i < adapter->tx_ring.count; i++) {
@@ -1028,6 +1031,9 @@
 	unsigned long size;
 	int i;
 
+	if(!adapter->rx_ring.buffer_info)
+		return;
+
 	/* Free all the Rx ring sk_buffs */
 
 	for(i = 0; i < adapter->rx_ring.count; i++) {

--Boundary-00=_0z9m+DO6NT4BhFL--

