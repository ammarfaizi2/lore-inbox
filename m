Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbTKELDi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 06:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbTKELDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 06:03:38 -0500
Received: from mail4.dada.it ([195.110.100.4]:26382 "HELO mail.dada.it")
	by vger.kernel.org with SMTP id S262797AbTKELDe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 06:03:34 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mouse problem on 2.6.0-test9-bk9
Date: Wed, 5 Nov 2003 12:03:28 +0100
User-Agent: KMail/1.5.4
References: <1068024630.15471.26.camel@localhost.localdomain>
In-Reply-To: <1068024630.15471.26.camel@localhost.localdomain>
Cc: Bob Gill <gillb4@telusplanet.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200311051203.28206.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 10:30, mercoledì 5 novembre 2003, Bob Gill ha scritto:
> The problem is that my mouse became slow.  It was very
> fast in 2.6.0-test9, but with bk9 it became very slow (4 edge-to-edge
> drags across the mouse pad to go across the screen).  "xset m 9 1"
> works, but I am at times unable to resize windows (the mouse is skipping
> over the edge of the window).  Option "Resolution" "250" in Section
> "InputDevice" of XF86Config and restarting the X server does not work
> either (nor does substituting for 250 : 15, 100, 500, 2000, 15000).
> It's a minor thing, but it would be nice to change the mouse speed
> again.

The same here, using /dev/psaux; I tried it too, changing resolution in Xfree 
4.3, without success.

I don't know if this is a small bug or now there is a different way to set 
mouse resolutions, but the default behaviour is changed.

Maybe the relevant change is this, test9-bk4 IIRC:
file: drivers/input/mouse/psmouse-base.c  

@@ -471,13 +471,16 @@
  * We set the mouse report rate.
  */
-        psmouse_set_rate(psmouse);
+        if (psmouse_rate)
+                psmouse_set_rate(psmouse);

 /*
  * We also set the resolution and scaling.
  */

-        psmouse_set_resolution(psmouse);
+        if (psmouse_resolution)
+                psmouse_set_resolution(psmouse);
+
         psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11);
 
 /*

-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.


