Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbUKBP5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUKBP5L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 10:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbUKBP43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 10:56:29 -0500
Received: from jade.aracnet.com ([216.99.193.136]:54725 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S261456AbUKBPtY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 10:49:24 -0500
Date: Tue, 02 Nov 2004 07:46:59 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
cc: hugh@veritas.com, ak@suse.de
Subject: Re: [PATCH] Use MPOL_INTERLEAVE for tmpfs files
Message-ID: <14340000.1099410418@[10.10.2.4]>
In-Reply-To: <Pine.SGI.4.58.0411011901540.77038@kzerza.americas.sgi.com>
References: <Pine.SGI.4.58.0411011901540.77038@kzerza.americas.sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch causes memory allocation for tmpfs files to be distributed
> evenly across NUMA machines.  In most circumstances today, tmpfs files
> will be allocated on the same node as the task writing to the file.
> In many cases, particularly when large files are created, or a large
> number of files are created by a single task, this leads to a severe
> imbalance in free memory amongst nodes.  This patch corrects that
> situation.

Yeah, but it also ruins your locality of reference (in a NUMA sense). 
Not convinced that's a good idea. You're guaranteeing universally consistent
worse-case performance for everyone. And you're only looking at a situation
where there's one allocator on the system, and that's imbalanced.

You WANT your data to be local. That's the whole idea.

M.
