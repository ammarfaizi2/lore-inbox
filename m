Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130666AbRCEVAX>; Mon, 5 Mar 2001 16:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130664AbRCEVAP>; Mon, 5 Mar 2001 16:00:15 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:35595 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S130663AbRCEVAB>;
	Mon, 5 Mar 2001 16:00:01 -0500
Date: Mon, 5 Mar 2001 14:00:51 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about IRQ_PENDING/IRQ_REPLAY
Message-ID: <20010305140050.G14772@ftsoj.fsmlabs.com>
In-Reply-To: <20010303144856.A18389@ftsoj.fsmlabs.com> <19350127143809.22288@smtp.wanadoo.fr> <20010304230707.L2565@ftsoj.fsmlabs.com> <980l3v$7ct$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <980l3v$7ct$1@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Mar 05, 2001 at 10:15:27AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have about 12 interrupt controllers we end up using on PPC.  I'm
suspicious of any effort to base Linux/PPC generic interrupt control code
paths on a software architecture that's been tested with 3.  More to the
point, we get ASIC's that roll in a standard interrupt controller and add
some "improvements" at the same time.

As for SMP, I'm sure x86 has seen a lot more testing.  I'm not going to
sacrifice time-tested stability so we can look just like x86 and get clean
SMP locking.  We've lost stability already because of some PPC folks'
excitement at getting us to behave like x86 in irq.c.

As for a generic irq.c, as a guiding light, I'm all for it.  It'll
certainly help work with RTLinux.  It'll also help new architectures by
giving them a snap-together port construction kit.  I'm still not going to
sacrifice stability in the short-term for this nice feature in the
long-run.  I'm pretty sure we agree on this.

} Most of arch/i386/kernel/irq.c should really be fairly generic, and the
} fact is that a lot of the issues are a lot more subtle than most people
} really end up realizing.  I got really tired of seeing the same old SMP
} problems that had long since been fixed on x86 show up on other
} architectures. 
} 
} So the plan is to have at least a framework for allowing other
} architectures to use a common irq.c if they want to. Probably not force
} it down peoples throats, because this is an area where the differences
} can be _so_ large that it might not be worth it for everybody. But I
} seriously doubt that PPC is all that different.
} 
} And I seriously doubt that PPC SMP irq handling has gotten _nearly_ the
} amount of testing and hard work that the x86 counterpart has. Things
} like support for CPU affinity, per-irq spinlocks, etc etc.
} 
} Now, I'm not saying that irq.c would necessarily work as-is. It probably
} doesn't support all the things that other architectures might need (but
} with three completely different irq controllers on just standard PCs
} alone, I bet it supports most of it), and I know ia64 wants to extend it
} to be more spread out over different CPU's, but most of the high-level
} stuff probably _can_ and should be fairly common.
