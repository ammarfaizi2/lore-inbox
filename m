Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbTABCpm>; Wed, 1 Jan 2003 21:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbTABCpm>; Wed, 1 Jan 2003 21:45:42 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:54208 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S265446AbTABCpk>; Wed, 1 Jan 2003 21:45:40 -0500
Date: Thu, 2 Jan 2003 03:54:01 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: observations on 2.5 config screens
Message-ID: <20030102025401.GI17053@louise.pinerecords.com>
References: <20030101200717.GA17053@louise.pinerecords.com> <Pine.LNX.4.33L2.0301011750010.21149-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0301011750010.21149-100000@dragon.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [rddunlap@osdl.org]
> 
> On Wed, 1 Jan 2003, Tomas Szepe wrote:
> 
> [snippage]
> | >     It seems that the final option, "Preemptible kernel", does
> | >   not belong there.  In fact, there seem to be a number of
> | >   kernel-related, kind of hacking/debugging options, that
> | >   could be collected in one place, like preemption, sysctl,
> | >   hacking, executable file formats, etc.  "Low-level kernel
> | >   options", perhaps?
> 
> So long as they come after the processor selection or whatever
> dependencies they have.

No longer an issue, see below.

> ...
>
> | > Multimedia devices
> | >
> | >     How come "Sound" is not here?  And (as we've already
> | >   established), Radio Adapters is not a sub-entry of Video for
> | >   Linux. :-)  (And is there a reason why Amateur Radio Support
> | >   and Radio Adapters are so far apart in the config menus?
> 
> I agree.
> 
> Greg Banks has (had) a real nice program for checking
> dependency ordering using Config.in files.  It would be
> very nice if it now worked with Kconfig files.  :)

Forward references work nicely with the new configurator,
see for yourself (patch against 2.5.53):

diff -urN a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig	2002-12-16 07:02:05.000000000 +0100
+++ b/init/Kconfig	2003-01-02 03:49:02.000000000 +0100
@@ -1,6 +1,10 @@
 
 menu "Code maturity level options"
 
+config HRM0PS
+	depends on HRMOPS_PREREQUISITE
+	bool "This proves that forward-referenced symbols work just fine"
+
 config EXPERIMENTAL
 	bool "Prompt for development and/or incomplete code/drivers"
 	---help---
diff -urN a/net/Kconfig b/net/Kconfig
--- a/net/Kconfig	2002-12-08 20:06:41.000000000 +0100
+++ b/net/Kconfig	2003-01-02 03:49:44.000000000 +0100
@@ -5,6 +5,9 @@
 menu "Networking options"
 	depends on NET
 
+config HRMOPS_PREREQUISITE
+	bool "Switch this on for some serious HRM0PS!!"
+
 config PACKET
 	tristate "Packet socket"
 	---help---

-- 
Tomas Szepe <szepe@pinerecords.com>
