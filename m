Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270530AbTGVJgN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 05:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270625AbTGVJgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 05:36:13 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:6923 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S270530AbTGVJgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 05:36:08 -0400
Date: Tue, 22 Jul 2003 11:50:47 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Samuel Flory <sflory@rackable.com>
cc: Charles Lepple <clepple@ghz.cc>, michaelm <admin@www0.org>,
       <linux-kernel@vger.kernel.org>, <vojtech@suse.cz>
Subject: Re: Make menuconfig broken
In-Reply-To: <3F1C888B.8040500@rackable.com>
Message-ID: <Pine.LNX.4.44.0307221146120.714-100000@serv>
References: <20030721163517.GA597@www0.org> <32425.216.12.38.216.1058806931.squirrel@www.ghz.cc>
 <3F1C8739.2030707@rackable.com> <3F1C888B.8040500@rackable.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 21 Jul 2003, Samuel Flory wrote:

>   Try this in 2.6.0-test1:
> rm .config
> make mrproper
> make menuconfig
> 
>   There is no option for CONFIG_VT, and CONFIG_VT_CONSOLE under 
> character devices in "make menuconfig.

Try enabling CONFIG_INPUT.

Vojtech, how about the patch below? This way CONFIG_VT isn't hidden behind 
CONFIG_INPUT, but CONFIG_INPUT is selected if needed.

Index: drivers/char/Kconfig
===================================================================
RCS file: /home/other/cvs/linux/linux-2.6/drivers/char/Kconfig,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 Kconfig
--- drivers/char/Kconfig	14 Jul 2003 09:22:00 -0000	1.1.1.1
+++ drivers/char/Kconfig	22 Jul 2003 08:08:26 -0000
@@ -6,7 +6,7 @@ menu "Character devices"
 
 config VT
 	bool "Virtual terminal"
-	requires INPUT=y
+	select INPUT
 	---help---
 	  If you say Y here, you will get support for terminal devices with
 	  display and keyboard devices. These are called "virtual" because you

