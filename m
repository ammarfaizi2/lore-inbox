Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269344AbUICPMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269344AbUICPMS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 11:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269334AbUICPJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 11:09:41 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:39616 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S269359AbUICPJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 11:09:04 -0400
Date: Fri, 3 Sep 2004 15:51:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: John Lenz <lenz@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.8.1 0/2] leds: new class for led devices
Message-ID: <20040903135103.GA982@elf.ucw.cz>
References: <1094157190l.4235l.2l@hydra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094157190l.4235l.2l@hydra>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is an attempt to provide an alternative to the current arm  
> specific led interface.  This arm interface does not integrate well  
> with the device model and sysfs.
> 
> We create a new class that drivers can register a leds_properties  
> structure with.  Each led that is registered is assigned a number, and  
> three attributes are exported to sysfs in /sys/class/leds/1/, /sys/ 
> class/leds/2, etc.
> 
> color : a read only string attribute that shows the available colors of  
> this led.  If it is a multi-color led, then the colors are seperated by  
> a "/" (for example "green/blue").
> 
> function : a read/write attribute that sets the current function of  
> this led.  The available options are
> 
>  timer : the led blinks on and off on a timer
>  idle : the led turns off when the system is idle and on when not idle
>  power : the led represents the current power state
>  user : the led is controlled by user space

I'm afraid this is really good idea. It seems quite overengineered to
me (and I'd be afraid that idle part slows machine). Perhaps having
only "user" mode is better idea?

> light : a read/write attribute that allows userspace to see the current  
> status of the led.  If function="user" then writing to this attribute  
> will change the led on or off.  If function != "user" then writing has  
> no effect.
>  light is an integer, where 0 means off, 1 means on first color, 2  
> means on second color, etc.  (for example, if color="green/blue" then  
> light=1 means turn led on to green and if light=2 means turn led on to  
> blue.

Is there ways to turn on both?
								Pavel

-- 
When do you have heart between your knees?
