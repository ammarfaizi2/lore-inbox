Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318501AbSGSJkX>; Fri, 19 Jul 2002 05:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318502AbSGSJkX>; Fri, 19 Jul 2002 05:40:23 -0400
Received: from ns.suse.de ([213.95.15.193]:12814 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318501AbSGSJkX>;
	Fri, 19 Jul 2002 05:40:23 -0400
Date: Fri, 19 Jul 2002 11:43:00 +0200
From: Andi Kleen <ak@suse.de>
To: Andreas Jaeger <aj@suse.de>
Cc: Andi Kleen <ak@suse.de>, Chris Friesen <cfriesen@nortelnetworks.com>,
       linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Second x86-64 kernel snapshot based on 2.4.19rc1 released
Message-ID: <20020719114300.A14588@wotan.suse.de>
References: <20020716220302.A5400@wotan.suse.de> <3D347F9B.58740355@nortelnetworks.com> <20020716222640.A10397@wotan.suse.de> <ho4rew5gwk.fsf@gee.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ho4rew5gwk.fsf@gee.suse.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2002 at 09:13:47AM +0200, Andreas Jaeger wrote:
> Andi Kleen <ak@suse.de> writes:
> 
> > On Tue, Jul 16, 2002 at 04:18:35PM -0400, Chris Friesen wrote:
> >> Andi Kleen wrote:
> >> 
> >> > - vsyscalls are currently disabled because they trigger too many linker bugs together
> >> > with HPET timers. The vsyscall pages just call normal syscalls.
> >> 
> >> I assume that the linker is going to get fixed before general x86-64 release so
> >> these can be used together?
> >
> > Yes, the problem is being worked on.
> 
> It looks currently like a kernel bug - the linker is fine.  We're
> currently working on a proper fix for this and I hope that Andi's next
> kernel will work correctly.

If you refer to the SIZEOF undefined symbol thing - that was a different
problem and indeed a kernel bug. But with full vsyscalls we run into
more relocation problems because the linker seems to have problems
with the secondary mapping used by vsyscalls with more complex code.
Of course it could be still a kernel bug, but I do not see where it 
should come from.

In short the mapping trick used by the current vsyscall code is very 
nasty. It requires quite some non obvious vmlinux.lds trickery that
seems to easily cause/trigger bugs in both binutils and kernel. I would
be better to find a more maintaineable solution for the secondary mappings.

-Andi
