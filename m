Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUAJWEQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 17:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265488AbUAJWEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 17:04:15 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:5598 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265477AbUAJWEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 17:04:05 -0500
Date: Sat, 10 Jan 2004 23:05:23 +0100 (CET)
From: =?ISO-8859-1?Q?Gunter_K=F6nigsmann?= <gunter@peterpall.de>
Reply-To: =?ISO-8859-1?Q?Gunter_K=F6nigsmann?= <gunter.koenigsmann@gmx.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: Gunter =?iso-8859-1?q?K=F6nigsmann?= <gunter@peterpall.de>,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] Synaptics rate switching
In-Reply-To: <200401100345.17211.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.53.0401102241130.1980@calcula.uni-erlangen.de>
References: <Pine.LNX.4.53.0401091101170.1050@calcula.uni-erlangen.de>
 <200401100344.03758.dtor_core@ameritech.net> <200401100345.17211.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:6f0b4d165b4faec4675b8267e0f72da4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tried it. Doesn't change a thing. Means: I get about half the number of
warning messages, but that just corresponds to half the number of packets.


What helps a lot, but not to 100% (get bad keypresses anyway) is
totally deactivating the ACPI. Killing all processes that access /proc/acpi
seems again to help a bit.

And The number of Warnings seemingly increases with the labtop
temperature... In a really cold room I get nearly no warnings at all.
Jitter? Hardware, that is simply broken?


Anyway, --- with Dmitrys patches I get hardly ever little bad events, just
warnings --- and --- well... I can live with them,


	Gunter.








On Today, Dmitry Torokhov wrote:

>From: Dmitry Torokhov <dtor_core@ameritech.net>
>Date: Sat, 10 Jan 2004 03:45:13 -0500
>To: Gunter Königsmann <gunter.koenigsmann@gmx.de>,
>     Gunter Königsmann <gunter@peterpall.de>
>Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
>     Andrew Morton <akpm@osdl.org>
>Subject: [PATCH 1/2] Synaptics rate switching
>
>===================================================================
>
>
>ChangeSet@1.1512, 2004-01-10 02:42:42-05:00, dtor_core@ameritech.net
>  Input: Allow switching between high and low reporting rate for Synaptics
>         touchpads in native mode. Synaptics support 2 report rates - 40
>         and 80 packets/sec; report rate must be set using Synaptics mode
>         set command. Rate is controlled by psmouse.rate parameter, values
>         greater or equal 80 will set 'high' rate. (psmouse.rate defaults
>         to 100)
>
>         Using low report rate should help slower systems or systems
>         spending too much time in SCI (ACPI).
>
>
> psmouse.h   |    1 +
> synaptics.c |    4 +++-
> 2 files changed, 4 insertions(+), 1 deletion(-)
>
>
>===================================================================
>
>
>
>diff -Nru a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
>--- a/drivers/input/mouse/psmouse.h	Sat Jan 10 03:22:26 2004
>+++ b/drivers/input/mouse/psmouse.h	Sat Jan 10 03:22:26 2004
>@@ -67,6 +67,7 @@
> int psmouse_command(struct psmouse *psmouse, unsigned char *param, int command);
>
> extern int psmouse_smartscroll;
>+extern unsigned int psmouse_rate;
> extern unsigned int psmouse_resetafter;
>
> #endif /* _PSMOUSE_H */
>diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
>--- a/drivers/input/mouse/synaptics.c	Sat Jan 10 03:22:26 2004
>+++ b/drivers/input/mouse/synaptics.c	Sat Jan 10 03:22:26 2004
>@@ -214,7 +214,9 @@
> {
> 	struct synaptics_data *priv = psmouse->private;
>
>-	mode |= SYN_BIT_ABSOLUTE_MODE | SYN_BIT_HIGH_RATE;
>+	mode |= SYN_BIT_ABSOLUTE_MODE;
>+	if (psmouse_rate >= 80)
>+		mode |= SYN_BIT_HIGH_RATE;
> 	if (SYN_ID_MAJOR(priv->identity) >= 4)
> 		mode |= SYN_BIT_DISABLE_GESTURE;
> 	if (SYN_CAP_EXTENDED(priv->capabilities))
>

-- 
The best ways are the most straightforward ways.  When you're sitting around
scamming these things out, all kinds of James Bondian ideas come forth, but
when it gets down to the reality of it, the simplest and most straightforward
way is usually the best, and the way that attracts the least attention.
Also, pouring gasoline on the water and lighting it like James Bond doesn't
work either.... They tried it during Prohibition.
                -- Thomas King Forcade, marijuana smuggler
