Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273037AbTGaOMw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 10:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273035AbTGaOMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 10:12:52 -0400
Received: from 206-158-102-129.prx.blacksburg.ntc-com.net ([206.158.102.129]:28630
	"EHLO wombat.ghz.cc") by vger.kernel.org with ESMTP id S273037AbTGaOMv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 10:12:51 -0400
Message-ID: <17207.216.12.38.216.1059660771.squirrel@www.ghz.cc>
In-Reply-To: <20030731150722.A5938@skunk.physik.uni-erlangen.de>
References: <20030731150722.A5938@skunk.physik.uni-erlangen.de>
Date: Thu, 31 Jul 2003 10:12:51 -0400 (EDT)
Subject: Re: linux-2.6.0-test2: Never using pm_idle (CPU wasting power)
From: "Charles Lepple" <clepple@ghz.cc>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Vogel said:
> on a Thinkpad 600X I noticed the CPU getting very hot. It turned
> out that pm_idle was never called (which invokes the ACPI pm_idle
> call in this case) and default_idle was used instead.

The amd76x_pm patch[1] also hooks pm_idle, and while I'm not 100% sure
about this (haven't instrumented it all the way), it also appears that
pm_idle is not being called (for up to an hour, in some cases). Sometimes
it takes only a few minutes, and other times, it appears to kick in after
heavy CPU usage (kernel compiles, cpuburn, etc.). After pm_idle is called
once, things seem normal-- after the system quiesces, pm_idle is always
called when nothing is ready to run.

Since the amd76x_pm patch appears to work pretty well under 2.4.x, I get
the feeling that the problem lies in the cpu_idle() function. (But I
realize there could be SMP interactions in this case-- in the amd76x_pm
patch, C2 isn't entered unless both CPUs are idle; hence the need for
further instrumentation.)

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=105665646000758&w=3

-- 
Charles Lepple <clepple@ghz.cc>
http://www.ghz.cc/charles/
