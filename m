Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbVLAFhC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbVLAFhC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 00:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbVLAFhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 00:37:01 -0500
Received: from ozlabs.org ([203.10.76.45]:44510 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932084AbVLAFhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 00:37:01 -0500
Date: Thu, 1 Dec 2005 16:36:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Willy Tarreau <willy@w.ods.org>
Cc: Andrew Morton <akpm@osdl.org>, Adam Litke <agl@us.ibm.com>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com
Subject: Re: Fix handling of ELF segments with zero filesize
Message-ID: <20051201053641.GA11928@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Willy Tarreau <willy@w.ods.org>, Andrew Morton <akpm@osdl.org>,
	Adam Litke <agl@us.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
References: <20051201002049.GB14247@localhost.localdomain> <20051201052642.GW11266@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201052642.GW11266@alpha.home.local>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 06:26:42AM +0100, Willy Tarreau wrote:
> On Thu, Dec 01, 2005 at 11:20:49AM +1100, David Gibson wrote:
> > Andrew, please apply
> > 
> > mmap() returns -EINVAL if given a zero length, and thus elf_map() in
> > binfmt_elf.c does likewise if it attempts to map a (page-aligned) ELF
> > segment with zero filesize.  Such a situation never arises with the
> > default linker scripts, but there's nothing inherently wrong with
> > zero-filesize (but non-zero memsize) ELF segments.  Custom linker
> > scripts can generate them, and the kernel should be able to map them;
> > this patch makes it so.
> 
> David, 2.4 has exactly the same code, do you see anything wrong with
> applying this patch to 2.4 too ?

Nothing that I can think of.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
