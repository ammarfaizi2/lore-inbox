Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVBGTaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVBGTaX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVBGTaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:30:22 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45967 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261250AbVBGTaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:30:02 -0500
To: Pavel Machek <pavel@ucw.cz>
Cc: Jon Smirl <jonsmirl@gmail.com>, ncunningham@linuxmail.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI] Samsung P35, S3, black screen (radeon))
References: <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net>
	<4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz>
	<1107474198.5727.9.camel@desktop.cunninghams>
	<4202DF7B.2000506@gmx.net>
	<1107485504.5727.35.camel@desktop.cunninghams>
	<9e4733910502032318460f2c0c@mail.gmail.com>
	<20050204074454.GB1086@elf.ucw.cz>
	<9e473391050204093837bc50d3@mail.gmail.com>
	<20050205093550.GC1158@elf.ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Feb 2005 12:27:41 -0700
In-Reply-To: <20050205093550.GC1158@elf.ucw.cz>
Message-ID: <m1lla0187m.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
> 
> > > We already try to do that, but it hangs on 70% of machines. See
> > > Documentation/power/video.txt.
> > 
> > We know that all of these ROMs are run at power on so they have to
> > work. This implies that there must be something wrong with the
> > environment the ROM are being run in. Video ROMs make calls into the
> > INT vectors of the system BIOS. If these haven't been set up yet
> > running the VBIOS is sure to hang.  Has someone with ROM source and
> > the appropriate debugging tools tried to debug one of these hangs?
> > Alternatively code could be added to wakeup.S to try and set these up
> > or dump the ones that are there and see if they are sane.
> 
> Rumors say that notebooks no longer have video bios at C000h:0; rumors
> say that video BIOS on notebooks is simply integrated into main system
> BIOS. I personaly do not know if rumors are true, but PCs are ugly
> machines....

The state of current hardware has already been mentioned but let
me clarify.  This is not a laptop problem anytime you have onboard
video you are unlikely to have a separate video ROM.  This includes
many recent server boards as well as laptops.  When the board boots
up there will be a video option ROM shadowed into the usually location
at C000h:0 but what becomes of it afterwards is a good question.

For server boards most commonly this seems to be a flavor of the ATI
Rage XL chip.  It is a low end part that I doubt getting documentation
for will be very hard.   And according to
Documentation/power/video.txt this is one of the cases that actually
works.

What is happening in those POST routines of a video card is typically
the code to initialize the memory controller on the video card.  Plus
a little bit of code to set the video mode.  If I read the
documentation correctly in a S3 power state only the RAM is preserved.
So it does look like the video post is needed.

Hmm.  Looking at the ACPI 3.0 spec it appears there is a _ROM method
that can be called to get a copy of the ROM image for an onboard
video card.  Has any one tried that method?

Eric

