Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270661AbUJURJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270661AbUJURJn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 13:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269116AbUJURGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 13:06:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:60305 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270684AbUJUREN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 13:04:13 -0400
Date: Thu, 21 Oct 2004 10:02:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: Am I paranoid or is everyone out to break my kernel builds
 (Breakage in drivers/pcmcia)
Message-Id: <20041021100212.3fb1e828.akpm@osdl.org>
In-Reply-To: <20041021105026.C3089@flint.arm.linux.org.uk>
References: <20041021100903.A3089@flint.arm.linux.org.uk>
	<20041021023135.074c7988.akpm@osdl.org>
	<20041021105026.C3089@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Thu, Oct 21, 2004 at 02:31:35AM -0700, Andrew Morton wrote:
> > Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > > Take special note of the '&' before 'num' in the above initialiser, and
> > > check the structure:
> > 
> > Something's out of whack with your tree.  You should have:
> 
> Ok, but what's the point of the change?  If it's to indicate that
> we're returning a value, shouldn't the other module_param* macros
> also be fixed in the same way, or do we just like special cases?

<rusty>
module_param_array() takes a variable to put the number of elements in. 
Looking through the uses, many people don't care, so they declare a dummy
or share one variable between several parameters.  The latter is
problematic because sysfs uses that number to decide how many to display.

The solution is to change the variable arg to a pointer, and if the pointer
is NULL, use the "max" value.  This change is fairly small, but fixing up
the callers is a lot of (trivial) churn.
</rusty>
