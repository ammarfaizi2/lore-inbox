Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265158AbUAJNEq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 08:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265160AbUAJNEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 08:04:46 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:60920 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265158AbUAJNEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 08:04:43 -0500
Date: Sat, 10 Jan 2004 14:05:36 +0100 (CET)
From: =?ISO-8859-1?Q?Gunter_K=F6nigsmann?= <gunter@peterpall.de>
Reply-To: =?ISO-8859-1?Q?Gunter_K=F6nigsmann?= <gunter.koenigsmann@gmx.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: Gunter =?iso-8859-1?q?K=F6nigsmann?= <gunter@peterpall.de>,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] Psmouse log and discard timed out bytes
In-Reply-To: <200401100346.04660.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.53.0401101355210.1175@calcula.uni-erlangen.de>
References: <Pine.LNX.4.53.0401091101170.1050@calcula.uni-erlangen.de>
 <200401100344.03758.dtor_core@ameritech.net> <200401100345.17211.dtor_core@ameritech.net>
 <200401100346.04660.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:6f0b4d165b4faec4675b8267e0f72da4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmmm...


Needed me hours to apply the patches, don't know why, ---


No more bad clicks, no more keypress events --- but still loosing sync 2*n
times at once, most of the times when changing the console, mostly at the
1st byte, the first of the two times occasionally at the 4th...

...New error message: bad data from KBC - timeout every about third sync
loss.

Strange thing is: The sync losses mostly occour half a second after i have
finished using the touchpad, and occasionally when I don't use it at all...

And they occour nearly everytime I switch consoles. (Not using framebuffer,
X or something like this.)

Changing the data rate from the touchpad changes nothing.


Looked at all kernel options... If it is a timer problem --- ho can I find
out this?

Yours,

	Gunter.

On Today, Dmitry Torokhov wrote:

>From: Dmitry Torokhov <dtor_core@ameritech.net>
>Date: Sat, 10 Jan 2004 03:46:03 -0500
>To: Gunter Königsmann <gunter.koenigsmann@gmx.de>,
>     Gunter Königsmann <gunter@peterpall.de>
>Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
>     Andrew Morton <akpm@osdl.org>
>Subject: Re: [PATCH 2/2] Psmouse log and discard timed out bytes
>
>===================================================================
>
>
>ChangeSet@1.1513, 2004-01-10 02:52:04-05:00, dtor_core@ameritech.net
>  Input: psmouse - if keyboard controller reports a timeout or a parity error
>         do not try to process the byte, log the problem and drop it early.
>
>
> psmouse-base.c |    7 +++++++
> 1 files changed, 7 insertions(+)
>
>
>===================================================================
>
>
>
>diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
>--- a/drivers/input/mouse/psmouse-base.c	Sat Jan 10 03:23:08 2004
>+++ b/drivers/input/mouse/psmouse-base.c	Sat Jan 10 03:23:08 2004
>@@ -121,6 +121,13 @@
> 	if (psmouse->state == PSMOUSE_IGNORE)
> 		goto out;
>
>+	if (flags & (SERIO_PARITY|SERIO_TIMEOUT)) {
>+		printk(KERN_WARNING "psmouse.c: bad data from KBC -%s%s\n",
>+			flags & SERIO_TIMEOUT ? " timeout" : "",
>+			flags & SERIO_PARITY ? " bad parity" : "");
>+		goto out;
>+	}
>+
> 	if (psmouse->acking) {
> 		switch (data) {
> 			case PSMOUSE_RET_ACK:
>

-- 
The difference between common-sense and paranoia is that common-sense is
thinking everyone is out to get you.  That's normal -- they are.  Paranoia
is thinking that they're conspiring.
                -- J. Kegler
