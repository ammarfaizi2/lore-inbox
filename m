Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbUDHT0f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 15:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbUDHT0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 15:26:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:7321 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262335AbUDHT0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:26:32 -0400
Date: Thu, 8 Apr 2004 12:25:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: ak@suse.de, mbligh@aracnet.com, colpatch@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: NUMA API for Linux
Message-Id: <20040408122543.670e1ad3.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0404081641450.7277-100000@localhost.localdomain>
References: <20040407165639.2198b215.akpm@osdl.org>
	<Pine.LNX.4.44.0404081641450.7277-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> On Wed, 7 Apr 2004, Andrew Morton wrote:
> > 
> > Your patch takes the CONFIG_NUMA vma from 64 bytes to 68.  It would be nice
> > to pull those 4 bytes back somehow.
> 
> How significant is this vma size issue?

For some workloads/machines it will simply cause an
approximately-proportional reduction in the size of the workload which we
can handle.

ie: there are some (oracle) workloads where the kernel craps out due to
lowmem vma exhaustion.  If they're now using remap_file_pages() for this then
it may not be a problem any more.  Ingo would know better than I.

> anon_vma objrmap will add 20 bytes to each vma (on 32-bit arches):
> 8 for prio_tree, 12 for anon_vma linkage in vma,
> sometimes another 12 for the anon_vma head itself.
> 
> anonmm objrmap adds just the 8 bytes for prio_tree,
> remaining overhead 28 bytes per mm.
> 
> Seems hard on Andi to begrudge him 4.

