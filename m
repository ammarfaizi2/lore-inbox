Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265698AbUGDOgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265698AbUGDOgK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 10:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265706AbUGDOgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 10:36:10 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:65361 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S265698AbUGDOgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 10:36:01 -0400
Message-ID: <2ff21628040704073632ffa1c9@mail.gmail.com>
Date: Sun, 4 Jul 2004 10:36:00 -0400
From: BAIN <bainonline@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: set_fs() preemption safety? [was sys_fs() safety oops !]
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

is the following block safe to be used in preemptible kernels?

old_fs = get_fs();
set_fs(KERNEL_DS);

do_your_things here; (usually call sys calls stuff from kernel space)

set_fs(old_fs);

i will explain my doubt further,
in nonpreempt kernels this changes the fs segment only on current cpu
and is restored before other code is run on that cpu, you are strictly
_not_ suppose to call schedule without restoring fs first.

but what about when preempt is enabled

even if i don't call schedule other code might start running on this
current cpu without me restoring the fs first?

this code block appears in many places.. even in 2.6 kernels without
disabling the preemption or holding spinlocks. so i am confused...

ne explanations are welcome, thanks in advance

and if this sound a lot funny please laugh your hearts out, a favour
of explaining the joke to this newbee is always welcome
-- 
BAIN
