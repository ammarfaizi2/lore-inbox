Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263832AbTIIAd7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 20:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263840AbTIIAd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 20:33:59 -0400
Received: from ns1.citynetwireless.net ([209.218.71.4]:12819 "EHLO
	mail.citynetwireless.net") by vger.kernel.org with ESMTP
	id S263832AbTIIAdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 20:33:54 -0400
Message-ID: <007e01c3766a$bd0f8df0$6ff6d618@bp>
From: "Brad Parker" <parker@citynetwireless.net>
To: <linux-kernel@vger.kernel.org>
Subject: kernel BUG in sched.c
Date: Mon, 8 Sep 2003 19:38:50 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a kernel BUG mentioning the process ospfd (zebra/quagga routing
protocol daemon) while trying to  "shutdown -r now", I already contaced the
quagga people, but I thought maybe this would be a kernel issue, so here
goes:

the machine is a Soekris net4521 (Elan SC520 cpu)

the output:

-bash-2.05b# shutdown -r now
INIT: Sending processes started by init the TERM signal
INIT: Sending all processes the TERM signal...
cardmgr[53]: exeScheduling in interrupt
cuting: './netwokernel BUG at sched.c:564!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0115a7b>]    Not tainted
EFLAGS: 00010282
eax: 00000018   ebx: c11be280   ecx: 00000001   edx: 00000001
esi: c38a6000   edi: c38a6000   ebp: c38a7fa0   esp: c38a7f80
ds: 0018   es: 0018   ss: 0018
Process ospfd (pid: 85, stackpage=c38a7000)
Stack: c02d798a c38a6000 c38a6000 00000000 c38a6000 c11be280 c10b5200
c38a6000
       00000000 c011b51d c38a6000 4018db4c 00000000 bffff85c c011b65f
00000000
       c01071d3 00000000 00000001 00000000 4018db4c 00000000 bffff85c
00000001
Call Trace:    [<c011b51d>] [<c011b65f>] [<c01071d3>]

Code: 0f 0b 34 02 82 79 2d c0 5a e9 1c fd ff ff 0f 0b 2d 02 82 79
<0>Kernel panic: Aiee, killing interrupt handler!

In interrupt handler - not syncing
 <6>wlan0: SW TICK stuck? bits=0x0 EvStat=8000 IntEn=e09f
wlan1: SW TICK stuck? bits=0x0 EvStat=8000 IntEn=e09f
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan0: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018
wlan1: SW TICK stuck? bits=0x0 EvStat=8080 IntEn=e018


