Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965148AbVKGSPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbVKGSPP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 13:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965176AbVKGSPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 13:15:15 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:27104 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965170AbVKGSPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 13:15:13 -0500
Date: Mon, 7 Nov 2005 10:12:40 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Magnus Damm <magnus.damm@gmail.com>
cc: torvalds@osdl.org, akpm@osdl.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mike Kravetz <kravetz@us.ibm.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>,
       Lee Schermerhorn <lee.schermerhorn@hp.com>,
       linux-kernel@vger.kernel.org, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 1/5] Swap Migration V5: LRU operations
In-Reply-To: <Pine.LNX.4.62.0511070940220.19630@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.62.0511071011550.19689@schroedinger.engr.sgi.com>
References: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com>
  <20051101031244.12488.38211.sendpatchset@schroedinger.engr.sgi.com>
 <aec7e5c30511062335n96c229bve39f614bb8fc7e73@mail.gmail.com>
 <Pine.LNX.4.62.0511070940220.19630@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix check in isolate_lru_pages

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-rc5-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/mm/vmscan.c	2005-11-02 11:39:01.000000000 -0800
+++ linux-2.6.14-rc5-mm1/mm/vmscan.c	2005-11-07 09:50:34.000000000 -0800
@@ -754,7 +754,7 @@ static int isolate_lru_pages(struct zone
 			/* Succeeded to isolate page */
 			list_add(&page->lru, dst);
 			break;
-		case -1:
+		case -ENOENT:
 			/* Not possible to isolate */
 			list_move(&page->lru, src);
 			break;
