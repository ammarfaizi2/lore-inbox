Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267322AbTBPSuX>; Sun, 16 Feb 2003 13:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267329AbTBPSuX>; Sun, 16 Feb 2003 13:50:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22032 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267322AbTBPSuX>; Sun, 16 Feb 2003 13:50:23 -0500
Date: Sun, 16 Feb 2003 10:56:49 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Fw: 2.5.61 oops running SDET
In-Reply-To: <3E4FDC61.8060301@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0302161048050.2619-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Feb 2003, Manfred Spraul wrote:
> 
> Do you want to replace tasklist_lock with task_lock in exit_sighand() 
> and during exec, or do you want to add task_lock to tasklist_lock?

I'd rather replace it, but your point about irq-safeness is a good one. 
Clearly signal sending cannot take the task lock if we want to keep it 
irq-unsafe.

So the signal stuff probably does need to be protected by _both_ the 
tasklist lock and the provate task lock.

> Someone removed the read_lock(tasklist_lock) around 
> send_specific_sig_info() - which lock synchronizes exec and signal delivery?

Looks like none. And I think it was Ingo who removed it. Ingo?

		Linus

