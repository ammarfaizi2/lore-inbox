Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314413AbSDTDVk>; Fri, 19 Apr 2002 23:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314524AbSDTDVj>; Fri, 19 Apr 2002 23:21:39 -0400
Received: from [195.223.140.120] ([195.223.140.120]:15877 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314413AbSDTDVj>; Fri, 19 Apr 2002 23:21:39 -0400
Date: Sat, 20 Apr 2002 05:23:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, jh@suse.cz,
        bgerst@didntduck.org
Subject: Re: SSE related security hole
Message-ID: <20020420052303.F1291@dualathlon.random>
In-Reply-To: <20020419230454.C1291@dualathlon.random> <2459.131.107.184.74.1019252157.squirrel@www.zytor.com> <20020419234206.A15187@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2002 at 11:42:06PM +0200, Andi Kleen wrote:
> On Fri, Apr 19, 2002 at 02:35:57PM -0700, H. Peter Anvin wrote:
> > would initialize the entire FPU, including any state that future
> > processors may add, thus reducing the likelihood of any funnies in the
> > future.
> 
> That's also why I like it. 

Trusting the "boot state" of the cpu would require the BIOS to match the
linux ABI. The FPU must be in a known initialized state at the linux
level, not at the BIOS level, as first for the mxcsr, but also the other
registers should be set to zero by default so gcc can exploit that (I
guess that's what gcc is just doing and that's why Honza noticed it). so
if new future processors will add new stuff, the new stuff will have to
be initialized again in the "fxrestor" default payload in linux (so
requiring a modification to the OS), and having to change the default
rxrestor payload for a new cpu is equivalent to add another xor there
(modulo the runtime check on the cpu features that could be avoided with
two separate exception handlers for each cpu revision but it's fast
enough that it doesn't matter at the moment on x86).

Andrea
