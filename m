Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264820AbTB0Mj7>; Thu, 27 Feb 2003 07:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264867AbTB0Mj7>; Thu, 27 Feb 2003 07:39:59 -0500
Received: from isaac.asimov.net ([208.185.231.103]:56970 "HELO
	isaac.asimov.net") by vger.kernel.org with SMTP id <S264820AbTB0Mj7>;
	Thu, 27 Feb 2003 07:39:59 -0500
Date: Thu, 27 Feb 2003 04:50:17 -0800
From: Patrick Michael Kane <modus-linux-kernel@pr.es.to>
To: linux-kernel@vger.kernel.org
Subject: preventing route cache overflow
Message-ID: <20030227045017.A11619@pr.es.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We recently had a server come under attack.  Some script monkeys
started generating a bunch of pings and SYNs from a huge variety of
spoofed addresses (mostly in 43.0.0.0/8 and 44.0.0.0/8, for those that
are interested).

There were so many forged packets that the destination cache began to
overflow hundreds or thousands of times per second ("kernel: dst cache
overflow").  This had a huge negative impact on server performance.

Adjusting net/ipv4/route/(max_size|gc_interval) or flushing the route
cache manually on a regular basis seemed to have little or no
measurable impact on the problem.  While IDS and manual filtering at
the firewall eventually resolved the problem, how do we protect
ourselves against this sort of attack in the future?  Can the route
cache be disabled?  The overflow path made less catastrophic?

TIA,
-- 
Patrick Michael Kane
<modus-linux-kernel@pr.es.to>
