Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266646AbUGPWnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266646AbUGPWnu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 18:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266648AbUGPWnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 18:43:50 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:8824 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266646AbUGPWnk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 18:43:40 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Kevin Fenzi <kevin-kernel@scrye.com>
Subject: Re: psmouse as module with suspend/resume
Date: Fri, 16 Jul 2004 17:43:37 -0500
User-Agent: KMail/1.6.2
Cc: Brouard Nicolas <brouard@ined.fr>, linux-kernel@vger.kernel.org,
       Nigel Cunningham <ncunningham@linuxmail.org>
References: <20040715205459.197177253D@voldemort.scrye.com> <200407160058.57824.dtor_core@ameritech.net> <20040716164704.CFC1A43FF@voldemort.scrye.com>
In-Reply-To: <20040716164704.CFC1A43FF@voldemort.scrye.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200407161743.37577.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 July 2004 11:46 am, Kevin Fenzi wrote:
> >>>>> "Dmitry" == Dmitry Torokhov <dtor_core@ameritech.net> writes:
> 
> Dmitry> On Thursday 15 July 2004 03:54 pm, Kevin Fenzi wrote:
> >> Greetings.
> >>
> >> I am having a bit of an issue with psmouse and suspend/resume.  I
> >> am using the swsusp2, which is working great... (Thanks Nigel!)
> >>
> >> However:
> >>
> >> If I compile psmouse as a module and leave it in and suspend/resume
> >> when the laptop comes back the mouse doesn't work at all.
> >>
> >> If I compile psmouse as a module and unload before suspend, and
> >> reload after resume, the mouse works for simple movement, but all
> >> the advanced synaptics features no longer work. No tap for mouse
> >> button, no scolling, etc.
> >>
> >> If I compile psmouse in everything works after a suspend/resume
> >> cycle.
> 
> Dmitry> There should not be any differences between module and
> Dmitry> compiled version.  Could you please change #undef DEBUG to
> Dmitry> #define DEBUG in drivers/input/serio/i8042.c module and post
> Dmitry> the full dmesg (you may have to use log_buf_size=131072 and
> Dmitry> 'dmesg -s 131072' to get the full dmesg).
> 
> ok. I did that...
> 
> Here is a boot up with psmouse as a module.
> Then a suspend.
> Then a rmmod psmouse; modprobe psmouse.
>

>From what I see there was no attempts to reconnect any of the devices
connected to PS/2 ports.

I am inclined to say that it's swsusp2 problem. I briefly looked over
the code and I could not find a place where device_power_up would be
called; swsusp2 goes straight to device_resume. This causes system
devices (and i8042 is currently a system device) not be resumed and
thus your touchpad is left id default PS/2 hardware emulation mode.

Have you tried swsusp1? It seems to have the proper hooks in place.
 
-- 
Dmitry
