Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424170AbWKPPew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424170AbWKPPew (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 10:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424178AbWKPPew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 10:34:52 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:30876 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1424170AbWKPPev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 10:34:51 -0500
Date: Thu, 16 Nov 2006 10:34:44 -0500
To: linux-kernel@vger.kernel.org
Subject: How to go about debuging a system lockup?
Message-ID: <20061116153444.GC8238@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a router with a Geode SC1200 cpu, with 4 AMD 972 ethernet ports
(pcnet32) behind a PLX 6152 PCI-PCI bridge, which quite regularly locks
up completely if we try to do simultanius traffic on all 4 ports (our
test case sends data from port 1 to port 2, and back and from port 3 to
port 4 and back at a rate of 8000 packets per second using 1500byte
packets).  We usually manage to run the test for about 1 minute before
the system hangs.  This happens on every one of the systems we have
tried so far.  If we only run 2 ports, it seems to never die, and with 3
ports we haven't seen any failures yet, although maybe we just haven't
tested long enough.  If we just receive the packets but don't forward
them out again, then we never crash, so it seems to be related to
simultanious transmit on the pcnet32s.

So far I have tried printing a message everytime the pcnet32 driver
enables and disables interrupts to find out if it hangs somewhere with
interrupts disabled, but that didn't seem to indicate anything
meaningful.

So far I have tried this with 2.6.8, 2.6.16.22, and 2.6.18.2 and no
difference so far.  I can't think of what kind of even could cause the
system to just hang with no further console output or a kernel panic or
oops or anything.  Usually most errors produce some kind of message.

Does anyone have any suggestions for where I go from here to find out
what is happening and where to look?  I don't even know if I should
suspect the hardware or the software at this point.  I want to know if
the program counter is still changing, or if the cpu is simply hung or
something, but I have no idea how to get at that.

--
Len Sorensen
