Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267174AbTBQOKo>; Mon, 17 Feb 2003 09:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267217AbTBQOJj>; Mon, 17 Feb 2003 09:09:39 -0500
Received: from mx2.elte.hu ([157.181.151.9]:51875 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267174AbTBQOG0>;
	Mon, 17 Feb 2003 09:06:26 -0500
Date: Mon, 17 Feb 2003 15:15:45 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Robert Love <rml@tech9.net>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] Don't schedule tasks on offline cpus
In-Reply-To: <Pine.LNX.4.50.0302170244440.18087-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.44.0302171513380.24394-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Feb 2003, Zwane Mwaikambo wrote:

> We don't want to allow a cpu going offline to keep doing scheduler work
> so let it exit early, otherwise we'd keep pulling in tasks every timer
> tick.

i'd rather have all the hotplug CPU code to do this kind of stuff
completely out of line. Start up a max-RT-priority housekeeping task and
just clean the runqueue and deregister the CPU in one atomic pass - look
at how the migration threads do similar stuff. No need to contaminate
various codepaths with 'is this CPU online' checks.

	Ingo

