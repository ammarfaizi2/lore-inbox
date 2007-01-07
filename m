Return-Path: <linux-kernel-owner+w=401wt.eu-S965023AbXAGT4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbXAGT4S (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 14:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbXAGT4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 14:56:18 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:34689 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965023AbXAGT4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 14:56:17 -0500
Date: Sun, 7 Jan 2007 20:55:31 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netfilter Mailing List <netfilter@lists.netfilter.org>,
       nmap-dev@insecure.org
Subject: [announce] chaostables 0.4
Message-ID: <Pine.LNX.4.61.0701072014550.4365@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Not sure if netfilter/nmap-dev bounce when you are not subscribed, 
remove if in doubt.]


Hello lists,


chaostables 0.4 has been released. This is a package containing some 
netfilter modules to work against nmap and port scans. 'portscan' can 
match on stealth, syn, connect scans, also finds FIN-connect scans and 
simple banner grabbing. 'DELUDE' works like TARPIT, making it look like 
the port is open, but actually does not hold the connection like TARPIT, 
hence should not fill up conntrack. 'CHAOS' will deliver what it says: 
slows down nmap scans[1] and provides back bogus non-deterministic 
replies -- the more even with DELUDE/TARPIT.

For Linux 2.6.18, .19, .20, iptables 1.3.6, 1.3.7. CHAOS 
currently requires TARPIT during build and runtime.

'portscan' and 'CHAOS' can also be synthesized by rule logic "only"[2], 
giving way to possibly implement it on BSD ipf* too. Details in 
doc/fw.html.

Suggestions for improvement are welcome.
Please discuss the usefulness and let me
hear [LKML] any objections for inclusion in Linux mainline too.

	http://freshmeat.net/releases/244538/ - this release
	http://freshmeat.net/p/chaostables/   - generally


Thanks,
Jan


[1] nmap 3.81 timings have been done back in 2005, but things have 
changed a little since 4.x. Redoing the timing benchmarks is already on 
TODO.

[2] Requires: connmark && CONNMARK &&
              (conntrack || state) &&
              (random || nth || statistic || hashlimit)
    or equivalent. Depends on how you implement it.
