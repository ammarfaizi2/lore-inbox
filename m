Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266892AbUJRRCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266892AbUJRRCe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 13:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266901AbUJRRCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 13:02:34 -0400
Received: from adsl-209-204-138-32.sonic.net ([209.204.138.32]:55966 "EHLO
	graphe.net") by vger.kernel.org with ESMTP id S266892AbUJRRCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 13:02:32 -0400
Date: Mon, 18 Oct 2004 10:02:20 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Andrea Arcangeli <andrea@novell.com>
cc: Andi Kleen <ak@suse.de>, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: 4level page tables for Linux
In-Reply-To: <20041013200414.GP17849@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0410180957500.9916@server.graphe.net>
References: <20041012135919.GB20992@wotan.suse.de> <1097606902.10652.203.camel@localhost>
 <20041013184153.GO17849@dualathlon.random> <20041013213558.43b3236c.ak@suse.de>
 <20041013200414.GP17849@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -4.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2004, Andrea Arcangeli wrote:

> On Wed, Oct 13, 2004 at 09:35:58PM +0200, Andi Kleen wrote:
> > page mapping level 4 (?) just guessing here.
>
> make sense.
>
> > PML4 is the name AMD and Intel use in their documentation. I don't see
> > a particular reason to be different from them.
>
> just because we never say 'page mapping level 4', we think 'page table
> level 4' or 'page directory level 4'.

Would it not be best to give up hardcoding these page mapping levels into
the kernel? Linux should support N levels. pml4,pgd,pmd,pte needs to
disappear and be replaced by

pte_path[N]

We are duplicating code for pgd, pmd, pte and now pml again and again. The
code could be much simpler if this would be generalized. Various
architectures would support different levels without some strange
feature like f.e. pmd's being "optimized away".

Certainly the way that pml4 is proposed to be done is less invasive but we
are creating something more and more difficult to maintain.
