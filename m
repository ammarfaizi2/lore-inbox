Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422643AbWBHXoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422643AbWBHXoL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 18:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422642AbWBHXoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 18:44:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45202 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422643AbWBHXoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 18:44:10 -0500
Date: Wed, 8 Feb 2006 15:43:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: ak@suse.de, pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Terminate process that fails on a constrained allocation
Message-Id: <20060208154332.715d617d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0602081526060.5184@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com>
	<200602082201.12371.ak@suse.de>
	<20060208130351.fc1c759c.pj@sgi.com>
	<200602082221.35671.ak@suse.de>
	<20060208133909.183f19ea.akpm@osdl.org>
	<Pine.LNX.4.62.0602081526060.5184@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> On Wed, 8 Feb 2006, Andrew Morton wrote:
> 
> > > I think it should be put into 2.6.16. Andrew?
> > 
> > Does every single caller of __alloc_pages(__GFP_FS) correctly handle a NULL
> > return?  I doubt it, in which case this patch will cause oopses and hangs.
> 
> If a caller cannot handle NULL then __GFP_NOFAIL has to be set, right?

That would assume non-buggy code.  I'm talking about the exercising of
hitherto-unused codepaths.  We've fixed many, many pieces of code which
simply assumed that kmalloc(GFP_KERNEL) succeeds.  I doubt if many such
simple bugs still exist, but there will be more subtle ones in there.

