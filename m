Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274096AbRI0XXx>; Thu, 27 Sep 2001 19:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274097AbRI0XXd>; Thu, 27 Sep 2001 19:23:33 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14346 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274096AbRI0XXW>; Thu, 27 Sep 2001 19:23:22 -0400
Date: Thu, 27 Sep 2001 16:23:38 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Padraig Brady <padraig@antefacto.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: CPU frequency shifting "problems"
In-Reply-To: <3BB319ED.5020406@antefacto.com>
Message-ID: <Pine.LNX.4.33.0109271619250.25667-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Sep 2001, Padraig Brady wrote:
>
> >
> >For example, on a transmeta CPU, the TSC will run at a constant
> >"nominal" speed (the highest the CPU can go), although the real CPU
> >speed will depend on the load of the machine and temperature etc.
>
> As does the P4 from what I understand.

That might explain why the P4 "rdtsc" is so slow.

> So a question..
> What are the software dependencies on this auto/manual frequency shifting?

None. At least not as long as the CPU _does_ do it automatically, and the
TSC appears to run at a constant speed even if the CPU does not.

For example, the Intel "SpeedStep" CPU's are completely broken under
Linux, and real-time will advance at different speeds in DC and AC modes,
because Intel actually changes the frequency of the TSC _and_ they don't
document how to figure out that it changed.

With a CPU that does makes TSC appear constant-frequency, the fact that
the CPU itself can go faster/slower doesn't matter - from a kernel
perspective that's pretty much equivalent to the different speeds you get
from cache miss behaviour etc.

			Linus

