Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271597AbRIVPrd>; Sat, 22 Sep 2001 11:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271708AbRIVPrX>; Sat, 22 Sep 2001 11:47:23 -0400
Received: from bau1.a-city.de ([195.126.182.1]:48657 "EHLO bau1.a-city.de")
	by vger.kernel.org with ESMTP id <S271597AbRIVPrF>;
	Sat, 22 Sep 2001 11:47:05 -0400
Message-Id: <200109221547.f8MFlUP06141@bau1.a-city.de>
Content-Type: text/plain; charset=US-ASCII
From: Martin Heiss <mheiss99@uni.de>
To: linux-kernel@vger.kernel.org
Subject: Kernel PPP driver broken in 2.4.10-pre14
Date: Sat, 22 Sep 2001 17:47:26 +0200
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
the linux kernel 2.4.10-pre14 ppp driver seems to be broken for me. 
In kernels <= 2.4.9 it used to work fine!

When i try to insmod the "ppp_async" module it complains about "unresolved 
symbol tty_register_ldisc" and therefore refuses to load.

After looking at the changes being introduced in 2.4.10-pre I was able to fix 
the problem:

The problem is caused by the fact, that in 2.4.10-pre* the line
	EXPORT_SYMBOL(tty_register_ldisc); 
has been _removed_ from 'net/netsyms.c'

after readding this line (i added the "EXPORT_SYMBOL(tty_register_ldisc);" 
right under the tty_register_ldisc declaration in "drivers/char/tty_io.c", 
but "net/netsyms.c" should work too) and recompiling everything now works 
fine for me. (ppp_async now loads correctly again)

Therefore I recommend you to readd the 
	EXPORT_SYMBOL(tty_register_ldisc); 
line whereever you consider it the right place (e.g. drivers/char/tty_io.c 
etc)

cu 

   Martin Heiss
