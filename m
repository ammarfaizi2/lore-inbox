Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161096AbWJ3FaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161096AbWJ3FaF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 00:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbWJ3FaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 00:30:05 -0500
Received: from gate.crashing.org ([63.228.1.57]:46030 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161096AbWJ3FaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 00:30:04 -0500
Subject: Re: [PATCH 2/3] Create compat_sys_migrate_pages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@ozlabs.org>,
       paulus@samba.org, ak@suse.de, linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.64.0610270622480.7342@schroedinger.engr.sgi.com>
References: <20061026132659.2ff90dd1.sfr@canb.auug.org.au>
	 <20061026133305.b0db54e6.sfr@canb.auug.org.au>
	 <Pine.LNX.4.64.0610261158130.2802@schroedinger.engr.sgi.com>
	 <20061027102834.5db261af.sfr@canb.auug.org.au>
	 <Pine.LNX.4.64.0610270622480.7342@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 16:29:09 +1100
Message-Id: <1162186149.25682.171.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-27 at 06:24 -0700, Christoph Lameter wrote:
> On Fri, 27 Oct 2006, Stephen Rothwell wrote:
> 
> > No they aren't because they have compat routines that convert the bitmaps
> > before calling the "normal" syscall.  They, importantly, only use
> > compat_alloc_user_space once each.
> 
> Ah...
> 
> > > Fixing get_nodes() to do the proper thing would fix all of these
> > > without having to touch sys_migrate_pages or creating a compat_ function
> > > (which usually is placed in kernel/compat.c)
> > 
> > You need the compat_ version of the syscalls to know if you were called
> > from a 32bit application in order to know if you may need to fixup the
> > bitmaps that are passed from/to user mode.
> 
> The compat functions should be placed in kernel/compat.c next to 
> compat_sys_move_pages.

I disagree.. it's really annoying when they are away from their
respective "non-compat" function, especially when they are more than
just wrappers copying/converting arguments...

Now, if only we had done a sane ABI in the first place...
 
Ben.


