Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268070AbTBRWXo>; Tue, 18 Feb 2003 17:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268066AbTBRWXo>; Tue, 18 Feb 2003 17:23:44 -0500
Received: from pop016pub.verizon.net ([206.46.170.173]:5112 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP
	id <S268070AbTBRWXl>; Tue, 18 Feb 2003 17:23:41 -0500
Message-ID: <3E52B4CE.7040009@verizon.net>
Date: Tue, 18 Feb 2003 17:33:50 -0500
From: Stephen Wille Padnos <stephen.willepadnos@verizon.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: a really annoying feature of the config menu structure
References: <Pine.LNX.4.44.0302181604310.23007-100000@dell>
In-Reply-To: <Pine.LNX.4.44.0302181604310.23007-100000@dell>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at pop016.verizon.net from [64.223.82.122] at Tue, 18 Feb 2003 16:33:38 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]

>  as i see it, this can only get worse.  the current
>erratic and disorganized structure of the config menus
>is proof of that.
>
>  comments?
>

I think the problem with the "Multimedia" menu is that it's misnamed.  
It should actually be the "tuners" menu - it's there for audio, digital 
video, and video tuners.  The same could be said of the networking menu, 
and presumably others.

You can actually reorganize things simply by changing the structure of 
the top-level Kconfig file.  With the following patches, I reorganized 
the multimedia options into the form that you are probably looking for.  
(hopefully they won't be mangled by my mailer)

With not too much rewriting (many small changes, I think), the menus can 
be organized much better.

Essentially, each subdirectory has a Kconfig file that does _not_ 
declare itself a standalone menu.  This allows a parent to decide 
whether or not to include it in another menu.  The menu should only have 
options that pertain to things in its' directory.  ie, the Kconfig file 
in drivers/net should not include "Networking" as an option - that is a 
higher level decision (ie, it decides whether or not to include the 
drivers/net config file).

Then, the Kconfig files from various subdirectories can be ordered in 
whatever way makes sense from a user's point of view

--- drivers/media/Kconfig.orig        2003-02-18 17:15:46.000000000 -0500
+++ drivers/media/Kconfig.new 2003-02-18 17:25:27.000000000 -0500
@@ -2,8 +2,6 @@
 # Multimedia device configuration
 #

-menu "Multimedia devices"
-
 config VIDEO_DEV
        tristate "Video For Linux"
        ---help---
@@ -32,5 +30,4 @@

 source "drivers/media/dvb/Kconfig"

-endmenu

--- arch/i386/Kconfig.orig        2003-02-18 17:17:49.000000000 -0500
+++ arch/i386/Kconfig     2003-02-18 17:18:32.000000000 -0500
@@ -1529,14 +1529,13 @@

 source "drivers/char/Kconfig"

-#source drivers/misc/Config.in
-source "drivers/media/Kconfig"
-
 source "fs/Kconfig"

 source "drivers/video/Kconfig"

-menu "Sound"
+#source drivers/misc/Config.in
+menu "MultiMedia (tuners, sound, video"
+source "drivers/media/Kconfig"

 config SOUND
        tristate "Sound card support"


