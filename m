Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUAOBph (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 20:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264467AbUAOBnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 20:43:04 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:58107 "EHLO
	orion.mvista.com") by vger.kernel.org with ESMTP id S265828AbUAOBkR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 20:40:17 -0500
Date: Wed, 14 Jan 2004 17:40:12 -0800
From: Jun Sun <jsun@mvista.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk, jsun@mvista.com
Subject: Re: [BUG] 2.6.1/MIPS - missing cache flushing when user program returns pages to kernel
Message-ID: <20040114174012.H13471@mvista.com>
References: <20040114163920.E13471@mvista.com> <20040114171252.4d873c51.akpm@osdl.org> <20040114172946.03e54706.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040114172946.03e54706.akpm@osdl.org>; from akpm@osdl.org on Wed, Jan 14, 2004 at 05:29:46PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 05:29:46PM -0800, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > I think that's wrong, really.  We've discussed this before and decided that
> > these flushing operations should be open-coded in the main .c file rather
> > than embedded in arch functions which happen to undocumentedly do other
> > stuff.
> 
> err, OK, I give up.  Lots of architectures do the cache flush in
> tlb_start_vma().  I guess mips may as well do the same.
> 

Looking at my tree (which is from linux-mips.org), it appears
arm, sparc, sparc64, and sh have tlb_start_vma() defined to call
cache flushing.

What exactly does tlb_start_vma()/tlb_end_vma() mean?  There is
only one invocation instance, which is significant enough to infer
the meaning.  :)
 
BTW, either my original hack or putting a cache flush in tlb_start_vma()
solves my problem.  They are really doing the same thing, just at
different places. 

Jun
