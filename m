Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131197AbRCGVmh>; Wed, 7 Mar 2001 16:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131198AbRCGVm2>; Wed, 7 Mar 2001 16:42:28 -0500
Received: from fenrus.demon.co.uk ([158.152.228.152]:3458 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S131197AbRCGVmM>;
	Wed, 7 Mar 2001 16:42:12 -0500
Message-Id: <m14algd-000ObPC@amadeus.home.nl>
Date: Wed, 7 Mar 2001 21:41:35 +0000 (GMT)
From: arjan@fenrus.demon.nl (Arjan van de Ven)
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Subject: Re: [PATCH] RFC: fix ethernet device initialization
cc: linux-kernel@vger.kernel.org
X-Newsgroups: fenrus.linux.kernel
In-Reply-To: <3AA6A570.57FF2D36@mandrakesoft.com> <3AA6A6D6.70877AA3@mandrakesoft.com>
User-Agent: tin/pre-1.4-981002 ("Phobia") (UNIX) (Linux/2.2.18pre19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3AA6A6D6.70877AA3@mandrakesoft.com> you wrote:
> This bug, which I fix, isn't causing oops AFAIK, just
> exporting ugliness to user space etc.

It CAN and IS causing oopses. init_etherdev() causes /sbin/hotplug to be
invoked, which in turn ifconfig up's the interface.
Several (if not all) drivers have an _up() function which cannot handle 
not-yet initialized device nodes.

Now we don't see this often as on UP systems, /sbin/hotplug is only started
_after_ the probe function either sleeps or exits, and 95% of the probe
functions don't sleep. (The ones that do are indeed reported to oops)
For SMP systems, I guess not that many have cardbus or other hotplug NICs....

Greetings,
   Arjan van de Ven
