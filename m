Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbTICJPb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 05:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbTICJPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 05:15:30 -0400
Received: from f23.mail.ru ([194.67.57.149]:59153 "EHLO f23.mail.ru")
	by vger.kernel.org with ESMTP id S261672AbTICJPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 05:15:09 -0400
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=jeff millar=?koi8-r?Q?=22=20?= 
	<wa1hco@adelphia.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4, psmouse doesn't autoload, CONFIG_SERIO doesn't module
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Wed, 03 Sep 2003 13:15:11 +0400
In-Reply-To: <002f01c371a4$b7207a00$6401a8c0@wa1hco>
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19uTjL-000DJ5-00.arvidjaar-mail-ru@f23.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



[...] 
> > In general there seems to be no way to load low-level input drivers
> > on access because there is no instance that ever accesses them. And
> > as it stands now there is not way to auto-load using some other means.
> > So we are back in static configuration times ...
> 
> Ok, I guess.  But isn't there some module reference that can trigger the
> install of psmouse?
> 

not that I am aware of. You will need more tham just psmouse ...

1. psmouse sits below serio driver. So you have to load serio. It
could be done buy hotplug but I guess at least for 8042 (standard
PC keyboard/mouse controller) it belongs to PnP BIOS subsystem
and PnP BIOS subsystem does not support hotplug currently.

2. After you have loaded corr. serio driver you need to know what
mouse driver to load. It requires some sort of autoporbing and I am
not sure it is actually done in current driver. I presume it is
possible because both Microsoft and Solaris do it. I just do not
know if it is implemented and do not have access to sources now. And
it requires support from hotplug again :)

[...]
> > > 3. Documentation/kmod.txt says "passing the name (to modprobe) that was
> > > requested", couldn't this be more explicit?
> 
> > what exactly do you mean?
> 
> Something like "...passing the name of the device in the form
> 'char-major-x-y' for misc devices and 'char-major-X' for others"
>

feel free to submit a patch. Do not forget that misc is not the only
char driver that is using minors.
 
> BTW, could kmod just pass the name of the file from the open() call?

you miss the point. You just suggest different way to *statically*
configure your mouse driver module while your original question was
why it is not loaded automatically. It does not matter if you enter
"psmouse" in some init script or create a link for it - you still
have to do it manually.

Please look at devfs if you still want to do it. It does exactly
what you ask for.

-andrey
