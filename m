Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318381AbSGaOms>; Wed, 31 Jul 2002 10:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318382AbSGaOms>; Wed, 31 Jul 2002 10:42:48 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:44017 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S318381AbSGaOms>; Wed, 31 Jul 2002 10:42:48 -0400
Date: Wed, 31 Jul 2002 10:46:13 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)
Message-ID: <20020731104613.B10270@redhat.com>
References: <20020730054111.GA1159@dualathlon.random> <20020730084939.A8978@redhat.com> <20020730214116.GN1181@dualathlon.random> <20020730175421.J10315@redhat.com> <20020731004451.GI1181@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020731004451.GI1181@dualathlon.random>; from andrea@suse.de on Wed, Jul 31, 2002 at 02:44:51AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2002 at 02:44:51AM +0200, Andrea Arcangeli wrote:
> So I'm not very excited about this change, I would prefer the previous
> version. Also consider with the vsyscall doing the gettimeofday
> calculation in userspace based on "when" rather than in-kernel isn't
> going to be more expensive than your new API even of applications that
> really want the "when" behaviour instead of the "timeout". While the
> applications that wants the "timeout" this way we'll be forced to a
> vgettimeofday in userspace and one in kernel which is a pure overhead
> for them.

That's still racy.  There are several hundred instructions from the 
time the timeout is calculated until the kernel actually uses the 
timeout to calculate an offset relative to jiffies, during which a 
task switch may occur.  I suppose that this could be handled via a 
separate timer interface (we should probably implement posix timers 
anyways).  I can see the arguments, and I guess it's easier to just 
revert it.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
