Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267639AbSKTHVR>; Wed, 20 Nov 2002 02:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267640AbSKTHUZ>; Wed, 20 Nov 2002 02:20:25 -0500
Received: from dp.samba.org ([66.70.73.150]:57555 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267641AbSKTHTt>;
	Wed, 20 Nov 2002 02:19:49 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, jgarzik@pobox.com,
       davem@redhat.com
Subject: Re: [PATCH] mii module broken under new scheme 
In-reply-to: Your message of "Tue, 19 Nov 2002 19:21:54 BST."
             <7FA2FEC6B51@vcnet.vc.cvut.cz> 
Date: Wed, 20 Nov 2002 08:49:12 +1100
Message-Id: <20021120072654.3904E2C088@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <7FA2FEC6B51@vcnet.vc.cvut.cz> you write:
> I think that retrieving module name from module's binary is wrong: I
> need to have dummy.o (network driver) insmodded two times to get my
> test environment up. 
> 
> I do not think that it is correct that I must add multiple device support 
> to the dummy due to new module loader, and creating two dummy.o,
> with different .modulename sections, also does not look like reasonable
> solution to me.

Doing this based on module name has been deprecated basically forever,
because it doesn't work *at all* when you build it into the kernel.
The reason that modules know their own name is that boot parameters
are called by it.

Four possible solutions:
1) Fix dummy to be a real device driver.
2) Add a module parameter to set the device name on dummy.o
3) Allow the build system to construct multiple modules.
4) Implement modprobe --rename.

If none of them appeals, we can discuss it.

Hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
