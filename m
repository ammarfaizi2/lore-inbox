Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbVLTSbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbVLTSbM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 13:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbVLTSbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 13:31:12 -0500
Received: from waste.org ([64.81.244.121]:34013 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750875AbVLTSbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 13:31:12 -0500
Date: Tue, 20 Dec 2005 12:30:26 -0600
From: Matt Mackall <mpm@selenic.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Light-weight dynamically extended stacks
Message-ID: <20051220183025.GG3356@waste.org>
References: <20051219001249.GD11856@waste.org> <20051219183604.GT23349@stusta.de> <20051220002759.GE3356@waste.org> <20051220164316.GG6789@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051220164316.GG6789@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 05:43:17PM +0100, Adrian Bunk wrote:
> On Mon, Dec 19, 2005 at 06:27:59PM -0600, Matt Mackall wrote:
> >...
> > So why am I raising this idea now at all? Because I think Neil's patch
> > is too clever and too specific to block layer stacking and I'd rather
> > have a more general solution. Block is by no means the only part of
> > the system that allows nesting and pathological combinations surely
> > still exist. And will be introduced in the future.
> > 
> > Also note that my approach might make it reasonable to use one-page
> > stacks everywhere, not just on x86.
> >...
> 
> I'm really looking forward to seeing your patch.

I might get to it after the New Year.

> It will e.g. be interesting to measure whether there'll be any 
> performance impact.
> 
> And since after this patch driver authors might become more sloppy with 
> stack usage since there's no longer a hard limit, it will be especially 
> interesting to see how you'll implement ensuring that there are no 
> additional stack usages > 1 kB between two invocations of you check 
> function, because otherwise your patch won't work reliable.

I can give you the answer to that now: use the existing stack overflow
detection.

This is not intended to be an automatic scheme. To use it, you must
actually insert code into the troublesome codepaths, which will of
course serve as a red flag for code review.

It's entirely possible that this idea won't be needed on x86 because
we can manage to squeeze everything into 4k. But 32-bit x86's days as
the majority platform are numbered. 

-- 
Mathematics is the supreme nostalgia of our time.
