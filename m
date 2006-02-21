Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWBUNKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWBUNKY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 08:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWBUNKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 08:10:24 -0500
Received: from silver.veritas.com ([143.127.12.111]:36376 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751176AbWBUNKX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 08:10:23 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,134,1139212800"; 
   d="scan'208"; a="34590400:sNHT26966892"
Date: Tue, 21 Feb 2006 12:49:51 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Christoph Hellwig <hch@infradead.org>
cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport install_page
In-Reply-To: <20060221103808.GB19349@infradead.org>
Message-ID: <Pine.LNX.4.61.0602211227450.8400@goblin.wat.veritas.com>
References: <20060220223709.GT4661@stusta.de> <20060221103808.GB19349@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Feb 2006 13:10:23.0330 (UTC) FILETIME=[2C7C6420:01C636E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2006, Christoph Hellwig wrote:
> On Mon, Feb 20, 2006 at 11:37:09PM +0100, Adrian Bunk wrote:
> > No in-kernel module is using it, so there's no reason bloating the 
> > kernel with this EXPORT_SYMBOL.
> 
> And no one should be using it, really.

Why's that?

> It's a helper for sys_remap_file_pages implementations,

Exactly (to support non-linear vmas and MAP_POPULATE).

> something that nothing but the generic filemap.c or shmem.c should do.

Why's that?  It's rightly been recognized as a library function since
2.6.0-test3.  I'd say it should remain exported for whatever filesystems
might wish to use it (but no, I've no vested interest, the filesystem
you'll suspect me of arguing for does not use it ;)

<akpm@osdl.org>
  [PATCH] export install_page() to modules

  install_page() is a library function which we expect will be used by all
  drivers which implement vm_operations.populate().  Therefore it should be
  exported to kernel modules.

  Petr Vandrovec has a project which involves sparse mappings of device memory
  which can use remap_file_pages().  It needs install_page().
  
Hugh
