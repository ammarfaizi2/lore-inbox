Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318384AbSGYJ6E>; Thu, 25 Jul 2002 05:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318391AbSGYJ6E>; Thu, 25 Jul 2002 05:58:04 -0400
Received: from mx1.elte.hu ([157.181.1.137]:2775 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318384AbSGYJ6D>;
	Thu, 25 Jul 2002 05:58:03 -0400
Date: Thu, 25 Jul 2002 11:59:46 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: martin@dalecki.de
Cc: "David S. Miller" <davem@redhat.com>, <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.28
In-Reply-To: <3D3FC9F0.5040809@evision.ag>
Message-ID: <Pine.LNX.4.44.0207251155360.25599-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 25 Jul 2002, Marcin Dalecki wrote:

> Carefull.... The ATA host controller patches showed that mindless fixing
> would just hide the fact that, [...]

the main.c change was, frankly, trivially broken. The function that called
the unregister function already held the ide_lock. We have a debugging
mechanism to detect such bugs as they happen (the NMI watchdog), so it's
relatively straightforward (of course not easy) to extend the use of
ide_lock.

the more subtle cases are when the code somehow relies on cli()  
excluding multiple IRQ contexts and BH contexts for example.

	Ingo


