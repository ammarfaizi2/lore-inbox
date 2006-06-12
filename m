Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752139AbWFLSfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbWFLSfm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 14:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbWFLSfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 14:35:42 -0400
Received: from ns.suse.de ([195.135.220.2]:58272 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752139AbWFLSfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 14:35:41 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: broken local_t on i386
Date: Mon, 12 Jun 2006 19:35:02 +0200
User-Agent: KMail/1.8
Cc: Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060609214024.2f7dd72c.akpm@osdl.org> <200606121906.28692.ak@suse.de> <Pine.LNX.4.64.0606121124510.19770@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0606121124510.19770@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606121935.02693.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 June 2006 20:27, Christoph Lameter wrote:
> On Mon, 12 Jun 2006, Andi Kleen wrote:
> > It does, but the per cpu data that everybody uses doesn't reside in the
> > PDA because it wasn't possible to make this work with binutils
> >
> > It would require a relocation relative to another symbol which isn't
> > really supported.
>
> I dont think you need a relocation relative to another symbol. Map the
> pda to a virtual adress range. That is then translated with a
> processor specific page table to various physical addresses.

Per processor page tables are not really practical on x86-64. They would
get really messy because you would need to duplicate the top level
of the page tables per CPU.

>
> > At some point I considered using runtime patching to work around
> > this limitation, but it would be some work and relatively complex.
>
> Well this would drastically decreased the overhead for PDA access and fix
> local.t

Saving two instructions? And PDA is usually in L1. I doubt you could benchmark
a difference.

-Andi
