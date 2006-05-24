Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932754AbWEXPzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754AbWEXPzQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 11:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932756AbWEXPzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 11:55:16 -0400
Received: from gold.veritas.com ([143.127.12.110]:3444 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932754AbWEXPzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 11:55:14 -0400
X-IronPort-AV: i="4.05,167,1146466800"; 
   d="scan'208"; a="59830328:sNHT29432644"
Date: Wed, 24 May 2006 16:55:07 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Christoph Lameter <clameter@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm] swapless page migration: fix swapops.h:97 BUG
In-Reply-To: <Pine.LNX.4.64.0605240816080.15446@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0605241646380.16435@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0605241329010.9391@blonde.wat.veritas.com>
 <Pine.LNX.4.64.0605240816080.15446@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 May 2006 15:55:12.0348 (UTC) FILETIME=[70CDC9C0:01C67F4A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2006, Christoph Lameter wrote:
> 
> Thats is very subtle. I hope there are no other areas where the child vma 
> has to be processed before the parent vma?

I've considered, and very much doubt it; and if there are, they'd
have to be peculiar to anonymous, since they'd already have been
wrong for the vma_prio_tree cases.

> An alternative would be to 
> make remove_anon_migration_ptes walk the list in reverse and add a big 
> comment.

No, even without this migration issue, I'd much rather have anon_vmas
inserted in the new list_add_tail way, matching the prio_tree direction.
It's asking for trouble to have opposite conventions there (and much
less surprising to insert child after parent than before).

Hugh
