Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264329AbRFLLaA>; Tue, 12 Jun 2001 07:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264332AbRFLL3v>; Tue, 12 Jun 2001 07:29:51 -0400
Received: from main.braxis.co.uk ([213.77.40.29]:11270 "EHLO main.braxis.co.uk")
	by vger.kernel.org with ESMTP id <S264329AbRFLL3e>;
	Tue, 12 Jun 2001 07:29:34 -0400
Date: Tue, 12 Jun 2001 13:28:37 +0200
From: Krzysztof Rusocki <kszysiu@braxis.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5 2.4.6pre crashes
Message-ID: <20010612132837.A30675@main.braxis.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

For few months I am running XFS CVS kernels
(http://oss.sgi.com/projects/xfs/). Up till now i haven't faced any generic
2.4 issues. Problems  began while XFS moved to 2.4.5 , same thing (i
believe) i observed with both 2.4.6pre kernels. Linux-xfs people suggested
to mail linux-kernel, so.. take a look please.

My machine is Celeron 366 (Mendocino) 128MB RAM, PIIX4E, PDC20262, HPT366,
with 6 ide disks (4 at PDC, 1 at PIIX4E and  1 at HPT366) and DM9102
Ethernet.
RedHat 6.2 with some vital updates for 2.4 kernels...

Sorry for  not-complete backtrace (no serial console at the moment -
rewritten manually).

Stuff you can find below was observed on 2.4.6-pre2-xfs dated at 06/09.

Machine crashed just before init run gettys (first output, no bt), the
second time it crashed after being up  for 3 minutes ca..

------
Scheduling in interrupt
kernel BUG at sched.c:709!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0111341>]
EFLAGS: 00010092
eax: 0000001b   ebx: 00000000   ecx: c76a4000   edx: 00000001
esi: ffffffff	edi: c01104f4	ebp: c12f9e04	esp: c12f9db4
ds: 0018   es: 0018   ss: 0018
Process init (pid: 1, stackpage=c12f9000)
Stack c024aab4 c024ab56 000002c5 c12f8000 00000000 c01104f4 c12f9e74 c12f8000
      c014ffd6 c7fa9460 c6c38bc0 c12f9e24 c0150200 c12f9e74 c12f9e80 c12f8000
      c014ff17 00000000 c12f8000 c0106c48 c881818c c0106c05 c76b41a0 c76b4228
Call Trace: [<c01104f4>] [<c014ffd6>] [<c0150200>] [<c014ff17>] [<c0106c48>] [<c
881818c>] [<c0106c05>]
       [<c881818c>] [<c881818c>] [<c011a46c>] [<c0119d66>] [<c01171e2>] [<c01171
04>] [<c0116edc>] [<c0107fe8>]
       [<c0106bd8>] [<c0120018>] [<c011e983>] [<c011232f>] [<c0112c4e>] [<c01057
d4>] [<c0106af3>]

Code: 0f 0b 8d 65 bc 5b 5e 5f 89 ec 5d c3 8d 76 00 55 89 e5 83 ec
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
------

------
Scheduling in interrupt
kernel BUG at sched.c:709!

Entering kdb (current=0xc1b30000, pid 1822) Oops: invalid operand
due to oops @ 0xc01118d1
eax = 0x0000001b ebx = 0x00000000 ecx = 0xc75e2000 edx = 0x00000001
esi = 0xffffffff edi = 0x00000246 esp = 0xc1b31ea0 eip = 0xc01118d1
ebp = 0xc1b31ef0 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010086
xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xc1b31e6c
kdb> bt
    EBP       EIP         Function(args)
0xc1b31ef0 0xc01118d1 schedule+0x421 (0xc12e1d40, 0xa490, 0x0, 0xc12e1c00, 0x246
)
                               kernel .text 0xc0100000 0xc01114b0 0xc01118e0
0xc1b31f44 0xc0106cd9 reschedule+0x5 (0xc12e1c00)
                               kernel .text 0xc0100000 0xc0106cd4 0xc0106ce0
           0xc011aa52 timer_bh+0x226
                               kernel .text 0xc0100000 0xc011a82c 0xc011aa90
0xc1b31f74 0xc0117828 bh_action+0x1c (0x0)
                               kernel .text 0xc0100000 0xc011780c 0xc0117844
0xc1b31f8c 0xc0117745 tasklet_hi_action+0x81 (0xc034fd60)
                               kernel .text 0xc0100000 0xc01176c4 0xc0117774
0xc1b31fa4 0xc01174fc do_softirq+0x4c
                               kernel .text 0xc0100000 0xc01174b0 0xc011752c
0xc1b31fbc 0xc01084d3 do_IRQ+0x9f
                               kernel .text 0xc0100000 0xc0108434 0xc01084e4
kdb> lsmod
Module                  Size  modstruct     Used by
cls_u32                 5705  0xc881b000     1  (autoclean)
sch_tbf                 3257  0xc8819000     3
sch_cbq                13053  0xc8814000     1
nls_iso8859-1           3536  0xc8812000     1
kdb>
------

Hope that it helps...

Cheers,
Krzysztof

PS.
 please CC, ain't subscriber.
