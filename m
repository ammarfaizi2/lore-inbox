Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVBTWfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVBTWfS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 17:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbVBTWfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 17:35:18 -0500
Received: from mail.suse.de ([195.135.220.2]:5346 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262031AbVBTWfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 17:35:13 -0500
Date: Sun, 20 Feb 2005 23:35:10 +0100
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Cc: Andi Kleen <ak@suse.de>, raybry@sgi.com, ak@muc.de, raybry@austin.rr.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview II
Message-ID: <20050220223510.GB14486@wotan.suse.de>
References: <20050215121404.GB25815@muc.de> <421241A2.8040407@sgi.com> <20050215214831.GC7345@wotan.suse.de> <4212C1A9.1050903@sgi.com> <20050217235437.GA31591@wotan.suse.de> <4215A992.80400@sgi.com> <20050218130232.GB13953@wotan.suse.de> <42168FF0.30700@sgi.com> <20050220214922.GA14486@wotan.suse.de> <20050220143023.3d64252b.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050220143023.3d64252b.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you have any better way to suggest, Andi, for a batch manager to
> relocate a job?  The typical scenario, as Ray explained it to me, is

- Give the shared libraries and any other files a suitable policy
(by mapping them and applying mbind) 

- Then execute migrate_pages() for the anonymous pages with a suitable
old node -> new node mapping.

> How would you recommend that the batch manager move that job to the
> nodes that can run it?  The layout of allocated memory pages and tasks
> for that job must be preserved in order to keep the same performance.
> The migration method needs to scale to hundreds, or more, of nodes.

You have to walk to full node mapping for each array, but
even with hundreds of nodes that should not be that costly
(in the worst case you could create a small hash table for it
in the kernel, but I'm not sure it's worth it) 

-Andi
