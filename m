Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132256AbRCVXfj>; Thu, 22 Mar 2001 18:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132255AbRCVXfV>; Thu, 22 Mar 2001 18:35:21 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:31683 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S132251AbRCVXfC>; Thu, 22 Mar 2001 18:35:02 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <frey@cxau.zko.dec.com>, <linux-kernel@vger.kernel.org>
Subject: RE: kernel_thread vs. zombie
Date: Fri, 23 Mar 2001 00:33:55 +0100
Message-Id: <20010322233355.8870@mailhost.mipsys.com>
In-Reply-To: <007801c0b309$5bca3530$90600410@SCHLEPPDOWN>
In-Reply-To: <007801c0b309$5bca3530$90600410@SCHLEPPDOWN>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>daemonize() makes calls that are all protected with the
>big kernel lock in do_exit(). All usages of daemonize have
>the big kernel lock held. So I guess it just needs it.
>
>Please let me know whether you have success if it makes
>a difference with having it held.

With a bit more experiments, I have this behaviour:

(I hold the kerne lock, daemonize(), and release the kernel lock, then do
my probe thing which takes a few seconds, and let the thread die by itself)

 - When started during boot (low PID (9)) It becomes a zombie
 - When started from a process that quits after sending the ioctl,
   it is correctly "garbage collected".
 - When started from a process that stays around, it becomes a zombie too

So something is not working, or I'm missing something obvious, or whatever...

Any clue ?

Ben.




