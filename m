Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278584AbRKFHTH>; Tue, 6 Nov 2001 02:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278566AbRKFHS5>; Tue, 6 Nov 2001 02:18:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38925 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278522AbRKFHSq>; Tue, 6 Nov 2001 02:18:46 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Using %cr2 to reference "current"
Date: 5 Nov 2001 23:18:13 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9s82rl$k51$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.13-ac8 uses %cr2 rather than (%esp & 0xfffe0000) to get "current".
I've been trying to figure out the point of this... writing a control
register is microcode on all the x86 implementations I know (and you
have to re-set it after every pagefault), and reading one probably is
one on most (not Transmeta, but...)

On the other hand, %esp is a GPR and available to the core directly,
and so are usually plain immediates.

Is using %cr2 really faster than the old implementation, or is there
another reason?  It seems that the alignment constraints on the stack
still remains, since the %esp solution still remains in places...

It might also be worth considering a segment-register based
implementation instead.  The reason we're not using %fs and %gs in the
kernel anymore is because of the setup slowness, but perhaps using
them (use %fs since it's much more likely to be NULL and thus faster
to restore) would be faster than using %cr2?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
