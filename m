Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265447AbRGBWWu>; Mon, 2 Jul 2001 18:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265441AbRGBWWk>; Mon, 2 Jul 2001 18:22:40 -0400
Received: from mail-smtp.socket.net ([216.106.1.32]:3600 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S265451AbRGBWW2>; Mon, 2 Jul 2001 18:22:28 -0400
Date: Mon, 2 Jul 2001 17:22:17 -0500
From: "Gregory T. Norris" <haphazard@socket.net>
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: usbserial/keyspan module load race [was: 2.4.5 keyspan driver]
Message-ID: <20010702172217.A2463@glitch.snoozer.net>
Mail-Followup-To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
	linux-kernel <linux-kernel@vger.redhat.com>
In-Reply-To: <20010630003323.A908@glitch.snoozer.net> <20010630133752.A850@glitch.snoozer.net> <20010701154910.A15335@glitch.snoozer.net> <01070200025204.05063@idun>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01070200025204.05063@idun>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux glitch 2.4.5 #1 Sat Jun 30 17:26:00 CDT 2001 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It wasn't quite as cooperative today, but after a few attempts I was
able to reproduce it.

     root@glitch[~]# modprobe keyspan
     Warning: /lib/modules/2.4.5/kernel/drivers/usb/serial/usbserial.o symbol for parameter vendor not found
     Segmentation fault

     root@glitch[~]# ps -ef|grep "[m]odprobe"
     root@glitch[~]#

     root@glitch[~]# egrep "usb|key" /proc/modules 
     keyspan                22112 (initializing)
     usbserial              17296   0 [keyspan]
     usb-uhci               21200   0 (unused)
     usbcore                48688   1 [keyspan usbserial usb-uhci]

I browsed the full ps output as well, but I didn't find anything
looking like what you described.

On Mon, Jul 02, 2001 at 12:02:52AM +0200, Oliver Neukum wrote:
> When this happens does the modprobe task hang in __down with state D ?
> ps can show you this information.
> 
> 	Regards
> 		Oliver
