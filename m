Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbTJOAsi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 20:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbTJOAsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 20:48:38 -0400
Received: from user-118bgnr.cable.mindspring.com ([66.133.194.251]:16000 "EHLO
	BL4ST") by vger.kernel.org with ESMTP id S261239AbTJOAsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 20:48:37 -0400
Date: Wed, 15 Oct 2003 00:48:37 +0000
From: Eric Wong <eric@yhbt.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: 4Front Technologies <dev@opensound.com>,
       Martin Josefsson <gandalf@wlug.westbo.se>, linux-kernel@vger.kernel.org
Subject: Re: mouse driver bug in 2.6.0-test7?
Message-ID: <20031015004837.GA444@BL4ST>
References: <3F8C3A99.6020106@opensound.com> <1066159113.12171.4.camel@tux.rsn.bth.se> <20031014193847.GA9112@ucw.cz> <3F8C56B3.1080504@opensound.com> <20031014201354.GA10458@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031014201354.GA10458@ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Tue, Oct 14, 2003 at 01:04:03PM -0700, 4Front Technologies wrote:
> > I'd recommend that you make the sample rate a module config option so that
> > users may be able to tweak this for their systems.
> 
> It already is. Only the code to make it a kernel command line parameter
> (when psmouse is compiled into the kernel) is missing.

I could've sworn I had this in one of the patches I sent you, but
perhaps not.

--- drivers/input/mouse/psmouse-base.c~	2003-10-13 06:13:52.000000000 +0000
+++ drivers/input/mouse/psmouse-base.c	2003-10-15 00:21:59.000000000 +0000
@@ -651,10 +651,17 @@
 	return 1;
 }
 
+static int __init psmouse_rate_setup(char *str)
+{
+	get_option(&str, &psmouse_rate);
+	return 1;
+}
+
 __setup("psmouse_noext", psmouse_noext_setup);
 __setup("psmouse_resolution=", psmouse_resolution_setup);
 __setup("psmouse_smartscroll=", psmouse_smartscroll_setup);
 __setup("psmouse_resetafter=", psmouse_resetafter_setup);
+__setup("psmouse_rate=", psmouse_rate_setup);
 
 #endif
 
-- 
Eric Wong
