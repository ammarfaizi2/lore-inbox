Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263079AbTC2B5r>; Fri, 28 Mar 2003 20:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263082AbTC2B5r>; Fri, 28 Mar 2003 20:57:47 -0500
Received: from CPE-203-51-31-188.nsw.bigpond.net.au ([203.51.31.188]:59899
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S263079AbTC2B5q>; Fri, 28 Mar 2003 20:57:46 -0500
Message-ID: <3E85003A.3DE4DDE7@eyal.emu.id.au>
Date: Sat, 29 Mar 2003 13:08:58 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "list, linux-kernel" <linux-kernel@vger.kernel.org>
Subject: 2.4.20: problem with "ps -olstart"
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a program that needs to check if a process is still running.
It issues a ps and saves the pid and start time. It then uses this
info to compare against a later "ps --pid".

The monitored process is long-running and unlikely to restart at the
same second and with the same pid. I am trying to go better than
just using a pid sentry (I also compare the cmd to be really sure).

I see a different start time returned on different calls. An example
is attached below. This is a show stopper for me. Is this a known
problem? Does it have a solution?

This is vanilla (my build) 2.4.20 on i386.

$ ps
  PID TTY          TIME CMD
  906 pts/0    00:00:01 bash
 3026 pts/0    00:00:00 sh
 8254 pts/0    00:00:00 ps
$ while true ; do ps --pid "3026" -olstart,cmd --no-headers ; done
Thu Mar 27 22:03:11 2003 sh
Thu Mar 27 22:03:11 2003 sh
Thu Mar 27 22:03:11 2003 sh
Thu Mar 27 22:03:11 2003 sh
Thu Mar 27 22:03:12 2003 sh
Thu Mar 27 22:03:12 2003 sh
Thu Mar 27 22:03:12 2003 sh
Thu Mar 27 22:03:12 2003 sh
Thu Mar 27 22:03:12 2003 sh
Thu Mar 27 22:03:12 2003 sh
Thu Mar 27 22:03:12 2003 sh
Thu Mar 27 22:03:12 2003 sh
Thu Mar 27 22:03:12 2003 sh
Thu Mar 27 22:03:12 2003 sh
Thu Mar 27 22:03:11 2003 sh
Thu Mar 27 22:03:11 2003 sh
Thu Mar 27 22:03:11 2003 sh
Thu Mar 27 22:03:11 2003 sh
Thu Mar 27 22:03:11 2003 sh
Thu Mar 27 22:03:12 2003 sh
Thu Mar 27 22:03:12 2003 sh
Thu Mar 27 22:03:12 2003 sh
Thu Mar 27 22:03:12 2003 sh
Thu Mar 27 22:03:12 2003 sh
Thu Mar 27 22:03:12 2003 sh
Thu Mar 27 22:03:12 2003 sh
Thu Mar 27 22:03:12 2003 sh
Thu Mar 27 22:03:12 2003 sh
Thu Mar 27 22:03:12 2003 sh
Thu Mar 27 22:03:11 2003 sh

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
