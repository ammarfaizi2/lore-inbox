Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbTIBWvS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 18:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbTIBWvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 18:51:18 -0400
Received: from mta10.adelphia.net ([68.168.78.202]:16040 "EHLO
	mta10.adelphia.net") by vger.kernel.org with ESMTP id S261338AbTIBWvQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 18:51:16 -0400
Message-ID: <002f01c371a4$b7207a00$6401a8c0@wa1hco>
From: "jeff millar" <wa1hco@adelphia.net>
To: "Andrey Borzenkov" <arvidjaar@mail.ru>
Cc: <linux-kernel@vger.kernel.org>
References: <E19uBS4-000AsR-00.arvidjaar-mail-ru@f17.mail.ru>
Subject: Re: 2.6.0-test4, psmouse doesn't autoload, CONFIG_SERIO doesn't module
Date: Tue, 2 Sep 2003 18:51:06 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Andrey Borzenkov" <arvidjaar@mail.ru>
> > 1. Why doesn't the PS/2 mouse autoload as a module?
> > Running 2.6.0-test4, psmouse doesn't autoload as a module.  Oddly,
neither
> > gpm nor X complains about the missing module, the mouse just doesn't
work.
> > But if I modprobe psmouse, the cursor starts moving.  I verified that
> > /dev/psaux uses char-major-10-1 and that it has an "alias
char-major-10-1
> > psaux" in modprobe.conf.
>
> because in 2.6 user-level programs do not speak with low-level hardware
> drivers anymore. psmouse feeds events to input midlayer that dispatches
> them to those handlers that expressed interest. And those handlers speak
> with user-level tools.
>
> /dev/psaux is an *emulated* ImPS mouse that is not related to any
> real hardware. It will convert events from _any_ mouse you have into
> PS/2 protocol for users but if there is no mouse it just sits there
> and waits.

> /dev/psaux is provided by mousemod not psmouse.

> In general there seems to be no way to load low-level input drivers
> on access because there is no instance that ever accesses them. And
> as it stands now there is not way to auto-load using some other means.
> So we are back in static configuration times ...

Ok, I guess.  But isn't there some module reference that can trigger the
install of psmouse?

> > 1. What does kmod send to modprobe?  From looking at modprobe.conf
apparently "char-major-x-y".
>
> only for misc devices. It is char-major-X for most others

> > 2. Does kmod send any other strings to modprobe?

> no.

> > 3. Documentation/kmod.txt says "passing the name (to modprobe) that was
> > requested", couldn't this be more explicit?

> what exactly do you mean?

Something like "...passing the name of the device in the form
'char-major-x-y' for misc devices and 'char-major-X' for others"

BTW, could kmod just pass the name of the file from the open() call?
Modprobe could look up the major-minor and/or users could create virtual
devices.  For example, I create a file /dev/my_psaux which is a symlink to
/dev/psaux, the name gets passed to modprobe.  modprobe looks it up and
finds that it's not a device file and looks for an alias, and finds psmouse,
loads it,...problem solved.

thanks for the info,

jeff

