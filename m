Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbSLVHHY>; Sun, 22 Dec 2002 02:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbSLVHHY>; Sun, 22 Dec 2002 02:07:24 -0500
Received: from dp.samba.org ([66.70.73.150]:14996 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264844AbSLVHHX>;
	Sun, 22 Dec 2002 02:07:23 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15877.26255.524564.576439@argo.ozlabs.ibm.com>
Date: Sun, 22 Dec 2002 18:15:27 +1100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.x disable BAR when sizing
In-Reply-To: <Pine.LNX.4.44.0212211423390.1604-100000@home.transmeta.com>
References: <m17ke3m3gl.fsf@frodo.biederman.org>
	<Pine.LNX.4.44.0212211423390.1604-100000@home.transmeta.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> Actually, I think it's certainly valid to not allow "printk()" to happen
> around the BAR probing, at least at bootup when we control all the CPU's
> tightly anyway.

I'd like us to disable interrupts too.  On powermacs, the interrupt
controller is typically inside a combo I/O ASIC which is on the PCI
bus.  If we take an interrupt while the ASIC's BAR is relocated or
turned off, we will get a machine check when we try to access the
interrupt controller and the kernel will die at that point.

Paul.
