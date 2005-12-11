Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVLKS14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVLKS14 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 13:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbVLKS14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 13:27:56 -0500
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:13941 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750777AbVLKS1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 13:27:44 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Mouse stalls with 2.6.5-rc5-mm2
Date: Sun, 11 Dec 2005 13:27:40 -0500
User-Agent: KMail/1.8.3
Cc: LKML List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>
References: <9a8748490512110548h22889559ld81374f2626c3ed2@mail.gmail.com>
In-Reply-To: <9a8748490512110548h22889559ld81374f2626c3ed2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512111327.40578.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 December 2005 08:48, Jesper Juhl wrote:
> With 2.6.5-rc5-mm2 I'm getting regular mouse stalls for short periods
> of time ~1sec
> I'm also seeing this in dmesg :
> 
> [  117.308573] psmouse.c: resync failed, issuing reconnect request
> [  157.100063] psmouse.c: resync failed, issuing reconnect request
> [  167.583936] psmouse.c: resync failed, issuing reconnect request
> [  278.986267] psmouse.c: resync failed, issuing reconnect request
> [  328.320242] psmouse.c: resync failed, issuing reconnect request
> [  358.117414] psmouse.c: resync failed, issuing reconnect request
> [  472.814321] psmouse.c: resync failed, issuing reconnect request
> [  492.781941] psmouse.c: resync failed, issuing reconnect request
> [  525.788327] psmouse.c: resync failed, issuing reconnect request
> [  542.843044] psmouse.c: resync failed, issuing reconnect request
> [  552.129681] psmouse.c: resync failed, issuing reconnect request
> 
> The times correspond nicely to the mouse stalls, every time it stalls
> I get a new line, so they are definately related.
> 
> 2.6.5-rc5-git1 works flawlessly.
> No hardware has changed.
> Mouse is a Logitech MouseMan Wheel (M/N: M-BD53) connected to a
> "Master View PRO" KVM switch.
> 
> Comlete dmesg output, .config, ver_linux output, lspci output, lsusb
> output and cat /proc/cpuinfo output attached. Please just ask if
> anything else is needed.
>

Could you please do the following:

1. echo 1 > /sys/modules/i8042/parameters/debug
2. switch away from your linux box
3. wait 5 seconds
4. Switch back to Linux box
5. Move mouse slightly
6. echo 0 > /sys/modules/i8042/parameters/debug
7. Send me dmesg

Also, does the resync fail if you are not using KVM and plug the mouse
directly into the box.

To stop resync attempts do:

	echo -n 0 > /sys/bus/serio/devices/serioX/resync_time

where serioX is serio port asociated with your mouse.

Thanks!

-- 
Dmitry
