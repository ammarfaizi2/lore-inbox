Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135254AbRDLS7W>; Thu, 12 Apr 2001 14:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135256AbRDLS7M>; Thu, 12 Apr 2001 14:59:12 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:63981 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S135254AbRDLS67>; Thu, 12 Apr 2001 14:58:59 -0400
Message-ID: <3AD5F9FE.9A49374D@uow.edu.au>
Date: Thu, 12 Apr 2001 11:54:54 -0700
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18-0.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rod Stewart <stewart@dystopia.lab43.org>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: 8139too: defunct threads
In-Reply-To: <Pine.LNX.4.33.0104121336040.31024-100000@dystopia.lab43.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rod Stewart wrote:
> 
> Hello,
> 
> Using the 8139too driver, 0.9.15c, we have noticed that we get a defunct
> thread for each device we have; if the driver is built into the kernel.
> If the driver is built as a module, no defunct threads appear.

What is the parent PID for the defunct tasks?  zero?

<slaps head> swapper doesn't know how to reap children, and
AFAIK there's no way for a kernel thread to fully clean itself
up.  This is always done by the parent.

ho-hum.  Jeff, I think the best fix here is to bite the
bullet and write kernel_daemon(), which will delegate
thread creation to keventd, which is the only thing
we have which reaps zombies.  Any better ideas?
