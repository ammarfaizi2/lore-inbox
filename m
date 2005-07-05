Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVGFAAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVGFAAV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 20:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVGFAAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 20:00:21 -0400
Received: from ozlabs.org ([203.10.76.45]:15309 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261976AbVGFAAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 20:00:15 -0400
Date: Wed, 6 Jul 2005 09:55:21 +1000
From: Anton Blanchard <anton@samba.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: akpm@osdl.org, manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: slab not freeing with current -git
Message-ID: <20050705235521.GN12786@krispykreme>
References: <20050705224528.GJ12786@krispykreme> <Pine.LNX.4.62.0507051550120.1806@graphe.net> <20050705225908.GL12786@krispykreme> <Pine.LNX.4.62.0507051632100.2289@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507051632100.2289@graphe.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> What does pcibus_to_node return for the pcibus device that you are trying 
> to allocate for?

Its using the default. Looking at include/asm-generic/topology.h:

#ifndef pcibus_to_node
#define pcibus_to_node(node)    (-1)
#endif

I wonder what kmalloc_node does when you pass it -1.

Anton

Index: foobar2/include/asm-generic/topology.h
===================================================================
--- foobar2.orig/include/asm-generic/topology.h	2005-07-02 15:56:13.000000000 +1000
+++ foobar2/include/asm-generic/topology.h	2005-07-06 09:39:51.364361274 +1000
@@ -42,7 +42,7 @@
 #define node_to_first_cpu(node)	(0)
 #endif
 #ifndef pcibus_to_node
-#define pcibus_to_node(node)	(-1)
+#define pcibus_to_node(node)	(0)
 #endif
 
 #ifndef pcibus_to_cpumask
