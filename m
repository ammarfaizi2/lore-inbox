Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266693AbUF3PVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266693AbUF3PVd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 11:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266699AbUF3PV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 11:21:27 -0400
Received: from janus.foobazco.org ([198.144.194.226]:1408 "EHLO
	mail.foobazco.org") by vger.kernel.org with ESMTP id S266693AbUF3PVK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 11:21:10 -0400
Date: Wed, 30 Jun 2004 08:21:07 -0700
From: wesolows@foobazco.org
To: "David S. Miller" <davem@redhat.com>
Cc: Jamie Lokier <jamie@shareable.org>, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: A question about PROT_NONE on Sparc and Sparc64
Message-ID: <20040630152107.GA20438@foobazco.org>
References: <20040630030503.GA25149@mail.shareable.org> <20040629221711.77f0fca5.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040629221711.77f0fca5.davem@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 10:17:11PM -0700, David S. Miller wrote:

> > In include/asm-sparc/pgtsrmmu.h, there's:
> > 
> > #define SRMMU_PAGE_NONE    __pgprot(SRMMU_VALID | SRMMU_CACHE | \
> > 				    SRMMU_PRIV | SRMMU_REF)
> > #define SRMMU_PAGE_RDONLY  __pgprot(SRMMU_VALID | SRMMU_CACHE | \
> > 				    SRMMU_EXEC | SRMMU_REF)
> > 
> > This one bothers me.  The difference is that PROT_NONE pages are not
> > accessible to userspace, and not executable.
> > 
> > So userspace will get a fault if it tries to read a PROT_NONE page.
> > 
> > But what happens when the kernel reads one?  Don't those bits mean
> > that the read will succeed?  I.e. write() on a PROT_NONE page will
> > succeed, instead of returning EFAULT?
> > 
> > If so, this is a bug.  A minor bug, perhaps, but nonetheless I wish to
> > document it.
> 
> Yes this one is a bug and not intentional.
> 
> Keith W., we need to fix this.  Probably the simplest fix is just to
> drop the SRMMU_VALID bit.

Ok, I'll try this approach and see what happens.

-- 
Keith M Wesolowski
