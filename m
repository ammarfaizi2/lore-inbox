Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbTELPC2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 11:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTELPC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 11:02:28 -0400
Received: from sophia.inria.fr ([138.96.64.20]:28354 "EHLO sophia.inria.fr")
	by vger.kernel.org with ESMTP id S262193AbTELPCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 11:02:22 -0400
Subject: am-utils or kernel bug ?
From: Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
To: amd-dev@cs.columbia.edu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: INRIA
Message-Id: <1052752493.24411.50.camel@atlas.inria.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 May 2003 17:14:54 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, 

i am running Redhat 9.0 ( kernel 2.4.20 )
and am-utils (am-utils-6.0.9-2)  (because i need the browsing feature
that automount doen't support).

Unfortunatelly, amd sometimes hangs at boot time during its
initialization (/etc/rc.d/init.d/amd ).
I can reproduce this bug with /etc/rc.d/init.d/amd start / stop 
sequences, sometimes the start hangs sometimes it works.
This bug occurs on ALL RedHat 9.0 boxes we have (7 PC with totally
different hardware).

When hanging i can observe the following processes :

root      2444  1911  0 17:14 pts/0    00:00:00 /bin/bash
/etc/rc.d/init.d/amd start
root      2453  2444  0 17:14 pts/0    00:00:00 initlog -q -c
/usr/sbin/amd -F /etc/amd.conf
root      2454  2453  0 17:14 pts/0    00:00:00 /usr/sbin/amd -F
/etc/amd.conf
root      2455  2454  0 17:14 ?        00:00:00 /usr/sbin/amd -F
/etc/amd.conf

with the following traces :

[root@redhat-serv root]# strace -p 2453
wait4(2454, 0xbfffd9cc, WNOHANG, NULL)  = 0
nanosleep({0, 500000}, NULL)            = 0
poll([{fd=3, events=POLLIN|POLLPRI}, {fd=5, events=POLLIN|POLLPRI}], 2,
500) = 0
wait4(2454, 0xbfffd9cc, WNOHANG, NULL)  = 0
nanosleep({0, 500000}, NULL)            = 0
poll([{fd=3, events=POLLIN|POLLPRI}, {fd=5, events=POLLIN|POLLPRI}], 2,
500) = 0
wait4(2454, 0xbfffd9cc, WNOHANG, NULL)  = 0
nanosleep({0, 500000}, NULL)            = 0
poll([{fd=3, events=POLLIN|POLLPRI}, {fd=5, events=POLLIN|POLLPRI}], 2,
500) = 0
wait4(2454, 0xbfffd9cc, WNOHANG, NULL)  = 0
nanosleep({0, 500000}, NULL)            = 0
poll( <unfinished ...>


[root@redhat-serv root]# strace -p 2454
futex(0x4212e1c8, FUTEX_WAIT, -2, NULL <unfinished ...>


[root@redhat-serv root]# strace -p 2455
select(1024, [4 5 6 7], NULL, NULL, {932, 980000} <unfinished ...>


The SAME configuration worked perfectly with RH 8.0, am-utils-6.0.7-9,
kernel 2.4.18

Any suggestions ?

-- 
Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
INRIA

