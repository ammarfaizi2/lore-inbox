Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266006AbUFWQAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbUFWQAz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 12:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265786AbUFWQAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 12:00:55 -0400
Received: from web81304.mail.yahoo.com ([206.190.37.79]:63887 "HELO
	web81304.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266483AbUFWP7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 11:59:45 -0400
Message-ID: <20040623155944.96871.qmail@web81304.mail.yahoo.com>
Date: Wed, 23 Jun 2004 08:59:44 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: RE: Continue: psmouse.c - synaptics touchpad driver sync problem
To: Marc Waeckerlin <marc.waeckerlin@siemens.com>
Cc: t.hirsch@web.de, laflipas@telefonica.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Waeckerlin wrote:
> >
> > If your psmouse module is compiled it then use "psmouse.resetafter=3"
> > as a boot parameter. If psmouse is a module then put
> > "options psmouse resetafer=3" in your /etc/modprobe.conf
> 
> I am sorry, both options do not help at all - well, perhaps the jumping of
> the
> cursor when using the touchpad without external keyboard/mouse
> disconnected
> may be slightly better. But as soon as I plug in the external keyboard,
> the
> old problem occurs.
>

Hmm... OK, I see that you have an active multiplexing controller.
I wonder if it gets reset back to legacy mode when you plug your
external keyboard. (btw, it it just a keyboard or a docking station/
port replicator?). Try passing i8042.nomux to the kernel and try using
your touchpad/keyboard. If nomux does not help you may try to use
psmouse.proto=bare or psmouse.proto=imps to disable Synaptics-specific
extensions.

Also, if you have time, please change #undef DEBUG to #define DEBUG in
drivers/input/serio/i8042.c, reboot, play a bit with touchpad; plug
external keyboard and send me output of "dmesg -s 100000".
 
> Also I have a problem not yet mentioned, but it happened again this
> morning:
> Sometimes - without external keyboard/mouse, only using touchpad and
> internal
> keyboard -, sometimes the keyboard does not work anymore. If I hit any
> arbitrary key, nothing happens anymore. The mouse still works with the
> touchpad. Since I am often mobile, I can't acces the notebook through LAN
> and
> sice keynoard does not work anymore, I cant hit ctrl-alt-f1 or so to
> switch
> to a terminal or to watch the syslog on ctrl-alt-f10. The only thing I can
> do
> is to reboot using the mouse only.
> 

Ok, we were getting reports about this happening with Toshibas, no
resolution yet...

--
Dmitry

