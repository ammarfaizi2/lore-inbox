Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbUAUSjc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 13:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265590AbUAUSjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 13:39:31 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:42173 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S264095AbUAUSja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 13:39:30 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Driver Core update for 2.6.1
References: <20040120011036.GA6162@kroah.com> <yw1xsmibovwp.fsf@ford.guide>
	<20040120171435.GE18566@kroah.com> <yw1x8yk2o6il.fsf@ford.guide>
	<20040121001009.GM4923@kroah.com> <yw1xhdyqm590.fsf@ford.guide>
	<20040121021825.GA6981@kroah.com>
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 21 Jan 2004 19:39:27 +0100
In-Reply-To: <20040121021825.GA6981@kroah.com> (Greg KH's message of "Tue,
 20: 18:25 -0800")
Message-ID: <yw1xn08hb0yo.fsf@ford.guide>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Wed, Jan 21, 2004 at 02:59:07AM +0100, Måns Rullgård wrote:
>> Greg KH <greg@kroah.com> writes:
>> 
>> > On Tue, Jan 20, 2004 at 06:48:50PM +0100, Måns Rullgård wrote:
>> >> Greg KH <greg@kroah.com> writes:
>> >> 
>> >> > On Tue, Jan 20, 2004 at 09:40:22AM +0100, Måns Rullgård wrote:
>> >> >> Greg KH <greg@kroah.com> writes:
>> >> >> 
>> >> >> >   o ALSA: add sysfs class support for ALSA sound devices
>> >> >> 
>> >> >> This is still only completed for the intel8x0 driver, right?
>> >> >
>> >> > The "device" and "driver" symlink will only show up for that driver,
>> >> > yes.  But the class support will work for all alsa devices.  Now we can
>> >> > add 1 line patches for all of the alsa drivers to enable those
>> >> > symlinks...
>> >> 
>> >> I see.
>> >> 
>> >> BTW, I still don't get a snd/controlC0 in /udev.  All the other ALSA
>> >> devices are there.
>> >
>> > Is there for me :)
>> >
>> > What does /sys/class/sound show for you?
>> 
>> $ ls /sys/class/sound
>> pcmC0D0c  pcmC0D0p  pcmC0D1c  timer
>> 
>> FWIW, I've updated my kernel to ALSA 1.0.1 and merged your patches.
>
> I don't know if any recent ALSA changes took away the controlC nodes,
> but your sound/core/sound.c::alsa_sound_init() should have a line in it
> that looks like:
> 	class_simple_device_add(sound_class, MKDEV(major, controlnum<<5), NULL, "controlC%d", controlnum);
> and that should always get called (make sure you took the stupid 
> #ifdef CONFIG_DEVFS around that for loop.)
>
> I'm guessing you didn't merge quite right :)

It seems like something did go wrong with my merge.  I'm still trying
to get the hang of bitkeeper, so I'll blame it on the learning curve.

-- 
Måns Rullgård
mru@kth.se
