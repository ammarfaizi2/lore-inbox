Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284619AbRLZRok>; Wed, 26 Dec 2001 12:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284644AbRLZRob>; Wed, 26 Dec 2001 12:44:31 -0500
Received: from mail11.speakeasy.net ([216.254.0.211]:21214 "EHLO
	mail11.speakeasy.net") by vger.kernel.org with ESMTP
	id <S284619AbRLZRoQ>; Wed, 26 Dec 2001 12:44:16 -0500
Subject: some 2.4.17 vs. 2.4.17-rmap8 analysis
From: safemode <safemode@speakeasy.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 26 Dec 2001 12:44:14 -0500
Message-Id: <1009388655.408.0.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd just like to say first off that this was a test based on real world
use, meaning i was doing something i do within the scope of a normal day
using the computer.  
	
	Machine Specs (the usefull ones)
	memory : 754MB (now MiB it seems) usable
	cpu    : 850Mhz K7-2 Athlon 
	hdd    : 92GiB ext3 FS on 100GB (weird hdd GB) WD 7200rpm UDMA4
	ext3   : mounted ordered data mode. sync 5 sec.
	kernels: one is 2.4.17 with the preempt patch. The other is exactly the
same only with the rmap8 patch added.  

	Test preconditions.
	Ram filled up with disk cache from running updatedb and then viewing
multiple large avi files.  All normal programs i have up everyday were
running. This includes the following X apps:
	6 Eterms
	3 xterms
	1 gaim (no message windows open)
	1 mozilla
	1 Evolution
	1 Xawtv
	1 Freeamp (with playlist window open)
	2 gprocmeter (1 remote)
	sawfish (with 5 virt. desktops)
I then make sure swap is empty.
	
	actual test.
	I Begin compiling kernel 2.4.17-preempt tree by make clean and then
immediately following it with a make bzImage. Then i jump between
virtual desktops, allowing each to be completely drawn before jumping to
the next. Then I hit reload on slashdot on mozilla (no pics loaded) and
then goto freshmeat.  Then i goto Evolution and view an email and then
back a few virtual desktops and start playing an mp3.  Then i jump a
desktop and message myself in gaim.  I also rotate windows from the
foreground to the background a few times.  I repeat the whole process
again until the compile finishes. The exact tree is used for both tests,
and all the apps are done the same way.  Basically it's an interactive
test that gives no direct data on interactivity unless you see the
"waiting processes" as a measure of that. 


	and now the data
	horizontal is the same in each test, 0-299 seconds (5 minutes)
	vertical is explained in keys or just the filename.
	http://safemode.homeip.net/2.4.17-rmap8.vmstat
	http://safemode.homeip.net/2.4.17.vmstat
	some graphs based on data.
	http://safemode.homeip.net/2.4.17_bi.png (block writing)
	http://safemode.homeip.net/2.4.17_bo.png (block reading)
	http://safemode.homeip.net/2.4.17_cpu_usage.png (system/user)
	http://safemode.homeip.net/2.4.17_mem_usage.png  
	http://safemode.homeip.net/2.4.17_processes.png (waiting proc)
	
	graphs were created using quickplot. rmap8 ended about 7 seconds before
the plain kernel, hence the drop to 0 in each graph. 

	initial reactions.  
	Many of the graphs are very close to eachother.  The two most notably
different are the memory usage graph and bi (block writing) graph.  The
memory graph seems to show a tendency to cache and free memory at the
expense of buffer memory in rmap8 when compared to plain 2.4.17.  In the
bi graph, there seems to be a steady increase in writing in the plain
kernel when compared to the rmap8 kernel, perhaps the reason why there
is more cache memory being used in rmap8 than the plain one.  Finally
the last graph I can see as showing something a bit different is the
processes graph which shows how many processes were waiting to be
executed. This graph seems to show that rmap8 is a bit unfriendly to
sharing runtime than the plain kernel is. Rather, it seems to be a bit
more chaotic in how it allows proccess time. Giving a greater deviation
from the steady 1-2 range than the plain kernel.  

	if there's a way to get better data on what the effects of the rmap
patch are, i'd like to know.  Perhaps loading the system to above normal
use is what's needed.  As for normal use, i dont think anyone could
notice a difference. 

perhaps if vmstat would give some of the extra data found in
/proc/meminfo as well.  Keeping everything one console screen wide isn't
that important with me.  

Stability wise with rmap8, gaim closed by itself over night. No error
messages anywhere as far as I can tell and restarting it is fine.  I do
notice that it's reluctant to use swap to a much greater degree than the
plain kernel was.   

