Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265608AbTAXUlV>; Fri, 24 Jan 2003 15:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265578AbTAXUlV>; Fri, 24 Jan 2003 15:41:21 -0500
Received: from 200-206-134-238.async.com.br ([200.206.134.238]:11187 "EHLO
	anthem.async.com.br") by vger.kernel.org with ESMTP
	id <S265608AbTAXUlS>; Fri, 24 Jan 2003 15:41:18 -0500
Date: Fri, 24 Jan 2003 18:49:51 -0200
From: Christian Reis <kiko@async.com.br>
To: neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org, NFS@lists.sourceforge.net
Subject: NFS client locking hangs for period
Message-ID: <20030124184951.A23608@blackjesus.async.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Neil,

I've been trying to get at this problem for a while now, and had been
concentrating on the client-side of the problem (and consequently
bothering Trond about it) [1,2]. I am now pretty much convinced this is a
server-side problem, and as I've patched 2.4.20 with all the NFS patches
pending (that didn't have to do with the kernel lock breaking) and still
see the issue, I decided to report this bug.

The scenario is: a set of NFS clients with root mounted over nfs from a
single server. Clients run vanilla 2.4.20, server runs 2.4.20 patched
with your server-side patches I mentioned above. The clients run okay
for a period, and then one of them will start to hang for long periods
of time for certain operations (it happens on startup and shutdown, for
instance). Once the client hangs start the server needs to be rebooted
for it to clear up.

It seems to be reproducible by having the client hang or reboot without
shutting down properly. Another tip is that the server gets files left
over in /var/lib/nfs/sm/ for the hanging client(s). 

I've been trying to track this down for a while, but since I'm not very
proficient with debugging at this level, I haven't had much luck. It's
really a problem because I need to reboot and make 20 people stop
working when the problem gets serious. Trond has had a hand trying
to help me, but we still haven't uncovered anything. I wonder if you
have any clue what could be happenning?

The other details are standard: the clients are debian woodys with
nfs-utils 1.0.1 installed, and the server has the same version. The
server runs reiserfs over RAID-1 partitions (using the kernel md
driver). Could it be triggered because of this perhaps unusual
combination?

Some of the messages I point out below have some info about the issue -
including tcpdumps and traces of nlm_debug on the server and client.

Mount options follow for the client filesystems:

anthem:/export/root/    /   nfs defaults,rw,rsize=8192,wsize=8192,nfsvers=2 0 0
anthem:/home    /home   nfs defaults,rw,rsize=8192,wsize=8192,nfsvers=3 0 0

I have checked and, yes, root is mounted using version 2 and the rest as
version 3. Perhaps I should try getting the kernel to mount root using
version 3?

[1] http://groups.google.com/groups?q=trond+christian+nfs&hl=pt&lr=&ie=UTF-8&client=googlet&scoring=d&selm=20030108151424.N2628%40blackjesus.async.com.br.lucky.linux.kernel&rnum=1
[2] http://groups.google.com/groups?hl=pt&lr=&ie=UTF-8&client=googlet&th=3575b3c5f3360eb0&seekm=20030108151424.N2628%40blackjesus.async.com.br.lucky.linux.kernel&frame=off

Thanks for any help you can give.

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
