Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317359AbSHAXnP>; Thu, 1 Aug 2002 19:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317363AbSHAXnP>; Thu, 1 Aug 2002 19:43:15 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:33015 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317359AbSHAXnO>; Thu, 1 Aug 2002 19:43:14 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200208012337.g71NbKs01634@devserv.devel.redhat.com> 
References: <200208012337.g71NbKs01634@devserv.devel.redhat.com>  <Pine.LNX.4.33.0208011203010.3000-100000@penguin.transmeta.com> <mailman.1028232841.11555.linux-kernel2news@redhat.com> 
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: manipulating sigmask from filesystems and drivers 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 02 Aug 2002 00:46:42 +0100
Message-ID: <12523.1028245602@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


zaitcev@redhat.com said:
>  Consider this. An application writes to /dev/dsp0, and ymfpci (for
> example) start DMA. Then user interrupts the app with ^C. When ymfpci
> gets ->release() call, it has to tell the chip to stop DMA, then wait
> until it's complete. If it tries to wait with TASK_INTERRUPTIBLE,
> schedule() will return immediately, and in essense do a busy loop with
> CPU pegged at 100%.

Forgive me; it's late here. What's wrong with -ERESTARTNOINTR?

But even if that's not going to work -- as I said later, there _are_ cases
where you can't really get rid of it. And given the debates we've had
recently about the return value from close(), your release() call seems like
one such, if you really can't restart it.

My point was that we should be making TASK_UNINTERRUPTIBLE _less_ attractive
to encourage people not to use it simply because it's easier than thinking
about the cleanup path, rather than making it more attractive as was
originally suggested.

> Same thing happens in USB, only there it's worse: a spinning
> application locks out khubd and whole subsistem dies. 

Spinning is obviously wrong. If after thinking hard about it you can't come 
up with a better solution, go pick up a form, find 5 kernel hackers to sign 
it saying there really is no better solution, and you can have one of these 
licences to use TASK_UNTERRUPTIBLE that I was talking about :)

--
dwmw2


