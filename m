Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288990AbSAZC1Q>; Fri, 25 Jan 2002 21:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289000AbSAZC1H>; Fri, 25 Jan 2002 21:27:07 -0500
Received: from ns.suse.de ([213.95.15.193]:58884 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288998AbSAZC04>;
	Fri, 25 Jan 2002 21:26:56 -0500
Date: Sat, 26 Jan 2002 03:26:55 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall latency improvement #1
Message-ID: <20020126032655.A13340@wotan.suse.de>
In-Reply-To: <20020126030341.A9651@wotan.suse.de> <Pine.LNX.4.33.0201251810270.16989-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201251810270.16989-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 06:14:25PM -0800, Linus Torvalds wrote:
> 
> On Sat, 26 Jan 2002, Andi Kleen wrote:
> > On Fri, Jan 25, 2002 at 05:53:57PM -0800, Linus Torvalds wrote:
> > >
> > > On 26 Jan 2002, Andi Kleen wrote:
> > > >
> > > > It doesn't explain the Athlon speedups. On athlon cli is ~4 cycles.
> > >
> > > .. and it probably serializes the instruction stream.
> >
> > I have word from AMD engineering that it doesn't stall the pipeline
> > or serializes.
> 
> Note that it may not be the "cli" itself - the "iret" may be slower if it
> has to enable interrupts that were disabled before. Ie the iret microcode
> may have the equivalent of

[...]

Yes that could explain it. I ignored it on x86-64 because it always uses
SYSCALL/SYSRET (at least for 64bit)  @)

The real fix for that would be support of SYSENTER/SYSCALL on 32bit too
(more likely SYSENTER because it's supported by Athlons and SYSCALL is too 
broken on K6 to be usable) 

An int $0x80 does a awful lot of locked cycles for example and IRET is 
also not exactly a speed daemon and very complex.

SYSENTER/SYSEXIT would be likely a much bigger win than nanooptimizations of 
a few cycles around this.
-Andi
