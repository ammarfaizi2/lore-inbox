Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265005AbUFAMJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265005AbUFAMJy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 08:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265008AbUFAMJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 08:09:54 -0400
Received: from kendy.up.ac.za ([137.215.101.101]:27713 "EHLO kendy.up.ac.za")
	by vger.kernel.org with ESMTP id S265005AbUFAMJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 08:09:33 -0400
Message-ID: <40BC71F3.7090408@cs.up.ac.za>
Date: Tue, 01 Jun 2004 14:09:23 +0200
From: Jaco Kroon <jkroon@cs.up.ac.za>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040526
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kernel OOPS (what looks like memory or interrupt handling issues
 to me)
Content-Type: multipart/mixed;
 boundary="------------010600030606030300080906"
X-Scan-Signature: b13a5926f201cde2141207e7a4c86910
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010600030606030300080906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

This is what I could get.

==========================
Process cc1plus (pid: 29992, threadinfo=c173a000 task=c1d74a10

Stack:      0000bba8 c00bb9c0 c124742c c03083fc 00000000 c0308380 
c030849c c173bbc4
               c013725b c0308380 00000000 00000000 00000083 c0308380 
c0308380 c030848c
               c173bbf0 c0137623 c0308380 00000000 00ff00ff c030849c 
00000000 00000046

Call Trace:
  [<c013725b>] rmqueue_bulk+0xdb/0x140
  [<c0137624>] buffered_rmqueue+0x253/0x270
  [<c01376ec>] __alloc_pages+0xac/0x320
  [<c0137982>] __get_free_pages+0x22/0x50
  [<c013c694>] cache_grow+0x114/0x450
  [<c013cd51>] cache_alloc_refill+0x381/0x4d0
  [<c013d54b>] kmem_cache_alloc+0x19b/0x1c0
  [<c0253fdc>] alloc_skb+0x1c/0xe0
  [<c022dbe1>] tulip_refill_rx+0x91/0x100
  [<c0105d33>] handle_IRQ_event+0x33/0x60
  [<c0106239>] do_IRQ+0x119/0x2f0
  [<c0104688>] common_interrupt+0x18/0x20
  [<c01159b3>] panic+0xc3/e0
  [<c0104d94>] die+0x154/0x1e0
  [<c010f320>] do_page_fault+0x260/0x574
  [<c0241d82>] ide_build_sglist+0x32/0xb0
  [<c011e5f7>] __mod_timer+0x247/0x670
  [<c0110526>] recalc_task_prio+0xab/0x200
  [<c0241d82>] ide_build_sglist+0x32/0xb0
  [<c010f0c0>] do_page_fault+0x0/0x574
  [<c01046cd>] error_code+0x2d/0x40
  [<c0132c35>] unlock_page+0x25/0x50
  [<c0151186>] end_swap_bio_read+0x36/0x50
  [<c015ded5>] bio_endio+0x45/0x70
  [<c021d6a7>] __end_that_request_first+0x1d7/0x230
  [<c0238be8>] ide_end_request+0xb8/0x220
  [<c0241d2d>] ide_dma_intr+0x6d/0x90
  [<c023a935>] ide_intr+0x245/0x4c0
  [<c0241cc0>] ide_dma_intr+0x0/0x90
  [<c0105d33>] handle_IRQ_event+0x33/0x60
  [<c0106239>] do_IRQ+0x119/0x2f0
  [<c0104688>] common_interrupt+0x18/0x20

Code: 89 02 89 50 04 c7 01 00 01 10 00 c7 41 04 00 02 20 00 8b 55

 <0>Kernel Panic:  Fatal exception in interrupt
In interrupt handler - not synching
==========================

Getting this in your logs looks rather - hmm - amusing, to say the least:

Jun  1 02:27:01 slowcoach CRON[29951]: (root) CMD (test -x 
/usr/sbin/run-crons && /usr/sbin/run-crons )
Jun  1 02:28:01 slowcoach CRON[29967]: (root) CMD (test -x 
/usr/sbin/run-crons && /usr/sbin/run-crons )
Jun  1 02:29:01 slowcoach CRON[29978]: (root) CMD (test -x 
/usr/sbin/run-crons && /usr/sbin/run-crons )
Jun  1 02:30:00 slowcoach CRON[29995]: (root) CMD (test -x 
/usr/sbin/run-crons && /usr/sbin/run-crons )
Jun  1 08:00:52 slowcoach syslog-ng[5253]: syslog-ng version 1.6.0rc3 
starting

Anyway, I also attach my .config file.

# uname -a
Linux slowcoach 2.6.6 #2 Sat May 22 16:17:30 SAST 2004 i586 Pentium 75 - 
200 GenuineIntel GNU/Linux
# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 2
model name      : Pentium 75 - 200
stepping        : 4
cpu MHz         : 90.088
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr mce cx8
bogomips        : 174.59
# cat /proc/interrupts
           CPU0      
  0:   21316411          XT-PIC  timer
  1:        984          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  4:         50          XT-PIC  serial
  8:          2          XT-PIC  rtc
 11:      63961          XT-PIC  eth0
 14:      17038          XT-PIC  ide0
 15:      17317          XT-PIC  ide1
NMI:          0
ERR:          0

I also have vm.min_free_kbytes = 1024 in /etc/sysctl.conf, which is 
already 4 times the default value for my 64MB ram.

This info was gathered on a clean boot - obviously.

Jaco

--------------010600030606030300080906
Content-Type: application/gzip;
 name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.gz"

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
A/7/P1M3LS26TgAA
--------------010600030606030300080906--
