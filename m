Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265773AbTBCLZv>; Mon, 3 Feb 2003 06:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265786AbTBCLZu>; Mon, 3 Feb 2003 06:25:50 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:1387
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265773AbTBCLZu>; Mon, 3 Feb 2003 06:25:50 -0500
Date: Mon, 3 Feb 2003 06:34:21 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Andrew Morton <akpm@digeo.com>
Subject: [PATCH][0/6] CPU Hotplug update + fixes
Message-ID: <Pine.LNX.4.44.0302030301120.9361-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	These patches are in no way an attempt to push this for inclusion, 
but instead a bit of grunt work to keep it current. However i would 
very much so like see it included in mainline.

- sync against 2.5.59
- add additional cpu_online check in i386 cpu_up to differentiate
  between boot and runtime offlined/onlined cpus.
- fix cpu online show/store oops due to changes in struct device_attribute
- added CPU_DEAD case for mm/slab.c to fix memory leak (double allocation) and
  added stop_cpu_timer()
- added CPU_DEAD case for RCU, here we clear the cpu's rcu_data and kill its
  tasklet. Added rcu_offline_cpu()
- added CPU_DEAD case for fs/buffer.c (suggestion from Andrew Morton, bugs 
  from me)

Tested on a 4way i386 with cpu offline, online whilst doing make -j4 
bzImage. It is possible to induce what appear to be deadlocks but i am 
working through those as i go along. Rusty is there anything i can do to 
get this merged with what you currently have?

	Zwane
-- 
function.linuxpower.ca

