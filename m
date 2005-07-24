Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbVGXBHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbVGXBHx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 21:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbVGXBHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 21:07:53 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:49378 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S262283AbVGXBHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 21:07:31 -0400
Date: Sun, 24 Jul 2005 03:07:30 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Paul Jackson <pj@sgi.com>, rostedt@goodmis.org,
       relayfs-devel@lists.sourceforge.net, richardj_moore@uk.ibm.com,
       varap@us.ibm.com, karim@opersys.com, linux-kernel@vger.kernel.org,
       zanussi@us.ibm.com
Subject: diskstat 0.1: simple tool to study io patterns via relayfs
Message-ID: <20050724010730.GA22104@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Paul Jackson <pj@sgi.com>, rostedt@goodmis.org,
	relayfs-devel@lists.sourceforge.net, richardj_moore@uk.ibm.com,
	varap@us.ibm.com, karim@opersys.com, linux-kernel@vger.kernel.org,
	zanussi@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is with distinct lack of pride that I release version 0.1 of diskstat
'Geeks in Black Thorn', a tool that allows you to generate the kinds of
graphs as presented in my OLS talk 'On faster application startup times:
Cache stuffing, seek profiling, adaptive preloading'. The lack of pride is
because this release is more a promise of what is to come than how things
should be.

The presentation, paper, and software can be found on
http://ds9a.nl/diskstat and
http://ds9a.nl/diskstat/diskstat-0.1.tar.gz

>From the README:
The quality of this code is abysmal, for which I squarely blame the fun
people at OLS who've been keeping me from my code!
(...)
The next version will be based on k/jprobes, and will make better use of
relayfs features. This also means you won't have to patch your kernel
anymore, as long as you compiled with kprobes support.

Sample command lines:
   # mkdir /relay
   # mount -t relayfs none /relay
   # ./dumpdiskstat /relay/diskstat0  > dump

   This will output something like:
   I think we skipped at 90867, ret=0
   I think we hit end at 143016, ret=-1
   I think we hit the break again 90867, ret=0

 Process the stats.
   $ ./dswalk < dump

   It will print out huge latencies encountered:

>  Large latency 163.352 on line 14146
   Total read started: 33888768, total ended: 33888768
   Total write started: 1372160, total ended: 1372160
   Waiting time: 10.695 seconds

 Make pretty plots
   gnuplot
   plot 'startplaces.dat', 'headplaces.dat'
   plot 'inflight.dat'

Continue reading on http://ds9a.nl/diskstat/README

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
