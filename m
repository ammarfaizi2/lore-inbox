Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWEZH7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWEZH7s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 03:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWEZH7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 03:59:48 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.26]:62171 "EHLO smtp5.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1750964AbWEZH7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 03:59:47 -0400
X-ME-UUID: 20060526075945370.5A4EA1C00284@mwinf0509.wanadoo.fr
Subject: Re: OpenGL-based framebuffer concepts
From: Xavier Bestel <xavier.bestel@free.fr>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       Matheus Izvekov <mizvekov@gmail.com>, Jon Smirl <jonsmirl@gmail.com>,
       "D. Hazelton" <dhazelton@enter.net>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
In-Reply-To: <4476A8AA.1010106@aitel.hist.no>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <44700ACC.8070207@gmail.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>
	 <200605230048.14708.dhazelton@enter.net>
	 <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com>
	 <6896241F-3389-4B20-9E42-3CCDDBFDD312@mac.com>
	 <44740533.7040702@aitel.hist.no> <447465C6.3090501@ums.usu.ru>
	 <9e4733910605240749r1ce9e9fehcfffb2f2e3aeab60@mail.gmail.com>
	 <44747432.1090906@ums.usu.ru>
	 <305c16960605240915p7961ddbfye90afd3cf7fbc372@mail.gmail.com>
	 <4474891D.9010205@ums.usu.ru> <1148492064.16503.1.camel@bip.parateam.prv>
	 <4476A8AA.1010106@aitel.hist.no>
Content-Type: text/plain
Message-Id: <1148630374.1509.35.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Fri, 26 May 2006 09:59:34 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-26 at 09:05, Helge Hafting wrote:
> Xavier Bestel wrote:
> > Don't save the framebuffer. Just send a message to the client
> > application saying "fb is corrupted, please redraw". X11 can do it,
> > console can do it.
> >   
> Sure, X has no problem doing an expose event on the entire screen.
> But then the kernel would need a way to tell X that the display
> was invalidated outside its control.  Is there even an
> API for that today?
> 
> The problem isn't trivial, for the machine may be running
> quite a few xservers.  Or some other sort of software
> that uses the framebuffer.  (libsvga, y, berlin, ...)

I'd say send something simple (SIGWINCH?) to all apps opening fbdev, and
for legacy apps (e.g. current Xorg) use an userspace helper listening to
this signal and sending X (or Y or Berlin) an expose event (perhaps
after waiting for the proper input device, depending on some policy).

Otherwise I like much your other idea of allocating memory by freeing
non-dirty pages if possible, but that doesn't solve the problem that the
restoration of the previous state (or the expose event) has to wait for
user input or a timeout or something. That kind of decision belongs to
userspace.

	Xav


