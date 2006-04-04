Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWDDPUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWDDPUR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 11:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWDDPUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 11:20:16 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:24279 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750705AbWDDPUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 11:20:15 -0400
Date: Tue, 4 Apr 2006 08:20:03 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <npiggin@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 2/3] mm: speculative get_page
In-Reply-To: <20060219020159.9923.94877.sendpatchset@linux.site>
Message-ID: <Pine.LNX.4.64.0604040814140.26807@schroedinger.engr.sgi.com>
References: <20060219020140.9923.43378.sendpatchset@linux.site>
 <20060219020159.9923.94877.sendpatchset@linux.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like the NoNewRefs flag is mostly == 
spin_is_locked(mapping->tree_lock)? Would it not be better to check the 
tree_lock?


> --- linux-2.6.orig/mm/migrate.c
> +++ linux-2.6/mm/migrate.c
>  
> +	SetPageNoNewRefs(page);
>  	write_lock_irq(&mapping->tree_lock);

A dream come true! If this is really working as it sounds then we can 
move the SetPageNoNewRefs up and avoid the final check under 
mapping->tree_lock. Then keep SetPageNoNewRefs until the page has been 
copied. It would basically play the same role as locking the page.
