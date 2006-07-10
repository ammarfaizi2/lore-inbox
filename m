Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161296AbWGJCJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161296AbWGJCJD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 22:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161298AbWGJCJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 22:09:03 -0400
Received: from mail1.bizmail.net.au ([202.162.77.164]:27008 "EHLO
	mail1.bizmail.net.au") by vger.kernel.org with ESMTP
	id S1161296AbWGJCJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 22:09:01 -0400
Message-ID: <3994.203.217.29.133.1152498034.squirrel@203.217.29.133>
Date: Mon, 10 Jul 2006 12:20:34 +1000 (EST)
Subject: Re: i2c problem
From: yh@bizmail.com.au
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am not sure whether the following problem is a bug of i2c-core.c in
kernel 2.6 or not.

I have two devices connected to i2c bus in an arm processor. Both device
drivers could load and run together without problems in kernel 2.4. But in
kernel 2.6, only one of device driver can load, when both drivers were
loaded together, it caused a null pointer exception in kernel space. The
following error occurred at calling function device_register(&client->dev)
of int i2c_attach_client(struct i2c_client *client) in i2c-core.c.

Unable to handle kernel paging request at virtual address c0a06078
pgd = c0004000
[c0a06078] *pgd=00000000
Internal error: Oops: 5 [#1]
Modules linked in:
CPU: 0
PC is at kfree+0x34/0x7c
LR is at kobject_set_name+0x9c/0xa8
pc : [<c004f6b4>]    lr : [<c00ceb14>]    Not tainted
sp : c57e1e9c  ip : c57e1ebc  fp : c57e1eb8
r10: c02252a8  r9 : c57e1eec  r8 : 00000000
r7 : 20000013  r6 : 00003064  r5 : c0225278  r4 : c0225250
r3 : c0a06060  r2 : 00040003  r1 : 00000014  r0 : 00003064
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
Control: C000717F  Table: 00004000  DAC: 0000001D
Process swapper (pid: 1, stack limit = 0xc57e0190)
Stack: (0xc57e1e9c to 0xc57e2000)
1e80:                                                                c0225250
1ea0: c0225278 c0225278 c0225274 c57e1ee4 c57e1ebc c00ceb14 c004f690 c0225250
1ec0: c01b2614 c0225274 00000000 00000000 00000000 c01b229c c57e1f10 c57e1ef4
1ee0: c00f5c7c c00cea8c c02252a8 20000013 00000006 c0225250 c02252a8 c01b25d0
1f00: 00000000 c57e1f30 c57e1f14 c011507c c00f5c44 000000d1 c0225238 00000000
1f20: 000000d1 c57e1f60 c57e1f34 c00f18b8 c0114f00 007e1f28 000000d1 c01b0000
1f40: c57e1f37 c01b0978 c01b26b8 c01b22c0 c01b25d0 c57e1f90 c57e1f64 c0114998
1f60: c00f1788 00000000 c01187e8 c01b25d0 00000000 00000001 c0019f40 00000000
1f80: 00000000 c57e1fbc c57e1f94 c0118b2c c011481c c0019f20 000000d1 00000000
1fa0: c57e1f97 c01ff120 c01ff11c 00000000 c57e1fd4 c57e1fc0 c00158e8 c0118a88
1fc0: c0019f20 c57e0000 c57e1ff4 c57e1fd8 c001a0dc c001586c 00000000 00000000
1fe0: 00000000 00000000 00000000 c57e1ff8 c0032dd8 c001a064 ffffffff ffffffff
Backtrace:
[<c004f680>] (kfree+0x0/0x7c) from [<c00ceb14>] (kobject_set_name+0x9c/0xa8)
 r7 = C0225274  r6 = C0225278  r5 = C0225278  r4 = C0225250
[<c00cea78>] (kobject_set_name+0x0/0xa8) from [<c00f5c7c>]
(device_add+0x48/0xf)
 r3 = 00000006  r2 = 20000013  r1 = C02252A8
[<c00f5c34>] (device_add+0x0/0xf0) from [<c011507c>]
(i2c_attach_client+0x18c/0)
 r7 = 00000000  r6 = C01B25D0  r5 = C02252A8  r4 = C0225250
[<c0114ef0>] (i2c_attach_client+0x0/0x1dc) from [<c00f18b8>]
(fm31x_probe+0x140)
 r6 = 000000D1  r5 = 00000000  r4 = C0225238

Thank you.

Jim

