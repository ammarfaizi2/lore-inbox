Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbUCPNjS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 08:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbUCPNjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 08:39:18 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:58571 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S261626AbUCPNjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 08:39:12 -0500
Date: Tue, 16 Mar 2004 21:38:51 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Pavel Machek" <pavel@ucw.cz>,
       "Nigel Cunningham" <ncunningham@users.sourceforge.net>,
       "Patrick Mochel" <mochel@digitalimplant.org>
Subject: Re: [Swsusp-devel] Re: The verdict on the future of suspending to disk?
Cc: "Andrew Morton" <akpm@digeo.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Suspend development list" <swsusp-devel@lists.sourceforge.net>
References: <1079408330.3403.5.camel@calvin.wpcb.org.au> <20040316113717.GB2282@elf.ucw.cz> <20040316121524.GI2175@elf.ucw.cz>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr4yiu1ar4evsfm@smtp.pacific.net.th>
In-Reply-To: <20040316121524.GI2175@elf.ucw.cz>
User-Agent: Opera M2/7.50 (Linux, build 615)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without reliability and being able to suspend at any load
(when the batteries/UPS go flat)  software suspend is all
but useless.  What for suspend if it does not resume and
eats work left in RAM?

Common users objectives for a software suspend mechanism are:

1. To not impair system reliability. It must run without crash
       and reboots between kernel upgrades.
       100 cycles in 2 hours is a quickie
       1000 cycles in a day are a short test
       xxxx cycles in a month are a life test

2. To handle any cpu and io load
	10+ concurrent unixbenchs, 4 concurrent dd loops, nfs and ssh
       cross accesses, Load avg 20-40, cs of 100,000, 20MB io
       sustained for days at a cycle a minute... No freezing failures

3. To support the spectrum of user requirements wrt functionality
	for portable, desktop, and embedded apps

4. To handle driver suspend and resume at any time. Apps should not
       have to be terminated.

Swsusp2 meets 1. and 2. and many of 3. Swsusp2 is also modular and can be
expanded to add things like NFS suspend/resume.

1. and 2. require a sophisticated freezing mechanism and kernel level
"intrusion". Most of this "intrusion" is simetrical and easily understood.
This is what UGLY macros are for.

3. Can be argued about: Compression or no compression, reboot functionality
    for multi boot or not, Escape or no Escape (I need it every day) -
    If you ever would dare to suspend you would want an Escape function too! :-)

4. Requires PM fixes and driver level intrusion, can be worked around by
    killing apps and unloading drivers. Eventually this has to be fixed.

Regards
Michael
