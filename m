Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269528AbTGVF1o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 01:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269530AbTGVF1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 01:27:44 -0400
Received: from rrcs-sw-24-73-247-26.biz.rr.com ([24.73.247.26]:21384 "HELO
	engine.infodancer.org") by vger.kernel.org with SMTP
	id S269528AbTGVF1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 01:27:42 -0400
Date: Tue, 22 Jul 2003 00:42:45 -0500
From: Matthew Hunter <matthew@infodancer.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21, NFS v3, and 3com 920
Message-ID: <20030722054245.GA768@infodancer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Short version: 
Any known gotchas for 2.4.21 NFS v3 and/or a 3com 920?

Long version:
I'm trying to run the /home directory for a small network from a 
single fileserver via NFS.  The server is a 4-way PPro 200 on 
SCSI RAID5 using linux v2.4.21, and the client is a 2-way Athlon
(on a Tyan 2466, MPX chipset).  The network is a just 5 machines,
mostly idle, Fast Ethernet on a switch.

Everything was working wonderfully until I rebooted the client 
server, and ran into the gnome-over-NFS-has-gconf-problems 
problem.  Researched, and the fix said "Use NFSv3".  So I 
recompiled, and used NFSv3.

Except this didn't work.  At all.  

I could mount the directory as before, but any attempt to read 
from it takes forever and involves a large number of timeouts.  
By "forever" I mean hours just to run mutt and open up a mailbox.
It might eventually succeed.  Maybe.

No load is apparant on either server while this is happening.  
Occasionally, I'll see a the client report that the server timed 
out.  If I'm very patient, I'll eventually see a report that the 
server is "OK".

After much futzing around trying to isolate the problem, it turns
out I can trigger it by compiling with NFSv3 on (from the client 
machine; server always has v3).  NFS without v3 works, except for 
the gnome thing.  And NFS with v3 works if you use TCP, but it's 
slow.

So I'm thinking, maybe there's some kind of packet loss problem?

ifconfig doesn't show any errors or dropped packets.  It does 
show some overruns when running under NFS v3 TCP, but did not 
when running without TCP.

I decide to run some large file transfers via SCP outside of the 
NFS mount to see what those show.  Low and behold, the fancy new 
system can only receive at very low speeds -- a minimum of about 
40 KB/s, max of maybe 200, mostly 60-80 KB/s.  Weird -- but that 
shouldn't make NFS time out horribly by itself.  

Running more tests, it turns out the speed problem is isolated to 
the one machine, and only to *receiving* data.  Sending goes at 
8 M/s to other machines from the client machine.  Sending from 
any machine to the client machine is slowed down, not just from 
the server.

I can drop another ethernet card into the client machine and try 
that, and in fact, that's probably the next thing I'll do when I 
work on it further tomorrow evening.  But for now, does any of 
this sound familiar to anyone?  Is this particular 3com chipset 
known to be broken, or just not supported well?  Any possible 
software cause for the slowdown?

Motherboard information is here:
http://www.tyan.com/products/html/tigermpx.html

-- 
Matthew Hunter (matthew@infodancer.org)
Public Key: http://matthew.infodancer.org/public_key.txt
Homepage: http://matthew.infodancer.org/index.jsp
Politics: http://www.triggerfinger.org/index.jsp
