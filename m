Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQKFURY>; Mon, 6 Nov 2000 15:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129272AbQKFURP>; Mon, 6 Nov 2000 15:17:15 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:19205 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129260AbQKFUQ5>; Mon, 6 Nov 2000 15:16:57 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: setup.S: A20 enable sequence (once again)
Date: 6 Nov 2000 12:16:29 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8u73it$8p2$1@cesium.transmeta.com>
In-Reply-To: <00110620483000.11673@rob>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <00110620483000.11673@rob>
By author:    Robert Kaiser <rob@sysgo.de>
In newsgroup: linux.dev.kernel
>
> > This doesn't really work.  Neither the fast A20 gate nor the KBC is
> > guaranteed to have immediate effect (on most systems they won't.)
> 
> In that case, maybe I should do repeated calls to a20_check with a
> (not too big) retry count after the port 92 write ?
> 
> Problem is, it happens to work this way on all hardware I have access to,
> so I can't really reproduce such timing problems. Anyone ?
> 
> > What's worse, once you have done an "out" to the KBC you need to
> > finish the sequence.  I need to think about this for a bit.
> 
> ??? I'm not touching the KBC if the port 92 access was successful at
> enableing A20. If, however, A20 is still disabled, I'm doing the same KBC
> sequence as the original code, so there shouldn't be any incomplete KBC
> interactions (unless I mistyped something...).
> 

The problem is that your test for A20 is faulty.  Severely so.
Anyway, I just sent you a patch which will terminate the first empty_8042
loop (while it's still safe) if it finds A20 now enabled.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
