Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266749AbTBTT31>; Thu, 20 Feb 2003 14:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266805AbTBTT31>; Thu, 20 Feb 2003 14:29:27 -0500
Received: from mx2.elte.hu ([157.181.151.9]:28336 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S266749AbTBTT30>;
	Thu, 20 Feb 2003 14:29:26 -0500
Date: Thu, 20 Feb 2003 20:36:26 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <Pine.LNX.4.44.0302201015150.1589-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302202034270.2013-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hm, i think i can see the SMP race.

the last put_task_struct() can also be done by procfs - and nothing keeps
it from freeing the task in __put_task_struct(), while the task struct is
after its final put_task_struct(), but before the switch_to().

this does not explain the UP crash though.

	Ingo


