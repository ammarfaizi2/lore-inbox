Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbTIMVJH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 17:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbTIMVJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 17:09:07 -0400
Received: from adsl-67-124-157-90.dsl.pltn13.pacbell.net ([67.124.157.90]:2016
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S262191AbTIMVJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 17:09:04 -0400
Date: Sat, 13 Sep 2003 14:07:22 -0700
To: linux-kernel@vger.kernel.org
Cc: pavel@ucw.cz, mochel@osdl.org
Subject: Swsusp weirdness with ACPI
Message-ID: <20030913210722.GA264@anemic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few things to say about swsusp in 2.6.0-test5-mm1 on my Dell Smartstep
laptop.

Here is my /proc/acpi/sleep:
S0 S3 S4 S4bios S5

- 0 doesn't seem to do anything.
- 3 will ONLY 'suspend' my laptop if all my USB devices are disconnected
  and I have removed my PCMCIA cards.

  Furthermore, it won't resume. The fan will spin up, etc., but the LCD
  will not turn on.
- 4 nearly works. When it's suspending there will be an oops that flies
  by too quickly to read. It will turn off though, but when I reboot it,
  my swap partition will have been hosed:

  "Unable to find swap-space signature" when trying to swapon
  
  "PM: Reading swsusp image.
  swsusp: Resume From partition: hda7, Device: unknown-block(0,0)
  Resume Machine: Error -6 resuming
  PM: Resume from disk failed." when I try to resume.

  I have to mkswap it again for stuff to work.
- 4bios behaves the same way as 4.
- 5 doesn't do anything.

So overall swsusp on my laptop is fairly broken. Has anyone gotten it to
work on a similar laptop? Any possible fixes?

--
Joshua Kwan
