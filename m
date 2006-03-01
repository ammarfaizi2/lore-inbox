Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932621AbWCAHzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621AbWCAHzx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 02:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWCAHzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 02:55:53 -0500
Received: from gold.veritas.com ([143.127.12.110]:44383 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932621AbWCAHzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 02:55:52 -0500
X-IronPort-AV: i="4.02,155,1139212800"; 
   d="scan'208"; a="56448709:sNHT29119524"
Date: Wed, 1 Mar 2006 07:56:38 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Kamran Karimi <kamrankarimi@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: why VM_SHM has been removed from mm.h?
In-Reply-To: <BAY104-F11448E157F2C47E004A12DC0F70@phx.gbl>
Message-ID: <Pine.LNX.4.61.0603010741200.7184@goblin.wat.veritas.com>
References: <BAY104-F11448E157F2C47E004A12DC0F70@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 01 Mar 2006 07:55:51.0459 (UTC) FILETIME=[8F476730:01C63D05]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2006, Kamran Karimi wrote:
> 
> VM_SHM is used by DIPC to quickly recognise when we are dealing with a System
> V IPC segment. It has been "removed" from recent kernels (set to 0).

Curious: VM_SHM wasn't set on a System V IPC shm vma in any 2.4 or 2.6
kernel that I know of; but was set on the vmas of a random collection
of drivers.  Perhaps you've been using your own patch to set it on
SysV IPC shm vmas, and clear it from drivers' vmas?

(We'll remove VM_SHM entirely once I've trawled through those drivers.)

> Is there an easy way to find out if a segment is a Sys V shm?

Nothing easy and reliable springs immediately to mind - from a VM point
of view, they're treated much the same as tmpfs files; but there
probably is some hacky way if we think about it long enough.

> if not, I suggest we re-activate it.

It seems that either you've been doing the wrong thing up to now,
and never noticed it; or that you've been using your own flag in
your own patch, and can continue to do so.  No need for vanilla
kernel to reinstate VM_SHM.

Are you sure you need to recognize them?

Hugh
