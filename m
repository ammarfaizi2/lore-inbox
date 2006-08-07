Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWHGLJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWHGLJd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 07:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWHGLJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 07:09:33 -0400
Received: from styx.suse.cz ([82.119.242.94]:24464 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932083AbWHGLJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 07:09:32 -0400
Date: Mon, 7 Aug 2006 13:09:31 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andi Kleen <ak@muc.de>
Cc: Dmitry Torokhov <dtor@insightbb.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Turn rdmsr, rdtsc into inline functions, clarify names
Message-ID: <20060807110931.GM27757@suse.cz>
References: <1154771262.28257.38.camel@localhost.localdomain> <1154832963.29151.21.camel@localhost.localdomain> <20060806031643.GA43490@muc.de> <200608062243.45129.dtor@insightbb.com> <20060807084850.GA67713@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807084850.GA67713@muc.de>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 10:48:50AM +0200, Andi Kleen wrote:
> On Sun, Aug 06, 2006 at 10:43:44PM -0400, Dmitry Torokhov wrote:
> > On Saturday 05 August 2006 23:16, Andi Kleen wrote:
> > > This whole thing is broken, e.g. on a preemptive kernel when the
> > > code can switch CPUs 
> > > 
> > 
> > Would not preempt_disable fix that?
> 
> Partially, but you still have other problems. Please just get rid
> of it. Why do we have timer code in the kernel if you then chose
> not to use it?
 
The problem is that gettimeofday() is not always fast. The joystick
drivers will not work if the timing calls take significant time compared
to an inb() from ISA/LPC space.

That's why they don't fallback to PIT timing when TSC is not available -
io counting is a better option.

-- 
Vojtech Pavlik
Director SuSE Labs
