Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030953AbWKUNeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030953AbWKUNeF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 08:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030955AbWKUNeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 08:34:04 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:52339 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030953AbWKUNeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 08:34:02 -0500
Message-ID: <45630257.9070308@openvz.org>
Date: Tue, 21 Nov 2006 16:42:47 +0300
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: [SPARC64]: resumable error decoding
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

Running stress tests on OpenVZ 2.6.18 sparc64 kernel we hit the following:
------- cut --------
[285401.094964] RESUMABLE ERROR: Reporting on cpu 0
[285401.626736] RESUMABLE ERROR: err_handle[410000000000c6f] err_stick[103921ee2007c] err_type[00000004:warning resumable]
[285402.869015] RESUMABLE ERROR: err_attrs[00000020:       ]
[285403.491920] RESUMABLE ERROR: err_raddr[0000000000000000] err_size[0] err_cpu[0]
[285404.347508] TSTATE: 0000004480001602 TPC: 000000000041931c TNPC: 0000000000419320 Y: 00000000    Not tainted
[285405.496613] TPC: <cpu_idle+0x84/0xc0>
[285405.892615] g0: 00000000006e2531 g1: 0000000000000016 g2: 0000000000000014 g3: 00000000006def80
[285406.550536] g4: 00000000006e2f80 g5: fffff8000449bd40 g6: 00000000006def80 g7: 0000038000004000
[285406.884717] o0: 0000000000000000 o1: 00000000006def88 o2: 0000000000004000 o3: 4000000000000000
[285407.214724] o4: 0000000000001290 o5: 0000000000000012 sp: 00000000006e2531 ret_pc: 0000000000419308
[285407.562135] RPC: <cpu_idle+0x70/0xc0>
[285407.701342] l0: 00000000006de800 l1: 0000000000000027 l2: 0000000000000000 l3: 00000001ff000000
[285408.029282] l4: 0000000040004110 l5: 00000000fff74080 l6: 00000000fff4d701 l7: 00000000f0254040
[285408.348195] i0: 0000000100000000 i1: 0000000000000000 i2: 0000000000000000 i3: 0000000100000000
[285408.681920] i4: 0000000000000080 i5: 0000000000000080 i6: 00000000006e25f1 i7: 00000000007a67ec
[285409.010870] I7: <start_kernel+0x294/0x300>
------- cut --------

it looks like the hardware reports some problem and
the most interesting field is err_attrs...

        u32             err_attrs;
#define SUN4V_ERR_ATTRS_PROCESSOR       0x00000001
#define SUN4V_ERR_ATTRS_MEMORY          0x00000002
#define SUN4V_ERR_ATTRS_PIO             0x00000004
#define SUN4V_ERR_ATTRS_INT_REGISTERS   0x00000008
#define SUN4V_ERR_ATTRS_FPU_REGISTERS   0x00000010
#define SUN4V_ERR_ATTRS_USER_MODE       0x01000000
#define SUN4V_ERR_ATTRS_PRIV_MODE       0x02000000
#define SUN4V_ERR_ATTRS_RES_QUEUE_FULL  0x80000000

.. which should explain what subsystem is faulty.
However, 2.6.18 kernel knows nothing about the value 0x20 :/
I also didn't find anything in available documenation about this.
Can you sched some light on this please?
A link to the doc or some hint would be very much appreciated.

Thanks,
Kirill

