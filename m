Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269683AbUISAlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269683AbUISAlt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 20:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269684AbUISAlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 20:41:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:26299 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269683AbUISAlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 20:41:47 -0400
Date: Sat, 18 Sep 2004 17:41:16 -0700
From: Greg KH <greg@kroah.com>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: udev is too slow creating devices
Message-ID: <20040919004115.GB18309@kroah.com>
References: <414C9003.9070707@softhome.net> <20040918213023.GB1901@kroah.com> <414CCD88.30001@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414CCD88.30001@softhome.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2004 at 02:06:32AM +0200, Ihar 'Philips' Filipau wrote:
> 
>   Well, I got your point.
>   I promise I will not use udev ;-)

Heh.

>   For last embedded system where I have had external usb storage used 
> for firmware upgrade, I used preloading of usb-storage - and everything 
> worked well. Seems it worked better than udev will ever worked - with 0 
> user space calls and immediate accessibility of /dev/sda ;-)))

Great, that works for you.  But what about when you have a slow usb hub
that the device is plugged into.  It will take a while for the USB core
to recognize that device and set everything up properly (and who's to
say it will be called /dev/sda anyway?).

> P.P.S. Another day, I hope, you will understand that right system need 
> to provide people with two opposite ways of doing things. Sometimes it 
> is advantage to be event-based and asynchronous, sometimes it is very 
> convient to be dumb & synchronous.

My point is we _can not_ be dumb and synchronous in this situation.  It
just will not work with busses that have devices that can come and go as
the system is running.  It is pretty much impossible to correctly do
what you are proposing.  Just think about the different situations that
we have to handle properly.

thanks,

greg k-h
