Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129460AbQKFTsu>; Mon, 6 Nov 2000 14:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129392AbQKFTsj>; Mon, 6 Nov 2000 14:48:39 -0500
Received: from ns.sysgo.de ([213.68.67.98]:38390 "EHLO rob.devdep.sysgo.de")
	by vger.kernel.org with ESMTP id <S129350AbQKFTsh>;
	Mon, 6 Nov 2000 14:48:37 -0500
From: Robert Kaiser <rob@sysgo.de>
Reply-To: rob@sysgo.de
To: linux-kernel@vger.kernel.org
Subject: Re: setup.S: A20 enable sequence (once again) 
Date: Mon, 6 Nov 2000 20:29:00 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <00110620483000.11673@rob>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This doesn't really work.  Neither the fast A20 gate nor the KBC is
> guaranteed to have immediate effect (on most systems they won't.)

In that case, maybe I should do repeated calls to a20_check with a
(not too big) retry count after the port 92 write ?

Problem is, it happens to work this way on all hardware I have access to,
so I can't really reproduce such timing problems. Anyone ?


> What's worse, once you have done an "out" to the KBC you need to
> finish the sequence.  I need to think about this for a bit.

??? I'm not touching the KBC if the port 92 access was successful at
enableing A20. If, however, A20 is still disabled, I'm doing the same KBC
sequence as the original code, so there shouldn't be any incomplete KBC
interactions (unless I mistyped something...).

> (Arguably, what you're doing is running on completely nonstandard
> hardware, which may need a CONFIG_ option.  However, if we can avoid
> it I guess it's better.)

That was exactly my intention :-)


----------------------------------------------------------------
Robert Kaiser                         email: rkaiser@sysgo.de
SYSGO RTS GmbH
Am Pfaffenstein 14                    phone: (49) 6136 9948-762
D-55270 Klein-Winternheim / Germany   fax:   (49) 6136 9948-10
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
