Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQLJPks>; Sun, 10 Dec 2000 10:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129421AbQLJPkj>; Sun, 10 Dec 2000 10:40:39 -0500
Received: from ns.caldera.de ([212.34.180.1]:61704 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129231AbQLJPke>;
	Sun, 10 Dec 2000 10:40:34 -0500
Date: Sun, 10 Dec 2000 16:10:01 +0100
Message-Id: <200012101510.QAA29551@ns.caldera.de>
To: andrewm@uow.edu.au (Andrew Morton), linux-kernel@vger.kernel.org
Subject: Re: hotplug mopup
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <3A3377B3.FDCBE4AD@uow.edu.au>
From: Marcus Meissner <Marcus.Meissner@caldera.de>
Organization: Caldera Systems Inc., German Engineering Division
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A3377B3.FDCBE4AD@uow.edu.au> you wrote:

> A compendium of questions and misc stuff concerning hotplug:

> - Is everyone happy with call_usermodehelper() being asynchronous? It
>   _could_ be given a `synchronous' option, but that's a fair bit of
>   obfuscation and it does expose us to deadlocks if the caller has any
>   semaphores held.

I am happy.

> - On the unregister/removal path, the netdevice layer ensures that
>   the interface is removed from the kernel namespace prior to launching
>   `/sbin/hotplug net unregister eth0'.

>   This means that when handling netdevice unregistration
>   /sbin/hotplug cannot and must not attempt to do anything with eth0!
>   Generally it'll fail to find an interface with this name.  If it does
>   find eth0, it'll be the wrong one due to a race.

I always thought I should have to do "/sbin/ifdown eth0" here.
(Just as I do /sbin/ifup eth0 on register.)

> - I don't think we can say that the kernel hotplug interface is
>   complete until we have real, working, tested userspace tools.  David,
>   could you please summarise the state of play here? In particular,
>   what still needs to be done?

Well, for USB I would like to know which device major/minor entry a newly 
plugged device is associated with.

Like if I insert a new USB camera, I want to easy find out it is char 81.1
(/dev/video1). Or if I plugin a USB storage device I want to easy find out
it is /dev/sda now.

This is currently very hard to do and it would be really nice to have
a solution for this.

Ciao, Marcus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
