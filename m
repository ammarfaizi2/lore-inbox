Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318944AbSH1UTR>; Wed, 28 Aug 2002 16:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318943AbSH1UTR>; Wed, 28 Aug 2002 16:19:17 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:23288 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318944AbSH1UTP>; Wed, 28 Aug 2002 16:19:15 -0400
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dominik Brodowski <devel@brodo.de>, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0208281246560.4507-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0208281246560.4507-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 28 Aug 2002 21:25:53 +0100
Message-Id: <1030566353.7290.71.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-28 at 20:49, Linus Torvalds wrote:
> The point is that the _policy_ (not the end result) needs to be pushed 
> down to the kernel, so that the kernel can do the right thing with it.
> 
> That policy can be updated in "real time" from user space, of course. But 
> the fact is that you cannot just set a frequency and leave it at that, it 
> doesn't work.

If you look at the papers on the original ARM cpufreq code you'll see a
case where very long granuality user driven policy is pretty much
essential. The kernel sometimes does not have enough information.

Take a trivial example. My CPU is 99% idle. Should you drop the clock
speed right down. On a generic system yes, on a system which has to meet
very tight real time deadlines quite possibly not. In fact some
processors (eg the MediaGX) actually have hardware assists for speeding
the CPU clock up for realtime interrupt processing paths.

That argument ultimately boils down to "should the /proc interface to
cpufreq" be a seperate module to the core cpu_freq code called by kernel
policy engines like ACPI. The answer is obviously "yes" - /proc is just
one of the policy engines.




