Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbUCKXeA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 18:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbUCKXeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 18:34:00 -0500
Received: from colin2.muc.de ([193.149.48.15]:20243 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261804AbUCKXd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 18:33:59 -0500
Date: 12 Mar 2004 00:33:57 +0100
Date: Fri, 12 Mar 2004 00:33:57 +0100
From: Andi Kleen <ak@muc.de>
To: Joe Thornber <thornber@redhat.com>
Cc: Mickael Marchand <marchand@kde.org>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-ID: <20040311233357.GA46488@colin2.muc.de>
References: <1ysXv-wm-11@gated-at.bofh.it> <1yxuq-6y6-13@gated-at.bofh.it> <m3hdwnawfi.fsf@averell.firstfloor.org> <200403111445.35075.marchand@kde.org> <20040311213803.GL18345@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040311213803.GL18345@reti>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 09:38:03PM +0000, Joe Thornber wrote:
> On Thu, Mar 11, 2004 at 02:45:35PM +0100, Mickael Marchand wrote:
> > hmm right now, dm/lvm absolutely does not work on amd64/32 bits. all ioctls 
> > calls are failling...
> 
> This one has me stumped.  I've tested on sparc64/debian and Kevin
> Corry has tested on PPC and neither of us have problems.  So it looks

ppc and sparc64 are different from x86-64 and ia64.

The problem on i386 is that alignof(long long) is different between
32bit and 64bit.  That's not the case on the riscs.

This causes problems either with moving fields around/after 64bit 
values and worse it changes the alignment of whole structures in
arrays too (because alignof(struct) is the largest alignment needed
by any members) 

> like an amd64 only problem, does 2.6.4 vanilla work ?  (I don't have
> access to one of these machines).

Most likely it's one of your arrays. You pass arrays, right? 

-Andi
