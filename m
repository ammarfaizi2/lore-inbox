Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281000AbRKOTO6>; Thu, 15 Nov 2001 14:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281004AbRKOTOt>; Thu, 15 Nov 2001 14:14:49 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:61884 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S281000AbRKOTOc>; Thu, 15 Nov 2001 14:14:32 -0500
Date: Thu, 15 Nov 2001 14:14:30 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Martin McWhorter <m_mcwhorter@prairiegroup.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible Bug: 2.4.14 USB Keyboard
Message-ID: <20011115141430.B10133@devserv.devel.redhat.com>
In-Reply-To: <3BF2DFBF.6090502@prairiegroup.com> <20011114145312.A6925@kroah.com> <mailman.1005834780.32418.linux-kernel2news@redhat.com> <200111151807.fAFI7XN30496@devserv.devel.redhat.com> <3BF40D17.4060501@prairiegroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BF40D17.4060501@prairiegroup.com>; from m_mcwhorter@prairiegroup.com on Thu, Nov 15, 2001 at 12:44:39PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Thu, 15 Nov 2001 12:44:39 -0600
> From: Martin McWhorter <m_mcwhorter@prairiegroup.com>
> To: Pete Zaitcev <zaitcev@redhat.com>,
>    linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: Possible Bug: 2.4.14 USB Keyboard
> 
> > ok, so no usbkbd, it seems. But still, do lsmod too, please.
> 
> [root@m_mcwhorter m_mcwhorter]# /sbin/lsmod
> Module                  Size  Used by
> emu10k1                49584   0  (autoclean)
> sr_mod                 13968   0  (autoclean)
> ac97_codec              9248   0  (autoclean) [emu10k1]
> soundcore               3376   4  (autoclean) [emu10k1]
> usbkbd                  2944   0  (unused)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

YES! Kill this bastard (the best of all is to use rm(1), then reboot).

>[...]
> mousedev                3936   1
> keybdev                 1728   0  (unused)
> hid                    12576   0  (unused)
> input                   3136   0  [usbkbd mousedev keybdev hid]
> usb-uhci               21344   0  (unused)
> usbcore                49184   1  [usbkbd hid usb-uhci]

Dunno how, but usbkbd often manages to disable hid.
Never let it get built. We do have reports of people who
have keyboards not working with hid, very infrequently.
Of course, those guys prefer just to build usbkbd than to
help figuring why hid does not work. If not for that,
usbkbd would be removed from kernel sources long ago.

-- Pete
