Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267315AbTBPSI7>; Sun, 16 Feb 2003 13:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267319AbTBPSI7>; Sun, 16 Feb 2003 13:08:59 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26381 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267315AbTBPSI7>; Sun, 16 Feb 2003 13:08:59 -0500
Date: Sun, 16 Feb 2003 10:15:08 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: Fw: 2.5.61 oops running SDET
In-Reply-To: <3E4FCD5A.9090608@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0302161013560.2619-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Feb 2003, Manfred Spraul wrote:
> 
> AFAICS both exec and exit rely on write_lock_irq(tasklist_lock) for 
> synchronization of changes to tsk->sig{,hand}.

Yeah, as I sent out in my last email this does seem to be true right now, 
but it's really not correct. It's disgusting that we use such a 
fundamental global lock to protect something so trivially local to the one 
process, where the local per-process lock really should be more than 
enough.

		Linus

