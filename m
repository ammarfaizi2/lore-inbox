Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbVAOBHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbVAOBHT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbVAOBEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 20:04:40 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:5525
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262093AbVAOBAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 20:00:13 -0500
Subject: Re: 2.6.11-rc1-mm1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: karim@opersys.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050114162652.73283f2e.akpm@osdl.org>
References: <20050114002352.5a038710.akpm@osdl.org>
	 <1105740276.8604.83.camel@tglx.tec.linutronix.de>
	 <41E85123.7080005@opersys.com>
	 <1105747280.13265.72.camel@tglx.tec.linutronix.de>
	 <20050114162652.73283f2e.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 15 Jan 2005 02:00:09 +0100
Message-Id: <1105750810.13265.126.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-14 at 16:26 -0800, Andrew Morton wrote:
> ?  I see no XML in there.
> 
> akpm:/usr/src/25> grep -i xml patches/ltt* patches/relayfs*
> patches/ltt-core-headers.patch:+#define LTT_CUSTOM_EV_FORMAT_TYPE_XML   3
> akpm:/usr/src/25> 

And what is this define for ? 

> > The kernel is not the place to fix your postprocessing problems. Sure
> > you have to do more complicated stuff, but you move the burden from
> > kernel to a place where it does not hurt.
> 
> I thought Karim said that this was a form of data compression.

Adding data compression in form of an additional computation is really
inventive. Provide the information in a way that postprocessing tools
can do the job without adding computations to the kernel is the goal. I
pointed out a couple of those possibilities in my previous mail.

> > 
> > Yes, the "you would anyway have to go down the same path we have"
> > argument really scares me away from doing so. 
> > 
> > I don't buy this kind of arguments. 
> 
> I do.  When someone has been working on a real-world project for several
> years we *need* to understand all the problems which that person
> encountered before we can competently review the implementation. 

I'm working on real world problems for quite a long time and your
argument should apply the other way too. I have implemented
instrumentation in different flavours before, so I know exactly what I'm
talking about.

I'm well aware of the worthiness of someones experience and I'm not
going to throw it away, but I don't see the reverse, that accepting this
is forcing me to blindly agree with arguments from those persons.

> Surelyyou've been there before: you throw out all the old stuff, 
> write a new one and once you've addressed all the warts and corner 
> cases and weird-but-valid requirements it ends up with the same 
> complexity as the original.

I disagree at this point. 

Accepting the maturness of an implementation just from the argument that
somebody has done this for a couple of time and therefor gained
experience is a quite weak argument, if one can point out the opposite
by just reading the code and making a short real life test.

If the goal is to provide some "cool to have" instrumentation in the
kernel, then I stop arguing immidiately. 

But this can not be the goal. If we introduce instrumentation facilities
into the kernel, then they must be for general use, optimized for non
intrusiveness and replace all the other "[] provide measurement X"
config options instead of introducing parallel mechanisms. 

I do not accept unnecessary complexity in the kernel, when you are able
to achieve the same goal by putting more thoughts into the
postprocessing. The kernel code is responsible to provide a simple and
fast interface for those tasks and nothing more. I don't see the point
why we need 150k additional code with limitations/problems, which are
even obvious without running it, instead of a simple interface to
userland where different postprocessors can compete to do the job more
or less perfect.

As I pointed out in my reply to Tim, I would be happy to have
instrumentation in the kernel, but I'm not willing to pay the price
which is requested by the currently discussed implementation.

tglx



