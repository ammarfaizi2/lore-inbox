Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264926AbUFAISo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264926AbUFAISo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 04:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264923AbUFAISo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 04:18:44 -0400
Received: from ee.oulu.fi ([130.231.61.23]:47606 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S264926AbUFAISl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 04:18:41 -0400
Date: Tue, 1 Jun 2004 11:18:20 +0300 (EEST)
From: Tuukka Toivonen <tuukkat@ee.oulu.fi>
X-X-Sender: tuukkat@stekt37
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Sau Dan Lee <danlee@informatik.uni-freiburg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: SERIO_USERDEV patch for 2.6
In-Reply-To: <20040530134246.GA1828@ucw.cz>
Message-ID: <Pine.GSO.4.58.0406011105330.6922@stekt37>
References: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de>
 <20040530111847.GA1377@ucw.cz> <xb71xl2b0to.fsf@savona.informatik.uni-freiburg.de>
 <20040530124353.GB1496@ucw.cz> <xb7aczq9he1.fsf@savona.informatik.uni-freiburg.de>
 <20040530134246.GA1828@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 May 2004, Vojtech Pavlik wrote:

>The newest I could find:
>linux-2.6.5-userdev.20040507.patch

Yes, it's still the newest. Applies cleanly against 2.6.6 too.
I didn't want to add features before getting some feedback.

>Coexisting would mean that when someone wants to open the raw device,
>the serio layer would disconnect the psmouse driver, and give control to
>the raw device instead. I believe that could work.

If the user is careful, in practice both kernel and userspace drivers
can work simultaneously with the current code. But if you prefer otherwise,
I'll change it, no problem. However, this could take a few days
or so (busy with real work).

Dmitry suggested adding a kernel parameter to specify which ports would
allow to be read in raw mode and which would be handled by kernel drivers.
In my opinion, almost the same is achieved more conveniently by handling
in raw mode simply exactly those ports that are opened from userspace
(ie. "cat serio1" would disconnect kernel driver), and everything else by
kernel drivers.
No additional parameters would be then necessary, nor module reloads
to change anything.

The only exception I can see is if the kernel driver is loaded first
and its autodetection confuses a device. Or, for example, kernel
driver sets Touchpad into its custom mode, but then user wants to run
standard PS/2 mouse driver in user space. I don't know if the latter
driver could reset the Touchpad back into PS/2 mouse emulation mode.

>I'd like to keep it separate from the
>serio.c file, although it's obvious it'll require to be linked to it
>statically, because it needs hooks there

Agreed. I'll do that (serio-dev.c). Disadvantage: the functions
can not be anymore inline (unless I put lots of stuff into header
file) which may make code less efficient. Hopefully not significantly.

Also, I have to rename serio.c into serio-core.c so that it can be linked
into serio.o with serio-dev.o. The diff will be a bit ugly.

>It's indeed time for me to examine the SERIO_USERDEV patch, and I

Thanks for that :)

>I don't need to test your [San Dan Lee's] userspace drivers,
>as I'm not interested in those.

Fair enough. Just provide a mechanism that allows user space
protocol drivers, and let other people do them if they insist ;)
