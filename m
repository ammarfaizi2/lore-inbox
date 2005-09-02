Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbVIBSoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbVIBSoF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 14:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbVIBSoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 14:44:05 -0400
Received: from mx.inch.com ([216.223.198.27]:33551 "EHLO util.inch.com")
	by vger.kernel.org with ESMTP id S1750865AbVIBSoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 14:44:04 -0400
Date: Fri, 2 Sep 2005 14:44:16 -0400
From: John McGowan <jmcgowan@inch.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.13 breaks libpcap (and tcpdump).
Message-ID: <20050902184416.GA6468@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.6.13. Breaks libpcap.

Fedora Core 2, gcc 3.3.3, Pentium III (933MHz)

I had written about my dismay that traceproto and tcptraceroute
no longer worked and suspected that libnet was broken.

It seems that it is libpcap that is broken by kernel 2.6.13 and
tcpdump itself no longer works.
Well, it works ... but not correctly.

 Capture data, then look for ICMP messages
 (e.g. Time Exceeded errors as in a traceroute)
 by filtering the file.
 
  tcpdump -w 1.cap
  tcpdump -f "ip proto \icmp" -r 1.cap

That works.


 Filter incoming data, looking for ICMP messages:
 
  tcpdump -f "ip proto \icmp"
 
Well, that catches nothing.


I tried recompiling (source RPM, Fedora Core 2) tcpdump
(libpcap, tcpdump, etc.) and reinstalling. That did not
fix the problem with tcpdump.

It also broke a tethereal script I was using (which I changed
to capture all packets, which works as indicated above, and
then used a '-R', read, filter to display the one's I want).

