Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSGUT1p>; Sun, 21 Jul 2002 15:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313125AbSGUT1p>; Sun, 21 Jul 2002 15:27:45 -0400
Received: from ns.suse.de ([213.95.15.193]:15890 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S313113AbSGUT1o>;
	Sun, 21 Jul 2002 15:27:44 -0400
To: Nivedita Singhvi <niv@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, rwhron@earthlink.net
Subject: Re: [lmbench] tcp bandwidth on athlon
References: <1027279106.3d3b0902a9209@imap.linux.ibm.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 21 Jul 2002 21:30:51 +0200
In-Reply-To: Nivedita Singhvi's message of "21 Jul 2002 21:21:07 +0200"
Message-ID: <p73lm84ubdg.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nivedita Singhvi <niv@us.ibm.com> writes:

> Hmm, so if K6 and Xeon can scrounge up 80% of pipe
> performance, why is the Athlon an order of magnitude off
> at 8%? How did your Athlon perform in other tests relative
> to these other procs?

The pipe test basically tests copy_from_user()/copy_to_user().
The standard implementation of these macros (essentially rep ; movsl)
doesn't exploit the Athlon very well - it is not good at this
instruction. AFAIK Intel CPUs have an faster microcode
implementation for this. 

You could likely do better on Athlon with a copy*user that uses 
an unrolled loop with explicit movls or even SSE.
[similar to the implementation the x86-64 port uses, but without
the NT instructions]

-Andi
