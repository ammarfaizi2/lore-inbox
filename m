Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWCBDHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWCBDHk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 22:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWCBDHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 22:07:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36044 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751165AbWCBDHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 22:07:39 -0500
Date: Wed, 1 Mar 2006 18:56:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nathan Scott <nathans@sgi.com>
Cc: pbadari@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] change buffer_head.b_size to size_t
Message-Id: <20060301185616.69986425.akpm@osdl.org>
In-Reply-To: <20060302132232.C88229@wobbly.melbourne.sgi.com>
References: <1141075239.10542.19.camel@dyn9047017100.beaverton.ibm.com>
	<1141075361.10542.21.camel@dyn9047017100.beaverton.ibm.com>
	<20060301175148.2250b36e.akpm@osdl.org>
	<20060302132232.C88229@wobbly.melbourne.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott <nathans@sgi.com> wrote:
>
> On Wed, Mar 01, 2006 at 05:51:48PM -0800, Andrew Morton wrote:
> > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > >
> > > + * Historically, a buffer_head was used to map a single block
> > > + * within a page, and of course as the unit of I/O through the
> > > + * filesystem and block layers.  Nowadays the basic I/O unit
> > > + * is the bio, and buffer_heads are used for extracting block
> > > + * mappings (via a get_block_t call), for tracking state within
> > > + * a page (via a page_mapping) and for wrapping bio submission
> > > + * for backward compatibility reasons (e.g. submit_bh).
> > 
> > Well kinda.  A buffer_head remains the kernel's basic abstraction for a
> > "disk block".
> 
> Thats what I said (meant to say) with
> "buffer_heads are used for extracting block mappings".
> 
> I think by "disk block" you mean what I'm thinking of as a
> "block mapping" (series of contiguous blocks).  I'd think
> of a sector_t as a "disk block", but maybe I'm just wierd
> that way... a better wordsmith should jump in and update
> the comment I guess.

Think of `struct buffer_head' as `struct block'.  If you want to read a
block off the disk, diddle with it and write it back (while, of course,
being coherent with everything else which is going on), the bh is the only
construct we have for this.  
