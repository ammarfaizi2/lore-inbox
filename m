Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263439AbTKAU4m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 15:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263444AbTKAU4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 15:56:42 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:34831 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S263439AbTKAU4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 15:56:40 -0500
Date: Sat, 1 Nov 2003 21:56:46 +0100
From: DervishD <raul@pleyades.net>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Shawn Willden <shawn-lkml@willden.org>, linux-kernel@vger.kernel.org
Subject: Re: /dev/input/mice doesn't work in test9?
Message-ID: <20031101205646.GB9129@DervishD>
References: <E1AFUFz-0008jt-00.arvidjaar-mail-ru@f20.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1AFUFz-0008jt-00.arvidjaar-mail-ru@f20.mail.ru>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Andrey and Shawn :)

 * "Andrey Borzenkov"  <arvidjaar@mail.ru> dixit:
> > I'm sure I'm just missing something stupid, but google doesn't
> > seem to turn up anything, so...
    
    Exactly the same for me...
 
> > I'm trying to use 2.6.0-test9 on a machine with a USB mouse.  With 2.4, I 
> > have X configured to use /dev/input/mice (c 13 63) as my mouse pointer, 
> > and it works great.  With test9, XFree86 fails to start because it can't 
> > open the mouse.  The error is "xf86OpenSerial: Cannot open device /dev/
> > input/mice  No such device.".

    My problem is a bit different. I'm using 2.4.21, with an USB
mouse. I have 'input' built-in, and hid and mousedev as modules.
Well, if I do a cat /dev/mouse (c 13 32) or /dev/mice (c 13 63), I
always get ENODEV, unless I manually load hid and mousedev. The logs
doesn't say anything like 'cannot find driver for char-major-13' or
whatever. It just seems that 'mousedev' is never autoloaded :?

> The whole input subsystem has changed between 2.4 and 2.6.
> Unfortunately, input sysbsystem hotplugging is not currently
> implemented. Your best bet is to forcibly load mousedev during
> boot.

    But hotplugging is for connecting and disconnecting devices, not
for autoloading modules. I mean, if I access any char-major-13, and
the corresponding modules is not loaded, it should autoload :?

    The rest of devices in my system are properly autoloaded on
demand, but hid and mousedev are not :( Am I doing something wrong?

> Alternatively look into hotplug for usermap, it allows provide fake
> mapping for modules - you could add mapping from UDB IDs of oyur
> mouse to mousedev. Loading it statically is likely to be more
> simple.

    Exactly... Anyway, if I build 'mousedev' into my kernel instead
of making it a module, should I do the same with 'hid' or
char-major-13 *is* autoloaded?

    Thanks a lot in advance. I'm missing on this subject...

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
