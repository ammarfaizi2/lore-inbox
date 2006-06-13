Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932842AbWFMDvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932842AbWFMDvo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 23:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932841AbWFMDvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 23:51:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:16018 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932842AbWFMDvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 23:51:43 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: broken local_t on i386
Date: Tue, 13 Jun 2006 05:36:01 +0200
User-Agent: KMail/1.9.3
Cc: Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060609214024.2f7dd72c.akpm@osdl.org> <200606122011.52841.ak@suse.de> <Pine.LNX.4.64.0606121212510.20259@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0606121212510.20259@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606130536.01381.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 June 2006 21:15, Christoph Lameter wrote:
> On Mon, 12 Jun 2006, Andi Kleen wrote:
> 
> > > I thought you had some funky segment registers on i386 and x86_64. Cant
> > > they be switched on context switch? If an inc/dec could work relative to
> > > those then you would not need a virtual mapping.
> > 
> > The segment register needs an offset. So you need the linker to generate
> > the offset from the base of the per cpu segment somehow. At compile time the 
> > address is not known so it cannot be done then.
> 
> Define something like a big struct and use offsetof?

That is how the basic architecture specific PDA works (asm/pda.h)

But i don't see a good way to define a big struct for asm/percpu.h

Preprocessing would be too slow and getting all people to put
their per CPU variables into a single header also doesn't seem
like a good idea.

> 
> So the compiler is not able to generate an offset to the beginning of a 
> data segment? 

It's an assembler/linker issue.

-Andi (who is really surprised people make such a big deal out of 
two instructions)

