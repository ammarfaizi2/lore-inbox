Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWEIUmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWEIUmT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWEIUmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:42:19 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:30661 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1751160AbWEIUmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:42:19 -0400
Date: Tue, 9 May 2006 21:42:07 +0100
From: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, "Martin J. Bligh" <mbligh@mbligh.org>,
       Chris Wright <chrisw@sous-sol.org>, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org, Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 15/35] subarch support for controlling interrupt delivery
Message-ID: <20060509204207.GQ7834@cl.cam.ac.uk>
References: <20060509084945.373541000@sous-sol.org> <200605091807.57522.ak@suse.de> <20060509162959.GL7834@cl.cam.ac.uk> <200605091831.37757.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605091831.37757.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 06:31:37PM +0200, Andi Kleen wrote:
> On Tuesday 09 May 2006 18:29, Christian Limpach wrote:
> > On Tue, May 09, 2006 at 06:07:57PM +0200, Andi Kleen wrote:
> > > 
> > > > 
> > > > Anybody want to comment on the performance impact of making
> > > > local_irq_* non-inline functions?
> > > 
> > > I would guess for that much inline code it will be even a win to not
> > > inline because it will save icache.
> > 
> > Maybe, although some of the macros compile down to only 2-3 instructions.
> 
> Can you post before/after vmlinux size numbers for inline/out of line?

Sure, although it is a bit tricky since the #define's pass non-pointer
arguments by reference.  This would also make it quite ugly to change
these.

Everything[1] in line:
-rwxr-xr-x  1 cl349 cl349  2633640 May  9 19:42 vmlinux-inline-stripped
Everything out of line:
-rwxr-xr-x  1 cl349 cl349  2621352 May  9 19:45 vmlinux-outline-stripped

Additionally, I changed did a build with only __sti and __restore_flags
out of line and the others in line:
-rwxr-xr-x  1 cl349 cl349  2617256 May  9 19:50 vmlinux-hybrid-stripped

__sti and __restore_flags are the ones which generate more code,
so it seemed more sensible to make the out of line.

Any conlusions?

    christian

[1] __cli, __sti, __save_flags, __restore_flags, __save_and_cli, irqs_disabled

