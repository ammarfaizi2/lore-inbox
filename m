Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281932AbRK1XB1>; Wed, 28 Nov 2001 18:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282096AbRK1XBH>; Wed, 28 Nov 2001 18:01:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47881 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281932AbRK1XA5>; Wed, 28 Nov 2001 18:00:57 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Kernel's X86 ffs() doesn't work on constants.
Date: 28 Nov 2001 15:00:38 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9u3qam$75c$1@cesium.transmeta.com>
In-Reply-To: <200111282239.fASMdMY82422@aslan.scsiguy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200111282239.fASMdMY82422@aslan.scsiguy.com>
By author:    "Justin T. Gibbs" <gibbs@scsiguy.com>
In newsgroup: linux.dev.kernel
>
> If you attempt to call ffs(SOME_CONSTAT) in an x86 kernel under
> Linux, you get messages like this:
> 
> {standard input}: Assembler messages:
> {standard input}:14864: Error: suffix or operands invalid for `bsf'
> 
> I'm not enough of a GCC asm syntax guru to understand why the
> compiler/assembler doesn't handle this, but it is hightly anoying.
> 
> "Why not just code in the constant bit offset?", you ask?  If
> the constant the bit offset is based on is ever changed, I must
> recognize that the change occured and change the second constant.
> For constants that are maintained outside of my code, I'd rather
> code the dependency once and let the compiler ensure that the constants
> are in sync.
> 

Try changing the "g" in the definition of ffs() (asm/bitops.h) to
"rm"; the "g" constrains incorrectly allows immediate operands.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
