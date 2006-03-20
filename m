Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWCTMY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWCTMY4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 07:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWCTMY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 07:24:56 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:32658 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S932260AbWCTMY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 07:24:56 -0500
Date: Mon, 20 Mar 2006 13:24:49 +0100
From: bert hubert <bert.hubert@netherlabs.nl>
To: linux-kernel@vger.kernel.org
Cc: george@mvista.com
Subject: gettimeofday order of magnitude slower with pmtimer, which is default
Message-ID: <20060320122449.GA29718@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	linux-kernel@vger.kernel.org, george@mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

For my open source nameserver (http://www.powerdns.com) I need to do quite a
number of gettimeofday calls. I've pared it down to almost the bare minimum
of 1 gettimeofday per packet sent and received. With these calls, I can make
stats like http://ds9a.nl/tmp/rrd/ which my users need so they can verify
the proper performance of the nameserver.

Yesterday, together with Zwane, I discovered each gettimeofday call costs me
4 usec on some boxes and almost nothing on others. We did a fruitless chase
for vsyscall/sysenter happening but the problem turned out to be
CONFIG_X86_PM_TIMER.

This problem has been discussed before
http://www.ussg.iu.edu/hypermail/linux/kernel/0411.1/2135.html

Not only is the pm timer slow by design, it also needs to be read multiple
times to work around a bug in certain hardware.

What is new is that this option is now dependent on CONFIG_EMBEDDED. Unless
you select this option, the PM Timer will always be used.

Would a patch removing the link to EMBEDDED and adding a warning that while
this timer is of high quality, it is slow, be welcome?

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
