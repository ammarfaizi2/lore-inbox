Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbVILNCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVILNCy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 09:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVILNCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 09:02:54 -0400
Received: from oasis.frogfoot.net ([168.210.54.51]:33195 "HELO
	oasis.frogfoot.net") by vger.kernel.org with SMTP id S1750799AbVILNCy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 09:02:54 -0400
Date: Mon, 12 Sep 2005 15:02:42 +0200
From: Abraham van der Merwe <abz@frogfoot.net>
To: Linux Kernel Discussions <linux-kernel@vger.kernel.org>
Subject: adding more than 100 network devices -- problems
Message-ID: <20050912130242.GA15822@oasis.frogfoot.net>
Mail-Followup-To: Linux Kernel Discussions <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Frogfoot Networks CC
X-Operating-System: Debian GNU/Linux oasis 2.4.28-rc1-abz1 (i686)
X-GPG-Public-Key: http://oasis.frogfoot.net/keys/
X-Uptime: 14:49:37 up 11 days, 4:13, 3 users, load average: 0.41, 0.18, 0.11
X-Edited-With-Muttmode: muttmail.sl - 2001-09-27
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I would like to use Linux for egress shaping in an ISP environment. I just
want to make sure client X doesn't get more than Y bandwidth, i.e. I'm not
interested in dividing the bandwidth up into chunks (i.e. HTB, CBQ, etc),
but rather limit clients' bandwidth.

I would like to avoid using ingress policing because I don't want to drop
clients' packets, rather do egress shaping.

As far as I can see, the only way to do this in Linux is to attach tbf to an
interface which means I need 2 interfaces for each client and enqueuing
their traffic to these devices. I am using IMQ for that.

The problem is that network devices are currently limited to 100
(dev_alloc_name() in net/core/dev.c).

Now I don't mind waiting a bit to initialize these devices at boottime, so
increasing this is no problem for me (and tweaking the masks in
include/linux/imq.h), but several problems (that I know or can think about -
there's probably many more) arise when you go above a couple of hundred
devices, all related to kmalloc failures.

Does anyone know

 (a) in which parts of the networking code I'm going to run into problems?
 (b) what I would need to change/fix in order to work around those problems?
 (c) of any better ways to do egress shaping for lots of clients in Linux
     (i.e. some way to avoid having an interface(s) per client)?

-- 

Regards
 Abraham

TODAY the Pond!
TOMORROW the World!
                -- Frogs (1972)

___________________________________________________
 Abraham vd Merwe - Frogfoot Networks CC
 1st Floor, Albion Springs, 183 Main Road, Newlands
 Phone: +27 21 689 3876 Cell: +27 82 565 4451
 Http: http://www.frogfoot.net/ Email: abz@frogfoot.net

