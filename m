Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbTBNRIB>; Fri, 14 Feb 2003 12:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262089AbTBNRIB>; Fri, 14 Feb 2003 12:08:01 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:33889
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261855AbTBNRIA>; Fri, 14 Feb 2003 12:08:00 -0500
Date: Fri, 14 Feb 2003 12:16:12 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Richard T Henderson <rth@twiddle.net>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] Protect smp_call_function_data w/ spinlocks on
 Alpha
In-Reply-To: <20030214175332.A19234@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.50.0302141158070.3518-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0302140634000.3518-100000@montezuma.mastecende.com>
 <20030214175332.A19234@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2003, Ivan Kokshaysky wrote:

> On Fri, Feb 14, 2003 at 06:51:54AM -0500, Zwane Mwaikambo wrote:
> > 	This is an untested patch to remove the custom mutex, however it 
> > doesn't maintain the same semantics wrt 'retry' and unconditionally 
> > blocks on contention.
> 
> Why do you want to remove it? The critical data here is a single pointer
> which can be effectively protected without spinlock.

Ok the reason being is that the lock not only protects the 
smp_call_function_data pointer but also acts as a lock for that critical 
section. Without it you'll constantly be overwriting the pointer halfway 
through IPI acceptance (or even worse whilst a remote CPU is assigning the 
data members).

Although i'm not denying there isn't a way to do this lockless, i believe 
what some architectures did was poll on the pointer then do an assignment 
which i think is a bit too much effort when using a spinlock is much 
saner. Regardless i'd be interested to hear about alternatives.

Cheers,
	Zwane
-- 
function.linuxpower.ca
