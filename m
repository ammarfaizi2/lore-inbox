Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266111AbTGITDI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 15:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268536AbTGITDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 15:03:08 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:52395
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S266111AbTGITDA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 15:03:00 -0400
Date: Wed, 9 Jul 2003 15:17:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: ->direct_IO API change in current 2.4 BK
Message-ID: <20030709191739.GH15293@gtf.org>
References: <20030709133109.A23587@infradead.org> <Pine.LNX.4.55L.0307091506180.27004@freak.distro.conectiva> <16140.24595.438954.609504@charged.uio.no> <200307092041.42608.m.c.p@wolk-project.de> <16140.25619.963866.474510@charged.uio.no> <20030709190531.GF15293@gtf.org> <16140.26693.72927.451259@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16140.26693.72927.451259@charged.uio.no>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 09:08:53PM +0200, Trond Myklebust wrote:
> >>>>> " " == Jeff Garzik <jgarzik@pobox.com> writes:
> 
>      > s/replacing/adding/
> 
> Revert ;-)
> 
>      > A new ->direct_IO2 hook would be an addition, so you really
>      > want to simply add another feature flag.
> 
> You missed the point. This is *instead* of ->direct_IO2. It's only
> purpose would be to distinguish between the old
> 
>  int (*direct_IO)(int, struct inode *, struct kiobuf *, unsigned long, int);
> 
> 
> and the new
> 
>  int (*direct_IO)(int, struct file *, struct kiobuf *, unsigned long, int);

I respectfully disagree, then.

The 2.5 direct_IO API is already different from 2.4, so, changing
the 2.4 stable API implies creating yet another different version of
the API.

When this situation presented itself earlier, with reiserfs, the
solution was ->read_inode2.  I think that same situation applies here.

Having the stable API change, conditional on a define, is really
nasty and IMO will create maintenance and support headaches down
the line.  I do not recall Linux VFS _ever_ having a hook's definition
conditional.  We should not start now...

We need a 2.4-specific solution for this.  ->direct_IO2 should suffice,
and it follows historical example.

XFS, ocfs, and others need only to test the HAVE_NEW_24_DIRECT_IO
define.

In the core kernel implementation, it is trivial to say "if direct_IO2
is non-NULL, use that, otherwise use direct_IO", without needing to make
any code conditional at all.

	Jeff



