Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbUKCTA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbUKCTA0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 14:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUKCTA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:00:26 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:65139 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261800AbUKCTAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:00:16 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-user@lists.sourceforge.net
Subject: Re: [uml-user] Harddisk Shutdown while UML Guest Shutdown
Date: Wed, 3 Nov 2004 20:00:34 +0100
User-Agent: KMail/1.7.1
Cc: Roland Kaeser <roli8200@yahoo.de>, LKML <linux-kernel@vger.kernel.org>
References: <20041103075314.70578.qmail@web26109.mail.ukl.yahoo.com>
In-Reply-To: <20041103075314.70578.qmail@web26109.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411032000.34677.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 08:53, Roland Kaeser wrote:
> Hello
>
> I starting the UML Kernel with the following command:
>
> /install/uml/kernel/vmlinux mem=128M devfs=nomount con=xterm
> eth0=tuntap,,,1.1.1.1 eth1=tuntap,,,2.2.2.2 root=/dev/root
> rootflags=/install/uml/instances/hostfc2install rootfstype=hostfs
>
> The system starts up successfully, and opens all the xterm for the
> consoles. I can login and work with the guest system.
> Then I shut down the guest system from inside the guest system using the
> command init 0 or shutdown.

> The guest shuts down normally.
> But in the moment when the uml kernel exits in the xterm where I started
> it, I CAN HEAR the harddisk of the host goes down.

Ok, with this explaination, I can believe that this happens. Sorry for my 
first answer, I first took the most likely idea, i.e. the hard disk spins 
down because it's no more used, but the host kernel is still alive and 
kicking, and the hard drive will spin up when needed. Anyway, this 
description, w

You are using a vanilla host kernel (2.6.9), so you have no SKAS patch 
running, i.e. this is a host kernel bug, actually, and it is pretty severe. 
Attach your .config in next email.

Can you please report that (including the kernel panic message) to LKML, 
CC:ing the -devel list? Also, could you try that with different host kernels? 
Different setups? Are you running your UML as root or not? If you are running 
it as root, then try running it with an unprivileged userid.

> After this, nothing happens more on the host, even the mouse freezes. I
> cannot start an other program or even access the harddisk or login on a
> other tty.

> It freezes the whole guest system. 
You mean obiously the "host" system (i.e. the hardware one; "guest" refers to 
the UML instance).
> About a minute later I get a 
> Kernel Panic from the host kernel
Try to copy and send the text of the panic, (most of the numbers can be 
omitted, even because they are often hard to decode; the list of function 
calls is more important than anything else).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
