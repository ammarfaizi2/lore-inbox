Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbVCITgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVCITgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 14:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262314AbVCITgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 14:36:07 -0500
Received: from colin2.muc.de ([193.149.48.15]:17677 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262225AbVCITez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 14:34:55 -0500
Date: 9 Mar 2005 20:34:54 +0100
Date: Wed, 9 Mar 2005 20:34:54 +0100
From: Andi Kleen <ak@muc.de>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [patch 1/1] x86-64: forgot asmlinkage on sys_mmap
Message-ID: <20050309193454.GB17918@muc.de>
References: <20050305190005.0943C4B47@zion> <m1br9swx54.fsf@muc.de> <200503091924.00518.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503091924.00518.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 07:24:00PM +0100, Blaisorblade wrote:
> On Wednesday 09 March 2005 18:24, Andi Kleen wrote:
> > blaisorblade@yahoo.it writes:
> > > CC: Andi Kleen <ak@suse.de>
> > >
> > > I think it should be there, please check better.
> >
> > It doesn't matter. asmlinkage is a nop on x86-64.
> 
> Yes, otherwise nothing would work on x86-64 with mmap broken, but for 
> cleanness and for the case this change it should be there (otherwise why 
> asmlinkage is used in the rest of the file).

Only because it was cut'n'pasted from i386 originally.

> 
> And for i386 asmlinkage acquired significance only recently.

Actually it doesn't neither on i386. That's because entry.S happens to put the 
arguments both into registers and the stack in the right order, so both 
register and stack argument calling conventions work.

But it is slightly safer to have it. When you use the stack arguments
the C code is allowed to modify it, and when the system call is restarted
later you could see garbage. In practice that's not a big issue because
only very few system calls are restartable.

ptrace also could see corrupted state, but that's in general a non issue.

-Andi

