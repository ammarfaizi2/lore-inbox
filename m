Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265255AbUANI5a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 03:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbUANI5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 03:57:30 -0500
Received: from colin2.muc.de ([193.149.48.15]:1549 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265255AbUANI53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 03:57:29 -0500
Date: 14 Jan 2004 09:58:25 +0100
Date: Wed, 14 Jan 2004 09:58:25 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, jh@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix compilation on gcc 3.4
Message-ID: <20040114085825.GA10916@colin2.muc.de>
References: <20040114083700.GA1820@averell> <20040114084721.GP31589@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114084721.GP31589@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 03:47:22AM -0500, Jakub Jelinek wrote:
> On Wed, Jan 14, 2004 at 09:37:00AM +0100, Andi Kleen wrote:
> > 
> > The upcomming gcc 3.4 has a new inlining algorithm which sometimes
> > fails to inline some "dumb" inlines in the kernel. This sometimes leads
> > to undefined symbols while linking.
> 
> It fails to inline routines with always_inline attribute?
> That sounds like a gcc bug.  always_inline should mean inline always,
> and issue error if for some reason it is impossible.

The problem is that there are some functions that are declared
inline in header files, but there is no body available. When they are
called this ends with an hard error in gcc. I started with fixing
them but eventually gave up because there were so many of them.

In addition you get tons of ugly warnings.

-Andi
