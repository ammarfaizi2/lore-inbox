Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbTHYWlA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 18:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbTHYWlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 18:41:00 -0400
Received: from gate.firmix.at ([80.109.18.208]:43969 "EHLO buffy.firmix.at")
	by vger.kernel.org with ESMTP id S262391AbTHYWk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 18:40:57 -0400
Subject: Re: [PATCH] 2.6.0-test4: Trivial /sys/power/state patch, sleep
	status report
From: Bernd Petrovitsch <bernd@firmix.at>
To: "P. Christeas" <p_christ@hol.gr>
Cc: acpi-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200308260125.30194.p_christ@hol.gr>
References: <200308260125.30194.p_christ@hol.gr>
Content-Type: multipart/mixed; boundary="=-ykqYJFslnnQ6Pcgb/vDd"
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 26 Aug 2003 00:40:18 +0200
Message-Id: <1061851218.12331.23.camel@gimli.at.home>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ykqYJFslnnQ6Pcgb/vDd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2003-08-26 at 00:25, P. Christeas wrote:
> Just found out that by 'echo sth_wrong > /sys/power/state' the kernel would 
> oops in a fatal way (no clean exit from there).
> The oops suggested that the code would enter an invalid fn.
> 
> You may apply the included patch to solve the bug. IMHO doing a clean exit is 
> much preferrable than having BUG() there.
[...]
> ----
[...]
> diff -Bbur /diskb/users/panos/linux-off/kernel/power/main.c /usr/src/linux/kernel/power/main.c
> --- /diskb/users/panos/linux-off/kernel/power/main.c	2003-08-23 12:13:17.000000000 +0300
> +++ /usr/src/linux/kernel/power/main.c	2003-08-26 00:59:34.000000000 +0300
> @@ -500,7 +514,7 @@
>  		if (s->name && !strcmp(buf,s->name))
>  			break;
>  	}
> -	if (s)
> +	if ( (s) && (state < PM_SUSPEND_MAX) )
>  		error = enter_state(state);
>  	else
>  		error = -EINVAL;

What do you think about the attached patch to solve the bug and remove a
warning?

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

--=-ykqYJFslnnQ6Pcgb/vDd
Content-Disposition: attachment; filename=power-main.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=power-main.patch; charset=ISO-8859-1

--- linux-2.6.0-test4/kernel/power/main.c	Sat Aug 23 01:53:13 2003
+++ linux-2.6.0-test4-patched/kernel/power/main.c	Mon Aug 25 21:16:50 2003
@@ -492,7 +492,7 @@
 static ssize_t state_store(struct subsystem * subsys, const char * buf, si=
ze_t n)
 {
 	u32 state;
-	struct pm_state * s;
+	struct pm_state * s =3D NULL;
 	int error;
=20
 	for (state =3D 0; state < PM_SUSPEND_MAX; state++) {

--=-ykqYJFslnnQ6Pcgb/vDd--

