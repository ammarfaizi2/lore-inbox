Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbTIBNoj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 09:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbTIBNoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 09:44:39 -0400
Received: from f17.mail.ru ([194.67.57.47]:36613 "EHLO f17.mail.ru")
	by vger.kernel.org with ESMTP id S261641AbTIBNoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 09:44:19 -0400
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=jeff millar=?koi8-r?Q?=22=20?= 
	<wa1hco@adelphia.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4, psmouse doesn't autoload, CONFIG_SERIO doesn't module
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Tue, 02 Sep 2003 17:44:08 +0400
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19uBS4-000AsR-00.arvidjaar-mail-ru@f17.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. Why doesn't the PS/2 mouse autoload as a module?
> Running 2.6.0-test4, psmouse doesn't autoload as a module.  Oddly,  neither
> gpm nor X complains about the missing module, the mouse just doesn't work.
> But if I modprobe psmouse, the cursor starts moving.  I verified that
> /dev/psaux uses char-major-10-1 and that it has an "alias char-major-10-1
> psaux" in modprobe.conf.

because in 2.6 user-level programs do not speak with low-level hardware
drivers anymore. psmouse feeds events to input midlayer that dispatches
them to those handlers that expressed interest. And those handlers speak
with user-level tools.

/dev/psaux is an *emulated* ImPS mouse that is not related to any
real hardware. It will convert events from _any_ mouse you have into
PS/2 protocol for users but if there is no mouse it just sits there
and waits.

/dev/psaux is provided by mousemod not psmouse.

In general there seems to be no way to load low-level input drivers
on access because there is no instance that ever accesses them. And
as it stands now there is not way to auto-load using some other means.
So we are back in static configuration times ...

> 1. What does kmod send to modprobe?  From looking at modprobe.conf apparently "char-major-x-y".

only for misc devices. It is char-major-X for most others

> 2. Does kmod send any other strings to modprobe?

no.

> 3. Documentation/kmod.txt says "passing the name (to modprobe) that was
> requested", couldn't this be more explicit?

what exactly do you mean?

> 4. Does kmod gets the major-minor number from the device file upon open(),
> or some other way?

from device file on open.

-andrey

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
> 1. Why doesn't the PS/2 mouse autoload as a module?
> Running 2.6.0-test4, psmouse doesn't autoload as a module.  Oddly,  neither
> gpm nor X complains about the missing module, the mouse just doesn't work.
> But if I modprobe psmouse, the cursor starts moving.  I verified that
> /dev/psaux uses char-major-10-1 and that it has an "alias char-major-10-1
> psaux" in modprobe.conf.

because in 2.6 user-level programs do not speak with low-level hardware
drivers anymore. psmouse feeds events to input midlayer that dispatches
them to those handlers that expressed interest. And those handlers speak
with user-level tools.

/dev/psaux is an *emulated* ImPS mouse that is not related to any
real hardware. It will convert events from _any_ mouse you have into
PS/2 protocol for users but if there is no mouse it just sits there
and waits.

/dev/psaux is provided by mousemod not psmouse.

In general there seems to be no way to load low-level input drivers
on access because there is no instance that ever accesses them. And
as it stands now there is not way to auto-load using some other means.
So we are back in static configuration times ...

> 1. What does kmod send to modprobe?  From looking at modprobe.conf apparently "char-major-x-y".

only for misc devices. It is char-major-X for most others

> 2. Does kmod send any other strings to modprobe?

no.

> 3. Documentation/kmod.txt says "passing the name (to modprobe) that was
> requested", couldn't this be more explicit?

what exactly do you mean?

> 4. Does kmod gets the major-minor number from the device file upon open(),
> or some other way?

from device file on open.

-andrey

