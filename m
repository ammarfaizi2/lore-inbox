Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264429AbTDOKgP (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 06:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264430AbTDOKgO (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 06:36:14 -0400
Received: from rainbow.transtec.de ([153.94.51.2]:27143 "EHLO
	rainbow.transtec.de") by vger.kernel.org with ESMTP id S264429AbTDOKgM (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 06:36:12 -0400
From: Peter <pk@q-leap.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16027.58207.975001.863568@q-leap.com>
Date: Tue, 15 Apr 2003 12:47:59 +0200
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: pk@q-leap.com, linux-kernel@vger.kernel.org
Subject: Re: oops with e1000, ifenslave (bonding)
In-Reply-To: <200304151220.36148.m.c.p@wolk-project.de>
References: <16027.55946.797266.771034@q-leap.com>
	<200304151220.36148.m.c.p@wolk-project.de>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: pk@q-leap.com
X-Face: "HSWKA_'Lr\(@D}NQgU@jZukje>!f;VO]4Tj%~+[PY$M"=CmMyN.x6&X`p_X|q9.||#uM0mH%/3kBIxN-@(lB?3\_)J+ms63HsTY0{WmL3_K+
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

thanks for your quick response.  Using your patch on the version
5.0.43 driver gives me:

patching file e1000_main.c
Hunk #1 succeeded at 1035 (offset 72 lines).
Hunk #2 succeeded at 1103 (offset 72 lines).

don't know if your patch can be used on this source?

Anyways, after doing "ifenslave -d bond0 eth1 eth2" I get:

wait_on_irq, CPU 0:
irq:  0 [ 0 0 ]
bh:   1 [ 0 1 ]
Stack dumps:
CPU 1:00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
       00000000 00000002 01000000 c1c18740 c1c18740 00000000 c1c18640 f7e9d2a0
       c1c185c0 00000000 f5dc5520 00000000 00000000 00000000 00000003 00000000
Call Trace:    [<c015b6ec>] [<c015b788>] [<c015b808>] [<c015b990>] [<c015ba08>]
  [<c015ba64>] [<c015bd2c>] [<c015bd60>] [<c015bd94>] [<c015bdc8>] [<c015bdfc>]
  [<c015be38>] [<c015be74>] [<c015bf20>] [<c015bf54>] [<c015beec>]

CPU 0:f0cc7e64 c02beffd 00000000 00000000 00000000 c0109ffd c02bf012 f5de3ea0
       00000001 bffff9a8 c01e59f1 bffff9a8 bffff9a8 f0ccbec0 000001ff 0b043b40
       00000000 c01e5e01 f5de3ea0 bffff9a8 f0ee0000 bffff9a8 f0ccbec0 f0ee0000
Call Trace:    [<c0109ffd>] [<c01e59f1>] [<c01e5e01>] [<c0116855>] [<c01d73e3>]
  [<c0132ac8>] [<c0132ae9>] [<c0147a3a>] [<c0147d5f>] [<c0147d9a>] [<c01d4389>]
  [<c0147007>] [<c01089f7>]


wait_on_irq, CPU 0:
irq:  0 [ 0 0 ]
bh:   1 [ 0 1 ]
Stack dumps:
CPU 1:00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
       00000000 00000002 01000000 c1c18740 c1c18740 00000000 c1c18640 f7e9d2a0
       c1c185c0 00000000 f5dc5520 00000000 00000000 00000000 00000003 00000000
Call Trace:    [<c015b6ec>] [<c015b788>] [<c015b808>] [<c015b990>] [<c015ba08>]
  [<c015ba64>] [<c015bd2c>] [<c015bd60>] [<c015bd94>] [<c015bdc8>] [<c015bdfc>]
  [<c015be38>] [<c015be74>] [<c015bf20>] [<c015bf54>] [<c015beec>]

CPU 0:f0cc7e64 c02beffd 00000000 00000000 00000000 c0109ffd c02bf012 f5de3ea0
       00000001 bffff9a8 c01e59f1 bffff9a8 bffff9a8 f0ccbec0 000001ff 0b043b40
       00000000 c01e5e01 f5de3ea0 bffff9a8 f0ee0000 bffff9a8 f0ccbec0 f0ee0000
Call Trace:    [<c0109ffd>] [<c01e59f1>] [<c01e5e01>] [<c0116855>] [<c01d73e3>]
  [<c0132ac8>] [<c0132ae9>] [<c0147a3a>] [<c0147d5f>] [<c0147d9a>] [<c01d4389>]
  [<c0147007>] [<c01089f7>]


running ksymoops on this:


Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c015b6ec <loadavg_read_proc+0/9c>
Trace; c015b788 <uptime_read_proc+0/80>
Trace; c015b808 <meminfo_read_proc+0/188>
Trace; c015b990 <version_read_proc+0/50>
Trace; c015ba08 <modules_read_proc+0/34>
Trace; c015ba64 <kstat_read_proc+0/2c8>
Trace; c015bd2c <devices_read_proc+0/34>
Trace; c015bd60 <interrupts_read_proc+0/34>
Trace; c015bd94 <filesystems_read_proc+0/34>
Trace; c015bdc8 <dma_read_proc+0/34>
Trace; c015bdfc <ioports_read_proc+0/3c>
Trace; c015be38 <cmdline_read_proc+0/3c>
Trace; c015be74 <locks_read_proc+0/78>
Trace; c015bf20 <swaps_read_proc+0/34>
Trace; c015bf54 <memory_read_proc+0/3c>
Trace; c015beec <execdomains_read_proc+0/34>
Trace; c0109ffd <__global_cli+bd/124>
Trace; c01e59f1 <get_modem_info+21/140>
Trace; c01e5e01 <rs_ioctl+8d/42c>
Trace; c0116855 <schedule+49d/560>
Trace; c01d73e3 <normal_poll+103/11f>
Trace; c0132ac8 <__free_pages+1c/20>
Trace; c0132ae9 <free_pages+1d/20>
Trace; c0147a3a <poll_freewait+3a/44>
Trace; c0147d5f <do_select+1eb/204>
Trace; c0147d9a <select_bits_free+a/10>
Trace; c01d4389 <tty_ioctl+371/3a8>
Trace; c0147007 <sys_ioctl+1bb/1f6>
Trace; c01089f7 <system_call+33/38>
Trace; c015b6ec <loadavg_read_proc+0/9c>
Trace; c015b788 <uptime_read_proc+0/80>
Trace; c015b808 <meminfo_read_proc+0/188>
Trace; c015b990 <version_read_proc+0/50>
Trace; c015ba08 <modules_read_proc+0/34>
Trace; c015ba64 <kstat_read_proc+0/2c8>
Trace; c015bd2c <devices_read_proc+0/34>
Trace; c015bd60 <interrupts_read_proc+0/34>
Trace; c015bd94 <filesystems_read_proc+0/34>
Trace; c015bdc8 <dma_read_proc+0/34>
Trace; c015bdfc <ioports_read_proc+0/3c>
Trace; c015be38 <cmdline_read_proc+0/3c>
Trace; c015be74 <locks_read_proc+0/78>
Trace; c015bf20 <swaps_read_proc+0/34>
Trace; c015bf54 <memory_read_proc+0/3c>
Trace; c015beec <execdomains_read_proc+0/34>
Trace; c0109ffd <__global_cli+bd/124>
Trace; c01e59f1 <get_modem_info+21/140>
Trace; c01e5e01 <rs_ioctl+8d/42c>
Trace; c0116855 <schedule+49d/560>
Trace; c01d73e3 <normal_poll+103/11f>
Trace; c0132ac8 <__free_pages+1c/20>
Trace; c0132ae9 <free_pages+1d/20>
Trace; c0147a3a <poll_freewait+3a/44>
Trace; c0147d5f <do_select+1eb/204>
Trace; c0147d9a <select_bits_free+a/10>
Trace; c01d4389 <tty_ioctl+371/3a8>
Trace; c0147007 <sys_ioctl+1bb/1f6>
Trace; c01089f7 <system_call+33/38>


2 warnings issued.  Results may not be reliable.



-- 
Peter Kruse <pk@q-leap.com>
Q-Leap Networks GmbH
+497071-703171

