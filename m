Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267987AbUHKLff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267987AbUHKLff (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 07:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268024AbUHKLff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 07:35:35 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:22770 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267987AbUHKLf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 07:35:29 -0400
Date: Wed, 11 Aug 2004 13:35:24 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Tom Vier <tmv@comcast.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, greg@kroah.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch] 2.6.8-rc4-mm1: i2c-keywest.c compile error
Message-ID: <20040811113523.GD26174@fs.tum.de>
References: <20040810002110.4fd8de07.akpm@osdl.org> <20040811001255.GA14402@zero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811001255.GA14402@zero>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 08:12:55PM -0400, Tom Vier wrote:
> 
> drivers/i2c/busses/i2c-keywest.c: In function `__check_probe':
> drivers/i2c/busses/i2c-keywest.c:94: error: `probe' undeclared (first use in this function)
> drivers/i2c/busses/i2c-keywest.c:94: error: (Each undeclared identifier is reported only once
> drivers/i2c/busses/i2c-keywest.c:94: error: for each function it appears in.)
> drivers/i2c/busses/i2c-keywest.c: At top level:
> drivers/i2c/busses/i2c-keywest.c:94: error: `probe' undeclared here (not in a function)
> drivers/i2c/busses/i2c-keywest.c:94: error: initializer element is not constant
> drivers/i2c/busses/i2c-keywest.c:94: error: (near initialization for `__param_probe.arg')
> drivers/i2c/busses/i2c-keywest.c:96: error: `probe' used prior to declaration
> make[3]: *** [drivers/i2c/busses/i2c-keywest.o] Error 1
>...

Thanks for this report.

The (untested) patch below should fix it.

> Tom Vier <tmv@comcast.net>

cu
Adrian




Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc4-mm1-full/drivers/i2c/busses/i2c-keywest.c.old	2004-08-11 13:28:39.000000000 +0200
+++ linux-2.6.8-rc4-mm1-full/drivers/i2c/busses/i2c-keywest.c	2004-08-11 13:28:54.000000000 +0200
@@ -88,13 +88,13 @@
 };
 #endif /* DEBUG */
 
+static int probe;
+
 MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
 MODULE_DESCRIPTION("I2C driver for Apple's Keywest");
 MODULE_LICENSE("GPL");
 module_param(probe, bool, 0);
 
-static int probe;
-
 #ifdef POLLED_MODE
 /* Don't schedule, the g5 fan controller is too
  * timing sensitive

