Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265789AbUHALGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265789AbUHALGP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 07:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUHALGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 07:06:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2514 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265789AbUHALGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 07:06:13 -0400
Date: Sun, 1 Aug 2004 07:05:17 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
       mingo@elte.hu
Subject: Re: 2.6.8-rc2-mm1
In-Reply-To: <20040731114714.37359c2d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0408010701460.23711@devserv.devel.redhat.com>
References: <20040728020444.4dca7e23.akpm@osdl.org>
 <Pine.LNX.4.58.0407311230330.4095@montezuma.fsmlabs.com>
 <20040731114714.37359c2d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 31 Jul 2004, Andrew Morton wrote:

> > Ingo i believe you have a patch for this, could you push it to Andrew?
> 
> I suspect Ingo's patch will be livelockable under some circumstances.

the first versions were - i could even reproduce it. Fixed it up by doing
less work in this function. But i like your solution of rotating the list
too. Anyway, the -M5 patch shouldnt be livelockable. (but it might have
the crash problem).

btw., breaking the outer loop here is not enough for latencies, it needs
to happen in the inner loop. (which can take thousands of iterations too.)  
See the checkpoint.c bits of the -M5 patch:

 http://people.redhat.com/mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-mm1-M5

	Ingo
