Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263811AbTKSD2r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 22:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263819AbTKSD2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 22:28:46 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:1665
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263811AbTKSD2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 22:28:45 -0500
Date: Tue, 18 Nov 2003 22:24:00 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Jon Foster <jon@jon-foster.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH][2.6-mm] Fix 4G/4G X11/vm86 oops
In-Reply-To: <3FBAAFDF.5000803@jon-foster.co.uk>
Message-ID: <Pine.LNX.4.53.0311182220570.11537@montezuma.fsmlabs.com>
References: <3FBAAFDF.5000803@jon-foster.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Nov 2003, Jon Foster wrote:

> > The other thing I've found printks to hide before is timing bugs / races.
> > Unfortunately I can't see one here, but maybe someone else can ;-)
> > Maybe inserting a 1ms delay or something in place of the printk would
> > have the same effect?
> 
> One of my colleagues had an interesting bug caused by an
> uninitialized variable - a printk() in the right place happened
> to set the variable (which gcc had put in a register) to the
> correct value for his code to work.

Very nice =)

> I've tried looking for uses of uninitialized registers in entry.S,
> but the assembly there isn't easy to follow.

I've walked that code and can't see anything wrong anywhere.

> What happens if you replace the printk with assembly code
> that clobbers eax, ecx, edx and (most of) eflags?  (Assuming
> I've remembered the calling convention correctly, those are
> the registers that printk will be overwriting).

Well i have tried a number of heavyweight functions, so far none of them 
have had the effect that a printk has had. It's also worth noting that a 
printk lookalike function such as the following, does not fix things 
either.

asmlinkage int kooh_la_la(const char *fmt, ...)
{
	return strlen(fmt);
}

