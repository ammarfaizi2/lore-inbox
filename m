Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbSKHLAe>; Fri, 8 Nov 2002 06:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261837AbSKHLAe>; Fri, 8 Nov 2002 06:00:34 -0500
Received: from [217.167.51.129] ([217.167.51.129]:1996 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S261836AbSKHLAe>;
	Fri, 8 Nov 2002 06:00:34 -0500
Subject: Re: swsusp: don't eat ide disks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3205.1036707953@passion.cambridge.redhat.com>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A4C9@orsmsx119.jf.intel.com>  
	<3205.1036707953@passion.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 08 Nov 2002 12:09:03 +0100
Message-Id: <1036753743.5029.64.camel@zion>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-07 at 23:25, David Woodhouse wrote:
> 
> Actually I do have boxes on which I "echo 1 > /proc/sys/pm/suspend" to make 
> them sleep. Pavel's right though -- that's not a particularly wonderful 
> interface either. Using sys_reboot() makes some sense to me.
> 
> But stuff like battery info in /proc/acpi just has no excuse.

(David: resent, forgot the list)

We need more than just an interface to put the machine to sleep
in fact.

We also need a way for userland to be notified that the machine
will sleep and that it woke up. And if possible in a blocking
way (that is the sleep process waits for the notified userland
app to ack, or refuse).

Typically, that happens today with X via /dev/apm_bios. On PPC,
I emulate this interface, I think ARM does as well. But that
should definitely be replaced by something. Maybe not in kernel
though, that all depends if the kernel can be the initiator
of a suspend process or not.
If it can (upon request from the firmware or whatever), then we need
such an API provided by the kernel. If we decide only userland can
trigger suspend, then we probably need to design some PM daemon
that provides a known interface.

It's very important for apps like X that bang the HW directly to
be notified of the sleep process properly.

Ben.

