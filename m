Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264377AbTCXRP5>; Mon, 24 Mar 2003 12:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264293AbTCXRP0>; Mon, 24 Mar 2003 12:15:26 -0500
Received: from [81.80.245.157] ([81.80.245.157]:39390 "EHLO smtp.alcove-fr")
	by vger.kernel.org with ESMTP id <S264378AbTCXROZ>;
	Mon, 24 Mar 2003 12:14:25 -0500
Date: Mon, 24 Mar 2003 18:25:48 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Dominik Brodowski <linux@brodo.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       rusty@rustcorp.com.au
Subject: Re: pcmcia_bus_type changes cause oops...
Message-ID: <20030324172548.GG32044@hottah.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Dominik Brodowski <linux@brodo.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	rusty@rustcorp.com.au
References: <20030324153659.GA32044@hottah.alcove-fr> <20030324162519.GB2194@brodo.de> <20030324163744.GD32044@hottah.alcove-fr> <20030324171703.GA3152@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030324171703.GA3152@brodo.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 06:17:03PM +0100, Dominik Brodowski wrote:

> OK, understanding more and more of the problem:
> 
> Firstly, though: is all compiled as modules? 

Yes indeed.

> If not, it's really strange, as
> I use the same driver locally, but built into the kernel. This is what I'd
> recommend for cs.o, ds.o and pci-socket.o/yenta.o anyways.
[...]

> So, I'd suggest you do one of these two things:
> a) modify the process done by modprobe to load the modules in the following
>    order:
> 	- cs.ko

cs.ko doesn't exist, it is part of pcmcia_core here.

> 	- pci-socket.ko/yenta.ko
> 	- ds.ko
> 	- pcnet_cs.ko

Actually this is using the RedHat standard way: /etc/init.d/pcmcia
loads, in order pcmcia_core, yenta.

pcnet_cs get loaded by hotplug, triggered by one of the above modules.

So it seems that what you want is that I disable hotplugging and 
loading pcnet_cs by hand later... Hmmm.

> _or_ b) compile cs.ko / pci-socket.ko/yenta.ko into the kernel
> 
> until I get a proper fix for this problem. 

Sure, I'll try that.

> The requirement of having to load
> the socket drivers before ds.ko will be removed soon... that patch is
> already in my queue somewhere (and will remove the issue you're seeing
> almost surely), but depends on some other stuff. But maybe I can split the
> decisive things out sooner, let's see...

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
