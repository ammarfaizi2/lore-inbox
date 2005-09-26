Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751517AbVIYP3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbVIYP3P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 11:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbVIYP3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 11:29:15 -0400
Received: from smtp02.syd.iprimus.net.au ([210.50.76.196]:33804 "EHLO
	smtp02.syd.iprimus.net.au") by vger.kernel.org with ESMTP
	id S1751515AbVIYP3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 11:29:15 -0400
From: "John O'Hagan" <johnohagan@iprimus.com.au>
To: linux-kernel@vger.kernel.org
Subject: S3 Suspend input devices problem with 2.6.12
Date: Mon, 26 Sep 2005 11:33:20 +1000
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509261133.23513.johnohagan@iprimus.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've been trying to figure out if this is a kernel related problem...the folks 
on other lists are divided, so I guess I'll just ask & hope:
 
I'm running Debian testing on a "whitebox" (unbranded) Centrino laptop with a 
855GM chipset. Since kernel 2.6.12, suspend-to-disk (S4) has worked well, 
simply using the KDE klaptop applet.

However, suspend-to-ram (S3), which I think most laptop users find very 
useful, has proved more difficult. If I simply use the KDE applet or the 
regular command, the system resumes with a blank screen - a common problem 
with this chipset. I can get around it using vbetool, which reinitialises the 
graphics device (there is a handy packaged script called hibernate which 
walks you through this); however, the touchpad does not work on resume. 
Lately, as I have fiddled with the hibernate settings,  neither does the 
keyboard.

Some digging has revealed that somehow the entries in /proc/bus/input have 
been shuffled around on resuming, so that the device node once used by the 
touchpad (/dev/input/event1) is now handled by the pc-speaker, or the 
(non-existent) joystick, or is absent altogether! Leaving the touchpad out in 
the cold...regardless of which touchpad driver I use. Reloading the relevant 
modules - or even all modules - has no effect.

So, my questions are: why does S3 suspend (and not S4) shuffle the devices 
around, and how can it be prevented? I notice that the keyboard and touchpad 
are initialized early in the boot process. Is udev involved? Or is there a 
better solution?

Thanks,

John O'Hagan

P.S. please CC me
