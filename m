Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262617AbREZI0Q>; Sat, 26 May 2001 04:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262618AbREZI0G>; Sat, 26 May 2001 04:26:06 -0400
Received: from jalon.able.es ([212.97.163.2]:31396 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S262617AbREZIZw>;
	Sat, 26 May 2001 04:25:52 -0400
Date: Sat, 26 May 2001 10:25:44 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: vm in 2.4.5
Message-ID: <20010526102544.A1152@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This is a little experiment to smash 2.4 vm, and there is something I do not
understand.

Experiment: compile a C file with, say, 100k lines of puts("test"), auto
generated. Box is running vanilla 2.4.5, on 256Mb of ram.

State before gcc tst.c (just logged in a Gnome session with a couple rxvt's
open):

werewolf:~> free
             total       used       free     shared    buffers     cached
Mem:        255688      99572     156116          0       6788      42876
-/+ buffers/cache:      49908     205780
Swap:       152576          0     152576

Start gcc tst.c, and used memory begins to grow linearly in time, until:

werewolf:~> free
             total       used       free     shared    buffers     cached
Mem:        255688     213856      41832          0       6788      42876
-/+ buffers/cache:     164192      91496
Swap:       152576          0     152576

Stays some moments this way, and suddenly both memory and swap are full:

werewolf:~> free
             total       used       free     shared    buffers     cached
Mem:        255688     251268       4420          0       3752     179948
-/+ buffers/cache:      67568     188120
Swap:       152576     152576          0

It does not begin to use swap in a growing fashion, it just appears full in
a moment.

When compiler (cc1) ends, and assembler starts, some mem is freed:

werewolf:~> free
             total       used       free     shared    buffers     cached
Mem:        255688     195784      59904          0       1708     178512
-/+ buffers/cache:      15564     240124
Swap:       152576     152576          0

And when all the gcc process ends, my mem ends up like:

werewolf:~> free
             total       used       free     shared    buffers     cached
Mem:        255688     191232      64456          0       1760     174628
-/+ buffers/cache:      14844     240844
Swap:       152576     152576          0

What process do belong the 150Mb of swap ???!!!!
Shouldn't that pages have been freed when gcc ends ?

In short, I begin in one state, gcc something, and I do not return to the
same state (I know it could not be the same, something has been paged out,
and still has not get in core again, but should not totals be roughly the
same ???). It looks like the files gcc has used are still cached and also
swapped out and reserved, or the like...

Perhaps this helps someone.

BTW, I do not understand what the hell for needs gcc 256 Mb to compile 100k
sequential sentences...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.4-ac15 #1 SMP Wed May 23 21:55:23 CEST 2001 i686
