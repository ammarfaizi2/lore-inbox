Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271131AbUJUX6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271131AbUJUX6w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271099AbUJUX4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:56:55 -0400
Received: from ozlabs.org ([203.10.76.45]:30607 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S271131AbUJUXqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 19:46:39 -0400
Subject: Re: Am I paranoid or is everyone out to break my kernel builds
	(Breakage in drivers/pcmcia)
From: Rusty Russell <rusty@rustcorp.com.au>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041021105026.C3089@flint.arm.linux.org.uk>
References: <20041021100903.A3089@flint.arm.linux.org.uk>
	 <20041021023135.074c7988.akpm@osdl.org>
	 <20041021105026.C3089@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1098399488.12103.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 22 Oct 2004 09:46:26 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 19:50, Russell King wrote:
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

Only module_param_array() sets a number: the number of elements in the
array.  By making that arg a pointer, we can put "NULL" there, since it
turned out many people didn't care how many elements there were (and
were overloading the same variable for all their arrays, which breaks
printing in sysfs).

Hope that helps,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

