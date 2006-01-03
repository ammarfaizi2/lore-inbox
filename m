Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWACQmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWACQmI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 11:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWACQmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 11:42:08 -0500
Received: from 80-28-34-54.adsl.nuria.telefonica-data.net ([80.28.34.54]:17043
	"EHLO workstation.zul") by vger.kernel.org with ESMTP
	id S1751456AbWACQmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 11:42:07 -0500
Date: Tue, 3 Jan 2006 17:43:09 +0100 (CET)
From: Ian Blanes <ian@gentemsn.com>
X-X-Sender: root@workstation.zul
To: linux-kernel@vger.kernel.org
Subject: high system load on tcp_poll and tcp_sock in 2.6 caused by squid
Message-ID: <Pine.LNX.4.58.0601031723080.2818@workstation.zul>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm getting this report from oprofile from a squid server with about 2000
clients. I'm not sure if this is normal... any idea on where to look?

thanks
ian

Cpu0  : 20.0% us, 43.3% sy,  0.0% ni, 20.1% id, 15.8% wa,  0.9% hi,  0.0%
si

SElinux compiled but dissabled. Tested on smp kernel and on single
processor kernel. P4 2.40GHz, HT dissabled, e1000 network card, using
multiple(4) ip address on the same card.

(other event types gave similar results)
CPU: CPU with timer interrupt, speed 0 MHz (estimated)
Profiling through timer interrupt
samples  %        app name                 symbol name
87849    28.0555  vmlinux                  default_idle
70392    22.4804  vmlinux                  tcp_poll
36378    11.6177  vmlinux                  sock_poll
24749     7.9038  squid                    clientReadRequest
14889     4.7550  vmlinux                  fget
6408      2.0465  vmlinux                  fput
5841      1.8654  squid                    _db_init
3996      1.2762  vmlinux                  remove_wait_queue
3757      1.1998  squid                    httpHeaderEntryCreate
2953      0.9431  squid                    ctx_print
2268      0.7243  squid                    comm_poll
2106      0.6726  e1000                    (no symbols)
2077      0.6633  vmlinux                  add_wait_queue
1648      0.5263  vmlinux                  handle_IRQ_event
1625      0.5190  vmlinux                  do_pollfd
1500      0.4790  libc-2.3.4.so            memcpy
1309      0.4180  squid                    _db_print
1074      0.3430  squid                    mime_get_auth
1039      0.3318  squid                    peerAllowedToUse
[...]
