Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136077AbREBXSe>; Wed, 2 May 2001 19:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136082AbREBXSX>; Wed, 2 May 2001 19:18:23 -0400
Received: from sj-msg-core-2.cisco.com ([171.69.43.88]:42438 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S136077AbREBXSU>; Wed, 2 May 2001 19:18:20 -0400
Message-Id: <4.3.2.7.2.20010503091459.028524e8@171.69.43.101>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Thu, 03 May 2001 09:19:53 +1000
To: <mingo@elte.hu>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: X15 alpha release: as fast as TUX but in user space
Cc: Fabio Riccardi <fabio@chromium.com>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Christopher Smith <x@xman.org>,
        Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, <David_J_Morse@Dell.com>
In-Reply-To: <Pine.LNX.4.33.0105021047040.3642-100000@localhost.localdom
 ain>
In-Reply-To: <3AEC8562.887CFA72@chromium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At 10:50 AM 2/05/2001 +0200, Ingo Molnar wrote:
>i think Zach's phhttpd is an important milestone as well, it's the first
>userspace webserver that shows how to use event-based, sigio-based async
>networking IO and sendfile() under Linux. (I believe it had some
>performance problems related to sigio queue overflow, these issues might
>be solved in the latest kernels.) The zerocopy enhancements should help
>phhttpd as well.

my experience with sigio-based event-handlers is that the net-gain of 
event-driven i/o is mitigated by the fact that SIGIO is based on signals.

the problem with signals for this purpose are:
  (a) you go thru a syncronization point in the kernel.  signals are protected
      by a spinlock.
      it doesn't scale with SMP.
  (b) SI_PAD_SIZE

explicitly, (b) means that you have an awful lot of memory-accesses going 
on for every signal.
my experience with the overhead is that it mitigates the advantages when 
you become bottlenecked on memory-bus-accesses.


cheers,

lincoln.

