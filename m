Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbTGDPTl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 11:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266049AbTGDPTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 11:19:40 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:39653 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S266048AbTGDPTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 11:19:39 -0400
Date: Fri, 4 Jul 2003 17:34:07 +0200
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org
Subject: [2.5.74] bad: scheduling while atomic!
Message-ID: <20030704153407.GA3540@k3.hellgate.ch>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.5.74 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't had the time to investigate this, so I don't have much
information to share beyond the trace below. I think I have seen this at
least with 2.5.73, too. The system looks okay, then, usually hours later
(if at all, it's a rare event), something triggers a flood of those call
traces (many of them per second).

The syslog seems to suggest it might be related to IDE DMA:

Jul  4 17:17:28 [kernel] hda: dma_timer_expiry: dma status == 0x61
Jul  4 17:17:44 [kernel] hda: timeout waiting for DMA
Jul  4 17:17:44 [kernel]  [<c0107000>] default_idle+0x0/0x40
Jul  4 17:17:44 [kernel] bad: scheduling while atomic!

Compiler is gcc 3.2.3.

bad: scheduling while atomic!
Call Trace:
 [<c0107000>] default_idle+0x0/0x40
 [<c011f110>] schedule+0x500/0x510
 [<c0107063>] poll_idle+0x23/0x40
 [<c0118073>] apm_cpu_idle+0xa3/0x140
 [<c0117fd0>] apm_cpu_idle+0x0/0x140
 [<c0107000>] default_idle+0x0/0x40
 [<c01070b8>] cpu_idle+0x38/0x40
 [<c0105000>] rest_init+0x0/0x30
 [<c037c738>] start_kernel+0x138/0x140
 [<c037c4c0>] unknown_bootoption+0x0/0x100

