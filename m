Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132147AbRCVStH>; Thu, 22 Mar 2001 13:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132148AbRCVSs7>; Thu, 22 Mar 2001 13:48:59 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:52929 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S132147AbRCVSsq>; Thu, 22 Mar 2001 13:48:46 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <frey@cxau.zko.dec.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: kernel_thread vs. zombie
Date: Thu, 22 Mar 2001 19:47:40 +0100
Message-Id: <20010322184740.17781@mailhost.mipsys.com>
In-Reply-To: <007001c0b2f4$a4630110$90600410@SCHLEPPDOWN>
In-Reply-To: <007001c0b2f4$a4630110$90600410@SCHLEPPDOWN>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The stuff done in daemonize() and the exit_files could need
>the kernel lock. At least on some 2.2.x version it does,
>I did not check whether it is still needed on 2.4.

Well, I don't really plan to backport this to 2.2.x. I'll
try to see if my problem is related to the lack of kernel
lock, or maybe I have just something else wrong.

>On stop of the thread I need the big kernel lock to make
>sure the kernel thread exited (everything really done
>from my up() till the thread is in zombie state) before
>I unload the module. The comment in the code should explain 
>in.

Ok. I don't need that as I'm not in a module, no chances I ever
get unloaded. At least not in 2.4. Making ADB and all the controllers
and device drivers in modules would  be an interesting exercise with
module dependencies ;)

>Note that the threads itself do not run with the kernel lock
>held. After setting everything up the make an unlock.

Ok. Well, I just have an atomic flag test&set'ed before starting the
bus reset, and released at the end of the thread. No need to make sure
the previous one is really dead before starting a new one. I could
benefit from semaphores when starting it since if it's already running,
I just loop scheduling waiting for the lock bit to be available. But
that case will almost never happen in real life. ADB probes are quite
rare.

Many thanks for your help,

I'll see what's wrong in my code ;)

ben.



