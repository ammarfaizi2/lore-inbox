Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280051AbRKFTKi>; Tue, 6 Nov 2001 14:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280110AbRKFTKb>; Tue, 6 Nov 2001 14:10:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29198 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280051AbRKFTKQ>; Tue, 6 Nov 2001 14:10:16 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Using %cr2 to reference "current"
Date: 6 Nov 2001 11:09:50 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9s9chu$mdu$1@cesium.transmeta.com>
In-Reply-To: <20011106121313.B16245@redhat.com> <Pine.LNX.4.33.0111060918380.2194-100000@penguin.transmeta.com> <20011106134234.A27718@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011106134234.A27718@redhat.com>
By author:    Benjamin LaHaise <bcrl@redhat.com>
In newsgroup: linux.dev.kernel
>
> On Tue, Nov 06, 2001 at 09:49:15AM -0800, Linus Torvalds wrote:
> > That said, how expensive is loading %cr2 anyway? We can do all the same
> > tricks with a 16kB stack and just playing games with using the higher bits
> > as the "offset", ie things like
> 
> Here are some numbers:
> 
> read cr2 best: 11  av: 11.12
> write cr2 cr2 best: 61  av: 64.42
> read cr2 best: 11  av: 11.12
> write cr2 cr2 best: 61  av: 65.01
> read stk best: 10  av: 11.03
> write cr2 stk best: 61  av: 64.95
> read stk best: 10  av: 11.03
> write cr2 stk best: 61  av: 65.23
> 
> Which come from insmod of the below two modules.  I didn't test writing to 
> the stack register, but I expect it's similarly expensive as it affects the 
> call return stack and other behind the scenes dependancies.  Suffice it to 
> say that reading %cr2 is essentially free on my box (athlon mp).  Maybe 
> we should use it as a pointer into a per-cpu area to avoid writing it?
> 

You still have to write it every time you take a page fault.  You're
adding 60-odd cycles to the page fault path at least.

Not to mention any system which does microcoded reads of %cr2, which
apparently the Athlon XP doesn't.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
