Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265803AbRGBCwx>; Sun, 1 Jul 2001 22:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266032AbRGBCwn>; Sun, 1 Jul 2001 22:52:43 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:21002 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265803AbRGBCw2>;
	Sun, 1 Jul 2001 22:52:28 -0400
Date: Sun, 1 Jul 2001 19:51:28 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb-users@lists.sourceforge.net
Subject: Re: usbserial/keyspan module load race [was: 2.4.5 keyspan driver]
Message-ID: <20010701195128.A21973@kroah.com>
In-Reply-To: <20010630003323.A908@glitch.snoozer.net> <20010630133752.A850@glitch.snoozer.net> <20010701154910.A15335@glitch.snoozer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010701154910.A15335@glitch.snoozer.net>; from haphazard@socket.net on Sun, Jul 01, 2001 at 03:49:10PM -0500
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2001 at 03:49:10PM -0500, Gregory T. Norris wrote:
> Ok, I've figured out how to reproduce the problem.
> 
> Initially, usbcore and usb-uhci are the only USB drivers loaded.  If I
> load usbserial and keyspan seperately ("modprobe usbserial ; sleep 5 ;
> modprobe keyspan") everything works correctly.  The problem occurs when
> I let modprobe pull in usbserial behind the scenes as a dependency. The
> keyspan driver (usually) doesn't detect the device, and /proc/modules
> forever lists it as "initializing".  The module won't unload at this
> point, so the driver's unusable until the next reboot.
> 
> Unfortunately I have no idea how/where to fix this.  Anyone want to
> take a stab at it?

Which keyspan driver are you doing this with, keyspan_pda.o or
keyspan.o?

Have you tried having the linux-hotplug scripts install the driver for
you when you plug the device in? <http://linux-hotplug.sourceforge.net/>

thanks,

greg k-h
