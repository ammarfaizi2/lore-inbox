Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264060AbTIILvR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 07:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbTIILvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 07:51:17 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:11648
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264060AbTIILvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 07:51:09 -0400
Date: Tue, 9 Sep 2003 07:50:59 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Greg KH <greg@kroah.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6][CFT] rmmod floppy kills box fixes + default_device_remove
In-Reply-To: <20030908230852.GA3320@kroah.com>
Message-ID: <Pine.LNX.4.53.0309090739270.14426@montezuma.fsmlabs.com>
References: <Pine.LNX.4.53.0309072228470.14426@montezuma.fsmlabs.com>
 <20030908155048.GA10879@kroah.com> <Pine.LNX.4.53.0309081722270.14426@montezuma.fsmlabs.com>
 <20030908230852.GA3320@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Sep 2003, Greg KH wrote:

> You need to sleep until your release function gets called.  Take a look
> at the cpufreq code for an example of this (also the i2c core does
> this.)
>
> > Basically i'd like a pointer as to what to do with these release()
> > functions..
> 
> release() is called when the last reference to this device is dropped.
> When it is called it is then safe to do the following:
> 	- free the memory of the device
> 	- unload the module of the device
> 
> So an empty release() function is the wrong thing to do in 99.99% of the
> situations in the kernel (the one exception seems to be the mca release
> function that recently got added for use when the bus is doing probing
> logic.)
> 
> Does this help out?

Yes thanks, i was confused over which memory references had to be 
maintained.

