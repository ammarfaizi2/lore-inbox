Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264950AbSLJXqc>; Tue, 10 Dec 2002 18:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264992AbSLJXqc>; Tue, 10 Dec 2002 18:46:32 -0500
Received: from dp.samba.org ([66.70.73.150]:46027 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264950AbSLJXqb>;
	Tue, 10 Dec 2002 18:46:31 -0500
Date: Wed, 11 Dec 2002 10:53:43 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: greg@ulima.unil.ch, linux-kernel@vger.kernel.org, linux-dvb@linuxtv.org
Subject: Re: 2.5.51 don't compil with dvb
Message-Id: <20021211105343.4385029a.rusty@rustcorp.com.au>
In-Reply-To: <1039536315.14175.2.camel@irongate.swansea.linux.org.uk>
References: <20021210150748.GB20411@ulima.unil.ch>
	<1039536315.14175.2.camel@irongate.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Dec 2002 16:05:15 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Tue, 2002-12-10 at 15:07, Gregoire Favre wrote:
> > drivers/built-in.o(.text+0x38655): In function `try_attach_device':
> > : undefined reference to `MOD_CAN_QUERY'
> > make: *** [vmlinux] Error 1
> > 
> 
> Modules are still very broken in 2.5.51, its best to compile a system
> which doesn't use modules or stay at an older kernel

That may be true, but in this case, it's the only occurrance of MOD_CAN_QUERY
outside the archs which haven't been updated to the new module loader yet,
and it's a very odd thing to do.

I assume the author meant this:

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.51/drivers/media/dvb/dvb-core/dvb_i2c.c working-2.5.51-dvb/drivers/media/dvb/dvb-core/dvb_i2c.c
--- linux-2.5.51/drivers/media/dvb/dvb-core/dvb_i2c.c	2002-11-28 10:20:07.000000000 +1100
+++ working-2.5.51-dvb/drivers/media/dvb/dvb-core/dvb_i2c.c	2002-12-11 10:53:09.000000000 +1100
@@ -64,10 +64,8 @@ static
 void try_attach_device (struct dvb_i2c_bus *i2c, struct dvb_i2c_device *dev)
 {
 	if (dev->owner) {
-		if (!MOD_CAN_QUERY(dev->owner))
+		if (!try_inc_mod_count(dev->owner))
 			return;
-
-		__MOD_INC_USE_COUNT(dev->owner);
 	}
 
 	if (dev->attach (i2c) == 0) {


-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
