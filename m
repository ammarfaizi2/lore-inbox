Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbTIXJPM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 05:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbTIXJPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 05:15:12 -0400
Received: from web40008.mail.yahoo.com ([66.218.78.26]:58898 "HELO
	web40008.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261429AbTIXJPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 05:15:02 -0400
Message-ID: <20030924091501.30756.qmail@web40008.mail.yahoo.com>
Date: Wed, 24 Sep 2003 02:15:01 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Problems with the maestro3 OSS driver on 2.6.0-test5-bk10
To: zab@zabbo.net
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Brown,

I just recently got 2.6.0-test5-bk10 working on my Gateway 600S laptop, which
has an ESS Allegro Maestro3 chip. Right now I'm using the maestro3 OSS driver
under 2.4.22-ac2 without problems, but when I boot to 2.6.0-test5-bk10 and try
to use the driver (i.e. open /dev/dsp using the Mozilla Shockwave plugin), I
get the following Oopses:

Unable to handle kernel NULL pointer dereference at virtual address 00000188
 printing eip:
e4cbcd33
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<e4cbcd33>]    Not tainted
EFLAGS: 00010002
EIP is at m3_open+0x128/0x3a8 [maestro3]
eax: dbc2a000   ebx: 00000000   ecx: df373778   edx: d37b06ec
esi: df373768   edi: 00000003   ebp: df373778   esp: dbc2be98
ds: 007b   es: 007b   ss: 0068
Process MozillaFirebird (pid: 1203, threadinfo=dbc2a000 task=da6bd760)
Stack: e4cbea91 00000077 c01873cb dfca3190 dbc2bf00 dbc2befc e4c98f80 c01809c5
       00000246 ff0043c0 dbc2a000 e4c98f20 00000000 00000003 e4c97a50 df58adbc
       d37b06ec dd445d98 dbc2a000 dbc2a000 dd445d98 c0180881 e4cc1980 dbc2a000
Call Trace:
 [<c01873cb>] link_path_walk+0x85e/0xdd2
 [<c01809c5>] cdev_get+0x5a/0xb8
 [<e4c97a50>] soundcore_open+0x29a/0x61e [soundcore]
 [<c0180881>] exact_match+0x0/0x5
 [<c0180157>] chrdev_open+0x220/0x617
 [<c01731a8>] get_empty_filp+0x75/0xe8
 [<c017ff37>] chrdev_open+0x0/0x617
 [<c0170c41>] dentry_open+0x14d/0x218
 [<c0170af2>] filp_open+0x67/0x69
 [<c01712f2>] sys_open+0x5b/0x8b
 [<c010a149>] sysenter_past_esp+0x52/0x71

Code: 81 bb 88 01 00 00 3c 4b 24 1d 74 26 8d 83 88 01 00 00 c7 44
 <6>note: MozillaFirebird[1203] exited with preempt_count 2
Debug: sleeping function called from invalid context at kernel/fork.c:451
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c01213ff>] __might_sleep+0x9c/0xb9
 [<c01223e4>] mm_release+0x76/0xc0
 [<c01285cd>] do_exit+0x91/0x8e1
 [<c010b348>] do_divide_error+0x0/0xfb
 [<c011c112>] do_page_fault+0x14a/0x476
 [<c0194e35>] d_alloc+0x20/0x37e
 [<c011e3f6>] scheduler_tick+0x5cf/0x5db
 [<c01caa0a>] ext3_lookup+0xc0/0xc7
 [<c011bfc8>] do_page_fault+0x0/0x476
 [<c010abc5>] error_code+0x2d/0x38
 [<e4cbcd33>] m3_open+0x128/0x3a8 [maestro3]
 [<c01873cb>] link_path_walk+0x85e/0xdd2
 [<c01809c5>] cdev_get+0x5a/0xb8
 [<e4c97a50>] soundcore_open+0x29a/0x61e [soundcore]
 [<c0180881>] exact_match+0x0/0x5
 [<c0180157>] chrdev_open+0x220/0x617
 [<c01731a8>] get_empty_filp+0x75/0xe8
 [<c017ff37>] chrdev_open+0x0/0x617
 [<c0170c41>] dentry_open+0x14d/0x218
 [<c0170af2>] filp_open+0x67/0x69
 [<c01712f2>] sys_open+0x5b/0x8b
 [<c010a149>] sysenter_past_esp+0x52/0x71

The driver detects my chip like this (the driver itself is compiled as a
module):

maestro3: version 1.23 built at 18:55:27 Sep 23 2003
maestro3: Configuring ESS Allegro found at IO 0x5000 IRQ 5
maestro3:  subvendor id: 0x0600107b
ac97_codec: AC97 Audio codec, id: 0x4583:0x8308 (ESS Allegro ES1988)

And under 2.6, lspci -vv says this:

02:03.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 12)
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 5000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Should I try the ALSA drivers next? Or is this a bug fixed elsewhere? (i.e.
2.6.0-test5-mm4)

TIA

Brad Chapman

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
