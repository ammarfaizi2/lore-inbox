Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbWAKGxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWAKGxM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 01:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWAKGxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 01:53:12 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:19855 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030279AbWAKGxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 01:53:11 -0500
Date: Tue, 10 Jan 2006 22:52:58 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: kamezawa.hiroyu@jp.fujitsu.com, cpw@sgi.com, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net, taka@valinux.co.jp
Subject: Re: [PATCH 5/5] Direct Migration V9: Avoid writeback / page_migrate()
 method
In-Reply-To: <20060110224905.514213de.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0601102250450.20806@schroedinger.engr.sgi.com>
References: <20060110224114.19138.10463.sendpatchset@schroedinger.engr.sgi.com>
 <20060110224140.19138.84122.sendpatchset@schroedinger.engr.sgi.com>
 <20060110220314.70e5793b.akpm@osdl.org> <Pine.LNX.4.62.0601102225550.20806@schroedinger.engr.sgi.com>
 <20060110224905.514213de.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2006, Andrew Morton wrote:

> So let's see.  Suppose the kernel is about to dink with a page's buffer
> ring.  It does:
> 
> 	get_page(page);
> 	lock_page(page);
> 	dink_with(page_buffers(page));
> 
> how do these patches ensure that the page doesn't get migrated under my
> feet?

The page is locked when buffer_migrate_page is called. Thus 

lock_page

will block.

If the refcount was increased before the migration code does the lock 
on the tree_lock then the migration will be aborted.

