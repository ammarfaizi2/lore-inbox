Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265536AbUAPRli (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 12:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265576AbUAPRli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 12:41:38 -0500
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:46734 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S265536AbUAPRlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 12:41:37 -0500
Message-Id: <200401161741.i0GHfURr026241@ginger.cmf.nrl.navy.mil>
To: Muli Ben-Yehuda <mulix@mulix.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ATM]: refcount atm sockets 
In-Reply-To: Message from Muli Ben-Yehuda <mulix@mulix.org> 
   of "Fri, 16 Jan 2004 14:53:18 +0200." <20040116125317.GD734@actcom.co.il> 
Date: Fri, 16 Jan 2004 12:41:32 -0500
From: chas williams (contractor) <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-6.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

for 2.4 kernels i am afraid this is they way it has to be unless
the upper socket layer is rewritten a bit.  the purpose of this patch
is to prevent stupid behavior.  things will be bit racy but its better
than being able to rmmod atm when 'non device' atm sockets are still open.

In message <20040116125317.GD734@actcom.co.il>,Muli Ben-Yehuda writes:
>On Fri, Jan 16, 2004 at 10:02:24AM +0000, Linux Kernel Mailing List wrote:
>> ChangeSet 1.1405.1.4, 2004/01/16 02:02:24-08:00, chas@cmf.nrl.navy.mil
>>=20
>> 	[ATM]: refcount atm sockets
>
>> diff -Nru a/net/atm/common.c b/net/atm/common.c
>> --- a/net/atm/common.c	Fri Jan 16 04:17:24 2004
>> +++ b/net/atm/common.c	Fri Jan 16 04:17:24 2004
>> @@ -242,6 +242,8 @@
>>  		printk(KERN_DEBUG "vcc_sock_destruct: wmem leakage (%d bytes) d
>etected=
>=2E\n", atomic_read(&sk->wmem_alloc));
>> =20
>>  	kfree(sk->protinfo.af_atm);
>> +
>> +	MOD_DEC_USE_COUNT;
>
>This has the usual wellknown races involved with handling the module's
>refcount from within the moodule. Is there a way to push the
>refcounting to the caller?=20
