Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272620AbRJCKTv>; Wed, 3 Oct 2001 06:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272592AbRJCKTm>; Wed, 3 Oct 2001 06:19:42 -0400
Received: from s2.relay.oleane.net ([195.25.12.49]:18436 "HELO
	s2.relay.oleane.net") by vger.kernel.org with SMTP
	id <S272576AbRJCKTd>; Wed, 3 Oct 2001 06:19:33 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: James Simmons <jsimmons@transvirtual.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: Huge console switching lags
Date: Wed, 3 Oct 2001 12:19:44 +0200
Message-Id: <20011003101944.29249@smtp.adsl.oleane.com>
In-Reply-To: <E15oYUA-0006HG-00@the-village.bc.nu>
In-Reply-To: <E15oYUA-0006HG-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>    The software accel functions needed by the console layer (copyarea,
>> fillrect, and drawimage) have been already written. Okay the drawimage one
>> needs alot of work. I haven't benchmarked the new code versus the current
>
>On x86 they'll probably make no difference at all, unless the old code
>is really really crap. Your bottleneck is the PCI bus. All you can do is
>avoid reads.

Well, there are indeed a few improvements to get with machine specific
optimisations on unaccelerated framebuffer.

One example is, on PPC, the use of a floating point register to do the
blits 64 bits at a time. This allow the PCI host controller to generate
bursts of 2 32 bits transactions (for machines with controllers unable
to write combine). Of course, having such optimisations in the kernel
is tricky because of the lazy FPU switching (well, at least on PPC),
but the point is that improvement _is_ possible.

Regards,
Ben.

