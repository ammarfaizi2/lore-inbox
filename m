Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbULaA2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbULaA2A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 19:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbULaA2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 19:28:00 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:64740 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261797AbULaA0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 19:26:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=g5La+jnrC2jLGUHpSc8HHSZTHbCYU822d3xGBhBrKZRHKMf26Au8QtH56RhYkyZkGwNGyH3WGlOT7KU6ok6l7zB1XGopMkLEIzeJov1tvkleqs2E0bArcVPsUACm3mrLkvwpH0W3p6wt3YA2RydEiimpU4b/STQtlcC59qcJM6o=
Message-ID: <105c793f0412301626468198be@mail.gmail.com>
Date: Thu, 30 Dec 2004 19:26:09 -0500
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Fwd: Toshiba PS/2 touchpad on 2.6.X not working along bottom and right sides
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200412301203.44484.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <105c793f04122907116b571ebf@mail.gmail.com>
	 <cr16ho$eh1$1@tangens.hometree.net>
	 <105c793f041230080734d71c4a@mail.gmail.com>
	 <200412301203.44484.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm replying to this message to keep it inside the original thread.
It should be noted that the subject is wrong and that it turns out
that the mouse is actually from Logitech and not Toshiba. Duh.)

> Yes, you can. Booting with psmouse.proto=bare will force the touchpad
> into standard PS/2 mode. You may also try booting with
> psmouse.proto=imps and psmouse.proto=exps - maybe one of these 2 will
> give you virtual scrolling.
> 
> If psmouse is compiled as a module you will have to add
> 
>         options psmouse proto=bare
> 
> to your /etc/modprobe.conf
> 
> Btw, what device/protocol are you using in X? I'd advise setting it
> to "dev/input/mice" and "ExplorerPS/2" so if your touchad is indeed
> sending scroll events X would use them. Could you post your config,
> please?

Thanks, Dmitry. Setting proto=bare has returned the touchpad to it's
original behavior.

Just to be clear, here's what I've done:

If I compiled the psmouse driver into the kernel, I added a line to my
/etc/lilo.conf that looks like:

append="other_driver=option psmouse.proto=bare"

(the psmouse.proto=bare part is the only part really needed).

If I compiled the psmouse driver as a module (psmouse.o), then I added
the following to my /etc/modprobe.conf:

options psmouse proto=bare

then I can just 'modprobe psmouse' and the driver is installed.

Using the other options (imps and exps) didn't change the behavior
much. I had some strange issues with the cursor being occasionally
moved to the upper-right corner of the screen very quickly when I
dragged in the lower and the right sides of the touchpad. This
behavior, however, was not (yet) reproducible. If I can figure out how
to reproduce it reliably, I'll note it later.

Thanks.

-Andy
