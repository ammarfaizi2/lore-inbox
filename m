Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTKBMIf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 07:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbTKBMIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 07:08:32 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:38154 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S261670AbTKBMIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 07:08:25 -0500
Date: Sun, 2 Nov 2003 13:08:20 +0100
From: DervishD <raul@pleyades.net>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Shawn Willden <shawn-lkml@willden.org>, linux-kernel@vger.kernel.org
Subject: Re: /dev/input/mice doesn't work in test9?
Message-ID: <20031102120820.GC206@DervishD>
References: <E1AFUFz-0008jt-00.arvidjaar-mail-ru@f20.mail.ru> <20031101205646.GB9129@DervishD> <200311021312.15902.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200311021312.15902.arvidjaar@mail.ru>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Andrey :)

    Thanks for answering :)

 * Andrey Borzenkov <arvidjaar@mail.ru> dixit:
> > whatever. It just seems that 'mousedev' is never autoloaded :?
> Well, major 13 is for all input devices not for mousedev alone.

    I know, but I just use it for mousedev O:)

> You have input built-in which means there is no reason for kernel
> to try autoload driver for char-13 as it is already available.

    But not char-major-13-32, for example.

> You may add explicit per-minor autoloading to input.c, see 
> drivers/input/input.c:input_open_file()

    But that code works with the 'input_table', and the
input_handlers. The handlers are registered by the modules when they
are already loaded. Do you mean that I should modify input_open_file
in order to autoload the appropriate module in the case of the
handler not being present? Currently input_open_file just returns
ENODEV in that case, but I don't know how to request for autoloading
O:) In fact, if Vojtech hasn't already done that surely there is a
very good reason not to do it... I prefer not modify the kernel for
that. If the only solution is making mousedev and hid built-in
instead of modules, I can do it.

> >     The rest of devices in my system are properly autoloaded on
> > demand, but hid and mousedev are not :( Am I doing something wrong?
> no. Loading on demand simply is not supported.

    OK..
 
> If you are using hotplug, both should be loaded by hotplug. IMHO it is also 
> the right way to go.

    The problem is that hotplug doesn't work for me in this case. I
mean, with hotplug in *this particular case*, since the mouse is
always connected, the modules will be loaded on bootup and unloaded
on shutdown, not when the mouse device is opened and closed,
respectively.

    I've tested with hotplug (well, I don't have hotplug utilities
installed, just a shell script that tells me if someone is calling
/sbin/hotplug and logs the parameters), and /sbin/hotplug is not
called when I try to open /dev/mouse (c 13 32).
 
> >     Exactly... Anyway, if I build 'mousedev' into my kernel instead
> > of making it a module, should I do the same with 'hid' or
> > char-major-13 *is* autoloaded?
> char-major-13 is 'input'. Period. It is not mousedev or whatever. For this 
> reason it must implement its own autoloading if desired. Cf. misc driver.

    My excuses O:) I was refering to char-major-13-32 (or -64, is
just the same for me).

> Hid will never be autoloaded (without manual configuration) on access to 
> mousedev because they are independent.

    Yes, I knew that. It is loaded by hotplug or by hand (or even
with 'above' or 'below' when another module is autoloaded, I
suppose).

> Building it in kernel is the easiest way to ensure it is always available.

    Yes, I'm going to build in hid, but, should I do the same with
mousedev (or event, joystick, etc...) or will it work with hid loaded
when doing 'cat /dev/mouse'?

    Thanks a lot for your help :))

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
