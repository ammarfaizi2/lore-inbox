Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263687AbUGABuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbUGABuz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 21:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbUGABuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 21:50:55 -0400
Received: from mail.shareable.org ([81.29.64.88]:38061 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263687AbUGABuy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 21:50:54 -0400
Date: Thu, 1 Jul 2004 02:50:47 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Nicolas Pitre <nico@cam.org>
Cc: Ian Molton <spyro@f2s.com>, linux-arm-kernel@lists.arm.linux.org.uk,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: A question about PROT_NONE on ARM and ARM26
Message-ID: <20040701015047.GA1094@mail.shareable.org>
References: <20040630233014.GC32560@mail.shareable.org> <Pine.LNX.4.44.0406302100260.1713-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0406302100260.1713-100000@xanadu.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Pitre wrote:
> > 	cmp	r0, #(TASK_SIZE - (1<<24))
> > 
> > I.e. just compare against the largest constant that can be
> > represented.  For accesses to the last part of userspace, it's a
> > penalty of 4 instructions -- but it might work out to be a net gain.
> 
> Maybe not.  The user stack is located at the top so any user buffer 
> allocated on the stack would be penalized.

I agree.  I don't know if it would work out to be a net gain on
average or a net loss.

It saves a couple of instructions, but when it fails the cost is only
a few instructions anyway.

Probably for get_user & put_user, the common case _is_ to be on the
user's stack, so Russell's code would be better.

-- Jamie
