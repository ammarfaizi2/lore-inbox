Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030372AbWJJVAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbWJJVAa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbWJJVAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:00:30 -0400
Received: from tla.xelerance.com ([193.110.157.130]:19985 "EHLO
	tla.xelerance.com") by vger.kernel.org with ESMTP id S1030369AbWJJVA2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:00:28 -0400
Date: Tue, 10 Oct 2006 23:03:58 +0200 (CEST)
From: Paul Wouters <paul@xelerance.com>
To: Gabor Gombas <gombasg@sztaki.hu>
cc: fedora-xen@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: more random device badness in 2.6.18 :(
In-Reply-To: <20061010205051.GB14865@boogie.lpds.sztaki.hu>
Message-ID: <Pine.LNX.4.63.0610102257100.27986@tla.xelerance.com>
References: <Pine.LNX.4.63.0610101944010.21866@tla.xelerance.com>
 <20061010205051.GB14865@boogie.lpds.sztaki.hu>
X-Message-Flag: You should stop using Outlook and switch to Thunderbird
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-From: paul@xelerance.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006, Gabor Gombas wrote:

> Why should Openswan touch /dev/hw_random directly?

Because using /dev/random whlie /dev/hw_random is available does not always
work (eg with padlock)

> $ apt-cache show rng-tools
>  [...]
>  The rngd daemon acts as a bridge between a Hardware TRNG (true random number
>  generator) such as the ones in some Intel/AMD/VIA chipsets, and the kernel's
>  PRNG (pseudo-random number generator).
>  .
>  It tests the data received from the TRNG using the FIPS 140-2 (2002-10-10)
>  tests to verify that it is indeed random, and feeds the random data to the
>        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  kernel entropy pool.
>  [...]
>
> There is a good reason why /dev/hw_random is different from /dev/random...

Why is this happening in userland? Will rng-tools run on every bare Linux
system now? Including embedded systems? How about xen guests who don't have
direct access to the host's hardware (or software) random?

Why is this entropy management not part of the kernel? So for Openswan to
work correctly, it would need to depend on another daemon that may or may
not be available and/or running?

I still believe /dev/random should just give the best random possible for
the machine. Wether that is software random, or a piece of hardware, should
not matter. That's the kernel's internal state and functioning.

But thanks for the software pointer.

Paul
