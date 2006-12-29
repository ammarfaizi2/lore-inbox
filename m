Return-Path: <linux-kernel-owner+w=401wt.eu-S1755024AbWL2P5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024AbWL2P5T (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 10:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755048AbWL2P5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 10:57:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:47960 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755040AbWL2P5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 10:57:18 -0500
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 29 Dec 2006 16:57:16 +0100
From: spam@alpenjodel.de
Message-ID: <20061229155716.20160@gmx.net>
MIME-Version: 1.0
Subject: once again SCHED_IDLE
To: linux-kernel@vger.kernel.org
X-Authenticated: #7969460
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I know there have been some discussions regarding an IDLE scheduler
priority, but by now this is about 4 years ago without any major
results besides the new SCHED_BATCH priority, which works quite
differently from the original idle priority. (Or did I miss something?)
So I wanted to restart this discussion and emphasize that such a feature
is worthwhile, because - just for example - there are so many projects
out there, where you can donate your cpu time to something good. We
certainly do not want Linux to become known as the OS, whose users
don't dare to support "cure for cancer/aids" project, because such
clients won't release the cpu when its owner needs it himself, would
you? ;-) Just overdoing, but I think you see my point. As I recently
read, FreeBSD also has it. So why not Linux?
The only point I got from the early discussions are your concerns about
"priority inversion". Probably there is no simple solution to it. But
let's have closer look at the problem: If I got that right, there is an
unimportant Process A which has a lock on something (call it R) that
important Process B needs from time to time. We assume, that A sometimes
releases its lock on R, so that B can run. But now evil Process C comes
into play. C maliciously blocks a resource (the CPU) that A would need,
before A can release its lock. Now A and B are blocked, but this can
happen with any other resource (not only CPU) as well! Or did I miss
something? Even if A is scheduled regularly (nice +19), a malicious
process C could request so much CPU, that A needs more than 20 times the
time until it can release R. Isn't that similarly bad?
So would SCHED_IDLE really be that bad? No, I don't think so. C could
block R right away, you wouldn't even need A for this.
Additionally, idle priority is not the root cause of the priority
inversion problem. B could get the cpu, but it does not want it, because
of A, because of C.
Trading off the benefits and risks of an IDLE priority I would rather
vote for it. And when security matters: You always have the choice of
not running any process as an idle process. You simply don't have to.
Don't run processes (as idle) that could lock vital resources or live
with the consequences. I think "priority inversion" is not a problem of
a normal user's every day life, but not being able to spend cpu time on
something "nice to have", because it would always eat up its share of
cpu even if the system is under full load, is quite a bit annoying.

Please let me know about your opinions on this topic or if I missed
something.

Looking forward to further discussion,
Christian



-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
