Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263555AbUGABFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUGABFb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 21:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbUGABFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 21:05:31 -0400
Received: from modemcable166.48-200-24.mc.videotron.ca ([24.200.48.166]:10906
	"EHLO xanadu.home") by vger.kernel.org with ESMTP id S263555AbUGABFZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 21:05:25 -0400
Date: Wed, 30 Jun 2004 21:05:15 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Jamie Lokier <jamie@shareable.org>
cc: Ian Molton <spyro@f2s.com>, <linux-arm-kernel@lists.arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: A question about PROT_NONE on ARM and ARM26
In-Reply-To: <20040630233014.GC32560@mail.shareable.org>
Message-ID: <Pine.LNX.4.44.0406302100260.1713-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jul 2004, Jamie Lokier wrote:

> Russell King wrote:
> > Ok, this could work, but there's one gotcha - TASK_SIZE-4 doesn't fit
> > in an 8-bit rotated constants, so we need 2 extra instructions:
> > 
> > __get_user_4:
> > 	mov	r1, #TASK_SIZE
> > 	sub	r1, r1, #4
> > 	cmp	r0, r1
> > 4:	ldrlet	r1, [r0]
> > 	movle	r0, #0
> > 	movle	pc, lr
> > 	...
> 
> One more possibility:
> 
> 	cmp	r0, #(TASK_SIZE - (1<<24))
> 
> I.e. just compare against the largest constant that can be
> represented.  For accesses to the last part of userspace, it's a
> penalty of 4 instructions -- but it might work out to be a net gain.

Maybe not.  The user stack is located at the top so any user buffer 
allocated on the stack would be penalized.


Nicolas

