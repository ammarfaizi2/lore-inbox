Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263830AbTKKXaI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 18:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263832AbTKKXaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 18:30:08 -0500
Received: from smtp802.mail.ukl.yahoo.com ([217.12.12.139]:47230 "HELO
	smtp802.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263830AbTKKXaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 18:30:03 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: arief_mulya <arief_m_utama@telkomsel.co.id>
Subject: Re: [PATCH?] psmouse-base.c
Date: Tue, 11 Nov 2003 18:29:50 -0500
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
References: <3FAEF7BC.8060503@telkomsel.co.id> <200311110020.07251.dtor_core@ameritech.net> <3FB08798.7050805@telkomsel.co.id>
In-Reply-To: <3FB08798.7050805@telkomsel.co.id>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311111829.50521.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 November 2003 01:54 am, arief_mulya wrote:
> Dmitry Torokhov wrote:

> >
> >Unfortunately I do not suspend my laptop so I did not run it, just
> >made sure it compiles. Arief? could you give this patch a try?
>
> I have tested it before.
> My first attempts looked quite just like that.
>
> It didn't work quite nicely.
> Especially with gpm, after resume, you cannot do Tap-to-Click behaviour
> with that patch. You can still move it, use left and right button, but
> no tap-to-click. I don't know why. That's why, finally, I use
> serio_rescan().
>
> I haven't tested it with X, though, as I use gpm as a repeater, I
> thought this was unnecessary.
>
> But I have try Andrew's tree. And it works flawlessly with the patch
> (case PM_RESUME: serio_reconnect()). I think I'm going to stick with mm
> tree, and dump my vanilla kernel.
>
> One more think, I also sets "psmouse_resetafter" to 1 at the
> declaration. Without that, I get too many ugly message saying
> "Synaptics lost sync at 1 byte..." or something like that. As it is a
> module parameter, but on menuconfig synaptics does not available as
> module, so I set it directly on the source. I don't know if I can set
> it on boot time, can it?
>

Ok, I somewhat confused as the sequence in psmouse_pm_callback is pretty
much the same as in rescan/reconnect. Wait...
 
Does suspend/resume work at all if you don't set psmouse_resetafter to 1??
The reason I am asking is that we have alot of different PM interfaces and
this one is marked as deprecated. If it is not called during resume it would
leave the touchpad in relative mode while kernel expects absolute and spews 
"lost sync" messages... Until Synaptics decides that it's time to reset 
after X bad packets. Does it make any sense?

Btw, Synaptics is intergated into psmouse module so you don't really need
to edit the source to set resetafter parameter. Either pass 
"psmouse_resetafter=X" to the kernel on boot if psmouse compiled in or
pass it to modprobe.

Dmitry
