Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289686AbSAWFf3>; Wed, 23 Jan 2002 00:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289692AbSAWFfT>; Wed, 23 Jan 2002 00:35:19 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:37132 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S289686AbSAWFfI>;
	Wed, 23 Jan 2002 00:35:08 -0500
Date: Wed, 23 Jan 2002 16:31:18 +1100
From: Anton Blanchard <anton@samba.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] One-liner typo 2.5.3-pre3 in ppc/kernel/idle.c
Message-ID: <20020123053118.GB14366@krispykreme>
In-Reply-To: <E16TFDk-0007wc-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16TFDk-0007wc-00@wagner.rustcorp.com.au>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Looks like need_resched conversion error.

Actually there is a (badly commented) optimisation here. (OK so it isn't
commented at all :)

The code used to say: 

        int oldval = xchg(&current->need_resched, -1);

	if (!oldval) {
		while(current->need_resched == -1)
			; /* Do Nothing */
	}

We atomically grab the current value of need_resched and replace it with
-1. The -1 tells the scheduler that we are busy looping and it doesnt need
to send an IPI to force a reschedule.

Anton
