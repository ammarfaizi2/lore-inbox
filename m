Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267650AbTBLVNo>; Wed, 12 Feb 2003 16:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267652AbTBLVNo>; Wed, 12 Feb 2003 16:13:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13836 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267650AbTBLVNn>; Wed, 12 Feb 2003 16:13:43 -0500
Date: Wed, 12 Feb 2003 13:19:56 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roland McGrath <roland@redhat.com>
cc: Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: another subtle signals issue
In-Reply-To: <200302122111.h1CLB9D24412@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.44.0302121318250.1096-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Feb 2003, Roland McGrath wrote:
> 
> Your patch as is won't fix the ignored-SIG_DFL-interrupts bug in the MT
> case.  That is, in __group_send_sig_info if P blocks the signal but some
> other thread does not, then the that thread will get woken up and be
> subject to all those problems.

Yeah. There's another issue too, which is the "preferred thread" thing. We 
should probably _prefer_ threads that are interruptible as opposed to 
threads that are in disk wait, the same way we prefer threads that are not 
stopped. It might improve throughput.

		Linus

