Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVFJWi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVFJWi2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 18:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVFJWi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 18:38:27 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:10588
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261319AbVFJWh5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 18:37:57 -0400
Date: Sat, 11 Jun 2005 00:37:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Bill Huey <bhuey@lnxw.com>
Cc: Lee Revell <rlrevell@joe-job.com>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050610223751.GE6564@g5.random>
References: <20050608022646.GA3158@us.ibm.com> <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com> <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com> <20050610173728.GA6564@g5.random> <1118436338.6423.48.camel@mindpipe> <20050610210614.GD6564@g5.random> <20050610221914.GA20694@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610221914.GA20694@nietzsche.lynx.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 03:19:14PM -0700, Bill Huey wrote:
> managable problem. Again, this a problem for all RTOS system and their
> supporting drivers as well since they often come from BSD open source
> community.

Did you read Karim's answer at all?

Those RTOS don't have frenetic development in scheduler and all other
subsystems and they may be simpler as well, so perhaps you can disable
L2 and L3 and measure all possible paths that kernel can take in
invoking your rt code, but I doubt you're going to keep it up with linux
development in demonstrating the worst case deadline in every possible
hardware. Measuring all possible paths of a nanokernel is absolutely
trivial in comparison cause there are no different paths, so it's very
easy to give a worst case deadline to the RTAI/rtlinux designs, while it
sounds a total pain for preempt-RT, even after the local_irq_disable
issue is fixed (which is feasible as Daniel seems to have implemented
already).

metal hard solutions are fine where having an exact deadline isn't
required, or in places where missing the deadline results in a crashed
cellphone (even if I really hate it if my cellphone crashes, and yes
even the linux cellphone crashes by doing a cp /dev/sda /dev/null, the
usbstorage thingy has some problem in accessing the partition table of
the internal flash), but again if they would have picked a RTOS for the
project I linked on linuxdevices.com that has to react in 50usec, I
think they would have done a mistake when ruby-hard solutions like
RTAI/rtlinux are available on linux. So kudos to them for their IMHO
best correct choice of RT design.

RTOS may be fine for cellphones or other stuff where you may not even
need hard-RT at all, but you just want the lowest possible latency, but
I'd _never_ use it whenever I need a true deadline, since other more
reliable solutions are possible without much more complexity.

But this is me and my focus is on projects like the one quoted on
linuxdevices, cellphones may not even need hard-RT at all since I doubt
anybody would offload the gsm compression to the main linux cpu with the
risk of doing a buffer overflow during decompression and crashing
stations. You're free to use a metal-hard solution for problems that
requires ruby-hard, but I think that's very wrong choice after you're
aware it's not possible to math demonstrate a worst case latency with
metal-hard solutions.

About the fact the kernel can crash, and a driver can corrupt memory,
that's the difference between ruby and diamond.

I simply think RTOS is an awful solution to hard-RT, RTAI/rtlinux
designs are much more reliable. There are certainly areas where RTOS is
acceptable, and this is where hard-RT isn't required and you simply want
the lowest possible latency when invoking syscalls like alsa ioctls. But
when alsa kernel code is out of the equation I'd never use RTOS to get
the kernel out of the way.
