Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317957AbSFSRtw>; Wed, 19 Jun 2002 13:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317959AbSFSRtv>; Wed, 19 Jun 2002 13:49:51 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:30477 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317958AbSFSRtJ>;
	Wed, 19 Jun 2002 13:49:09 -0400
Date: Wed, 19 Jun 2002 10:47:55 -0700
From: Greg KH <greg@kroah.com>
To: Felipe Contreras <al593181@mail.mty.itesm.mx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Compaq hotplug fix for 2.5.23
Message-ID: <20020619174755.GC26136@kroah.com>
References: <20020619075300.GA1098@zion.mty.itesm.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020619075300.GA1098@zion.mty.itesm.mx>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 22 May 2002 16:25:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 02:53:00AM -0500, Felipe Contreras wrote:
> Hi,
> 
> This one makes posible to compile the compaq hotplug module.

But does it work?

The tqueue.h patch will fix the compile time error, but I would prefer
to put that in each .c file, and not in the .h file.

The call to run_sbin_hotplug will not bind any drivers that are already
present in the kernel to the new device.  It will only call
/sbin/hotplug, which is not all that is needed.

What needs to be done is to call the same function that CardBus calls,
and remove a lot of the pci device initialization from the compaq (and
IBM) pci hotplug drivers.

It's on my list of things to do, but pretty far down, patches gladly
accepted :)

thanks,

greg k-h
