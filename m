Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030490AbWFJSgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030490AbWFJSgG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 14:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030495AbWFJSgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 14:36:05 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:50593 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030490AbWFJSgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 14:36:04 -0400
Date: Sat, 10 Jun 2006 11:36:01 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm2
In-Reply-To: <6bffcb0e0606101126v55cc20dbk275d8aa7fdcb0f1a@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0606101131430.7535@schroedinger.engr.sgi.com>
References: <20060609214024.2f7dd72c.akpm@osdl.org> 
 <6bffcb0e0606100323p122e9b23g37350fa9692337ae@mail.gmail.com> 
 <20060610092412.66dd109f.akpm@osdl.org>  <Pine.LNX.4.64.0606100939480.6651@schroedinger.engr.sgi.com>
  <Pine.LNX.4.64.0606100951340.7174@schroedinger.engr.sgi.com> 
 <20060610100318.8900f849.akpm@osdl.org>  <Pine.LNX.4.64.0606101102380.7421@schroedinger.engr.sgi.com>
  <6bffcb0e0606101114u37c8b642u5c9cc8dd566cba7c@mail.gmail.com>
 <6bffcb0e0606101126v55cc20dbk275d8aa7fdcb0f1a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jun 2006, Michal Piotrowski wrote:

> And I get this error
> /usr/src/linux-mm/mm/page_alloc.c: In function 'vm_events_fold_cpu':
> /usr/src/linux-mm/mm/page_alloc.c:2885: error: incompatible type for
> argument 2 of 'count_vm_events'
> /usr/src/linux-mm/mm/page_alloc.c:2886: error: invalid type argument of '->'
> make[2]: *** [mm/page_alloc.o] B??d 1
> make[1]: *** [mm] B??d 2
> make: *** [_all] B??d 2
> 
> As I said - pain in the ass for people that aren't kernel hackers.

Hmmm. That is hotplug which I cannot enable on ia64. I checked this by
moving the #ifdef CONFIG_HOTPLUG

Index: linux-2.6.17-rc6-mm2/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/mm/page_alloc.c	2006-06-10 11:30:44.560354535 -0700
+++ linux-2.6.17-rc6-mm2/mm/page_alloc.c	2006-06-10 11:34:22.213840263 -0700
@@ -2881,8 +2881,8 @@ static void vm_events_fold_cpu(int cpu)
 	int i;
 
 	for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
-		count_vm_events(i, fold_state->event[i]);
-		local_set(fold_state->event[i], 0);
+		count_vm_events(i, local_read(&fold_state->event[i]));
+		local_set(&fold_state->event[i], 0);
 	}
 }
 
