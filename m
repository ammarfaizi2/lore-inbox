Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267656AbTBLVyp>; Wed, 12 Feb 2003 16:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267701AbTBLVyp>; Wed, 12 Feb 2003 16:54:45 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:63096 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S267656AbTBLVyp>; Wed, 12 Feb 2003 16:54:45 -0500
Date: Wed, 12 Feb 2003 14:04:27 -0800
Message-Id: <200302122204.h1CM4RZ24628@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: another subtle signals issue
In-Reply-To: Linus Torvalds's message of  Wednesday, 12 February 2003 13:42:58 -0800 <Pine.LNX.4.44.0302121341270.1096-100000@penguin.transmeta.com>
X-Fcc: ~/Mail/linus
X-Zippy-Says: Hold the MAYO & pass the COSMIC AWARENESS...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm.. We could move the blocking test down, and only consider that for the 
> "SIG_DFL" case. 

That is the same resultant behavior as my last patch, though your patch
changed only as you've just described would leave the signal in the queue
though not wake anyone.  That differs in practice only if someone calls
recalc_sigpending_tsk on some blocked threads for some reason.

> The function I did matches what the old signal code did, but the more 
> signals we can truly ignore, the better. I dunno.

Once modified to work in the MT case the same as in the no-thread-groups case,
either way is fine by the spec and by me.  Your call.
