Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266023AbUAURbj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 12:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266028AbUAURbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 12:31:39 -0500
Received: from mail.kroah.org ([65.200.24.183]:49358 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266023AbUAURbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 12:31:37 -0500
Date: Tue, 20 Jan 2004 18:18:25 -0800
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Driver Core update for 2.6.1
Message-ID: <20040121021825.GA6981@kroah.com>
References: <20040120011036.GA6162@kroah.com> <yw1xsmibovwp.fsf@ford.guide> <20040120171435.GE18566@kroah.com> <yw1x8yk2o6il.fsf@ford.guide> <20040121001009.GM4923@kroah.com> <yw1xhdyqm590.fsf@ford.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xhdyqm590.fsf@ford.guide>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 02:59:07AM +0100, Måns Rullgård wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > On Tue, Jan 20, 2004 at 06:48:50PM +0100, Måns Rullgård wrote:
> >> Greg KH <greg@kroah.com> writes:
> >> 
> >> > On Tue, Jan 20, 2004 at 09:40:22AM +0100, Måns Rullgård wrote:
> >> >> Greg KH <greg@kroah.com> writes:
> >> >> 
> >> >> >   o ALSA: add sysfs class support for ALSA sound devices
> >> >> 
> >> >> This is still only completed for the intel8x0 driver, right?
> >> >
> >> > The "device" and "driver" symlink will only show up for that driver,
> >> > yes.  But the class support will work for all alsa devices.  Now we can
> >> > add 1 line patches for all of the alsa drivers to enable those
> >> > symlinks...
> >> 
> >> I see.
> >> 
> >> BTW, I still don't get a snd/controlC0 in /udev.  All the other ALSA
> >> devices are there.
> >
> > Is there for me :)
> >
> > What does /sys/class/sound show for you?
> 
> $ ls /sys/class/sound
> pcmC0D0c  pcmC0D0p  pcmC0D1c  timer
> 
> FWIW, I've updated my kernel to ALSA 1.0.1 and merged your patches.

I don't know if any recent ALSA changes took away the controlC nodes,
but your sound/core/sound.c::alsa_sound_init() should have a line in it
that looks like:
	class_simple_device_add(sound_class, MKDEV(major, controlnum<<5), NULL, "controlC%d", controlnum);
and that should always get called (make sure you took the stupid 
#ifdef CONFIG_DEVFS around that for loop.)

I'm guessing you didn't merge quite right :)

thanks,

greg k-h
