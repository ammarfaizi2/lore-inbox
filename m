Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130688AbQLCHwV>; Sun, 3 Dec 2000 02:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130871AbQLCHwM>; Sun, 3 Dec 2000 02:52:12 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:55824 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130835AbQLCHvx>; Sun, 3 Dec 2000 02:51:53 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: /dev/random probs in 2.4test(12-pre3)
Date: 2 Dec 2000 23:19:39 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <90cs6b$6uv$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.3.96.1001202115753.27887T-100000@mandrakesoft.mandrakesoft.com> <Pine.LNX.4.21.0012022233440.11907-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.21.0012022233440.11907-100000@server.serve.me.nl>
By author:    Igmar Palsenberg <maillist@chello.nl>
In newsgroup: linux.dev.kernel
> 
> Hmm.. Some came to mind :
> 
> Making /dev/random block if the amount requirements aren't met makes sense
> to me. If I request x bytes of random stuff, and get less, I probably
> reread /dev/random. If it's entropy pool is exhausted it makes sense to be
> to block.
> 

Yes, it does, but it doesn't make any sense to block if there are data
to be read.  If you need a larger read then you should advance your
pointer and try again with the residual size, or use fread() which
does this for you.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
