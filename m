Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132050AbRCVPJa>; Thu, 22 Mar 2001 10:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132054AbRCVPJV>; Thu, 22 Mar 2001 10:09:21 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:39679 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S132051AbRCVPJM>; Thu, 22 Mar 2001 10:09:12 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <frey@cxau.zko.dec.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: kernel_thread vs. zombie
Date: Thu, 22 Mar 2001 16:07:52 +0100
Message-Id: <20010322150752.27184@mailhost.mipsys.com>
In-Reply-To: <004c01c0b2dc$fa6ab3e0$90600410@SCHLEPPDOWN>
In-Reply-To: <004c01c0b2dc$fa6ab3e0$90600410@SCHLEPPDOWN>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Have a look at:
>http://www.scs.ch/~frey/linux/kernelthreads.html
>I have an example there that starts and stops kernel threads
>from init_module and never produced a zombie.
>I use the same code also to start threads from ioctl and it
>works for me. I tested it on UP and SMP, Intel and Alpha,
>2.2.18 and 2.4.2.

Thanks !

Could you explain me a bit why you need the lock_kernel ? My probe
thread is already protected by some atomic ops, but I'm considering
changing them to semaphores. Is there any need for the bkl to be taken
when calling daemonize or is this just for your own syncronisation needs ?

I don't think you do more than what I currently do to prevent the
zombie (except for the daemonize call, I don't see you changing anything
about the parent thread or whatever). 

At first I though daemonize() would do the trick, but I still see
zombies on my tests. I'm running UP now so I don't since my lack
of lock_kernel() could explain it.

Ben.



