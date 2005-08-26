Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbVHZTJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbVHZTJZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbVHZTJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:09:25 -0400
Received: from silver.veritas.com ([143.127.12.111]:50340 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1030204AbVHZTJY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:09:24 -0400
Date: Fri, 26 Aug 2005 20:11:20 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Blaisorblade <blaisorblade@yahoo.it>
cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Jeff Dike <jdike@addtoit.com>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [RFC] [patch 0/18] remap_file_pages protection support (for
 UML), try 3
In-Reply-To: <200508262023.29170.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.61.0508262000530.8803@goblin.wat.veritas.com>
References: <200508262023.29170.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 26 Aug 2005 19:09:22.0317 (UTC) FILETIME=[AAC7BBD0:01C5AA71]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2005, Blaisorblade wrote:

> This is a followup to my post of last week (Aug 12) about remap_file_pages 
> protection support. I've improved and consolidated the patches and updated 
> them against 2.6.13-rc6/rc7 (the same patches apply against both versions).
> I'm sending the full patch series only to akpm, mingo and LKML.
> 
> I've also reduced them to only 18, and made the splitting more significant. 
> I'm not resending all the patches for foreign architectures, because they're 
> almost unchanged since last time (there's just a trivial reject from ppc32, 
> because one change has already been done after -rc4).
> 
> I'm working on this to provide support for UML, which currently easily creates 
> more than 64K (the default limit) vma's for a single process. Actually, it 
> needs one VMA per each page. So, with this patch and specific UML support, 
> which Ingo wrote and which I'm porting to recent UMLs.

I'll try to take a look sometime next week - or, if I wait until
next Friday, can we expect it to have come down to 9 patches ;-?

I should say, my initial reaction is very much like Andi's last week.

sys_remap_file_pages solves a real problem, but it does so by breaking
lots of rules.  For more than a year after it came in, almost every
development we tried in mm would come up against "but then what do we
do about the nonlinear mappings?".

That has settled down now, but I don't look forward to extending it.
On the other hand, UML does deserve better support.

Hugh
