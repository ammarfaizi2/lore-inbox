Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWCGVNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWCGVNJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 16:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWCGVNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 16:13:09 -0500
Received: from silver.veritas.com ([143.127.12.111]:31115 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932083AbWCGVNI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 16:13:08 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,172,1139212800"; 
   d="scan'208"; a="35542963:sNHT22278892"
Date: Tue, 7 Mar 2006 21:14:02 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Kamran Karimi <kamrankarimi@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to find all the tasks with a Sys V shm?
In-Reply-To: <BAY104-F1181301637BB5A23C2C731C0EE0@phx.gbl>
Message-ID: <Pine.LNX.4.61.0603072053550.3626@goblin.wat.veritas.com>
References: <BAY104-F1181301637BB5A23C2C731C0EE0@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 07 Mar 2006 21:13:07.0064 (UTC) FILETIME=[EDFFF780:01C6422B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2006, Kamran Karimi wrote:
> 
> id = ipc_findkey(&shm_ids, key);
> shp = shm_lock(id);
> ...
> 
> But here we only get the vma of the task that created the shm, and not any
> other task who has attached it.
> 
> How can we find all the vma structures that represent a shm?

The simplest example to follow would be reset_vma_truncate_counts() in
mm/memory.c: shp->shm_file->f_mapping gives you the struct address_space *
mapping to pass to vma_prio_tree_foreach().  Ignore the i_mmap_nonlinear
lines, you can't get nonlinear shm (because shm_vm_ops lacks .populate).
You'll need to spin_lock(&mapping->i_mmap_lock) first, spin_unlock after.

Hugh
