Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWHGGNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWHGGNp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 02:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWHGGNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 02:13:45 -0400
Received: from ozlabs.org ([203.10.76.45]:29663 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750819AbWHGGNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 02:13:44 -0400
Subject: Re: [PATCH 3/4] x86 paravirt_ops: implementation of paravirt_ops
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200608070739.33428.ak@muc.de>
References: <1154925835.21647.29.camel@localhost.localdomain>
	 <1154925943.21647.32.camel@localhost.localdomain>
	 <1154926048.21647.35.camel@localhost.localdomain>
	 <200608070739.33428.ak@muc.de>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 16:13:41 +1000
Message-Id: <1154931222.7642.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-07 at 07:39 +0200, Andi Kleen wrote:
> On Monday 07 August 2006 06:47, Rusty Russell wrote:
> > This patch does the dumbest possible replacement of paravirtualized
> > instructions: calls through a "paravirt_ops" structure.  Currently
> > these are function implementations of native hardware: hypervisors
> > will override the ops structure with their own variants.
> 
> You should call it HAL - that would make it clearer what it is.

People get visions of grandeur when HAL is mentioned: they think it'll
abstract everything.  I really only want to do the minimum needed for
the hypervisors we have on the table today.

Maybe one day it will abstract everything, then we can call it a HAL.
But I won't be doing that work 8)

> I think I would prefer to patch always. Is there a particular
> reason you can't do that?

We could patch all the indirect calls into direct calls, but I don't
think it's worth bothering: most simply don't matter.

The implementation ensures that someone can get boot on a new hypervisor
by populating the ops struct.  Later they can go back and implement the
patching stuff.

> It would be better to merge this with the existing LOCK prefix patching
> or perhaps the normal alternative() patcher (is there any particular
> reason you can't use it?)
> 
> Three alternative patching mechanisms just seems to be too many

Each backend wants a different patch, so alternative() doesn't cut it.
We could look at generalizing alternative() I guess, but it works fine
so I didn't want to touch it.

Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

