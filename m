Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277288AbRJQWzE>; Wed, 17 Oct 2001 18:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277277AbRJQWyp>; Wed, 17 Oct 2001 18:54:45 -0400
Received: from [207.8.4.6] ([207.8.4.6]:44091 "EHLO one.interactivesi.com")
	by vger.kernel.org with ESMTP id <S277276AbRJQWyf>;
	Wed, 17 Oct 2001 18:54:35 -0400
Message-ID: <3BCE0C41.7090003@interactivesi.com>
Date: Wed, 17 Oct 2001 17:54:57 -0500
From: Timur Tabi <ttabi@interactivesi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>
Subject: in_softirq() question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm writing a module that needs to synchronize with its own tasklet (bottom 
half).  Basically, I need to disable the bottom half whenever the driver has 
been called to do some work.  The tasklet is just a periodic timer that keeps 
the hardware awake, but it should never pre-empty the driver itself.

To do this, I have added local_bh_disable() calls at the top of every entry 
point in my driver.  This works very well.  However, I would add to like 
additional checks to make sure that various code is not executed whenever 
bottom halves are disabled.

I discovered function in_softirq(), but I'm having a hard time understanding 
it.  There's no documentation for it (not even any comments!), and the modules 
in the kernel that do use it don't explain it either.

The code for in_softirq() makes me think that it returns non-zero if any 
thread on this CPU has called local_bh_disable(), which is what I want.  But 
what does in_softirq() means?  If I call local_bh_disable(), soft IRQs are 
disabled, are they not?  Isn't that what a bottom-half is, a soft IRQ?

