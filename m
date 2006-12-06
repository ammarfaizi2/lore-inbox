Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937565AbWLFTnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937565AbWLFTnx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937564AbWLFTnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:43:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49447 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937561AbWLFTnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:43:51 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061206192939.GX3013@parisc-linux.org> 
References: <20061206192939.GX3013@parisc-linux.org>  <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0612061103260.3542@woody.osdl.org> <20061206190828.GE4587@ftp.linux.org.uk> <Pine.LNX.4.64.0612061122120.3542@woody.osdl.org> 
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
       Christoph Lameter <clameter@sgi.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 06 Dec 2006 19:43:15 +0000
Message-ID: <28576.1165434195@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <matthew@wil.cx> wrote:

> > Ok. For SMP-safety, it's important that any architecture that can't do 
> > this needs to _share_ the same spinlock (on SMP only, of course) that it 
> > uses for the bitops. 
> 
> That doesn't help, since assignment can't be guarded by any lock.

It's not a problem for workqueues, since the only direct assignment to the
management member variable is during initialisation.

But in general cmpxchg() might be a problem with respect to assignment.

atomic_cmpxchg() should be safe wrt atomic_set().

David
