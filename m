Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263186AbUCMUt6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 15:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbUCMUt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 15:49:58 -0500
Received: from wingding.demon.nl ([82.161.27.36]:7297 "EHLO wingding.demon.nl")
	by vger.kernel.org with ESMTP id S263186AbUCMUtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 15:49:55 -0500
Date: Sat, 13 Mar 2004 21:49:15 +0100
From: rutger@mail.com
To: linux-kernel@vger.kernel.org
Subject: [muPATCH] TUN/TAP sysfs fix
Message-ID: <20040313204915.GB27653@mail.com>
Reply-To: linux-kernel@tux.tmfweb.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: M38c
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Using Gentoo2004.0 with udev (with /dev on ramfs) gives most devices
from sysfs. However, TUN/TAP is not listed. Digging into it further
revealed the error:

# ls /sys/class/misc
agpgart  hw_random  net/tun  psaux  rtc
 # ls -l /sys/class/misc
ls: /sys/class/misc/net/tun: No such file or directory
total 0
drwxr-xr-x    2 root     root            0 Mar 13 18:43 agpgart
...

A file with a '/' embedded.

Suggestion: change name from 'net/tun' to 'net_tun', to be as
unobtrusive as possible, which lets met use /dev/net_tun (using the
Unix ASCII to filename conversion convention ;)

The correct solution might be to change sysfs into auto-creating
directories for .names with embedded slashes, but that's outside the
scope of this quick make-it-work-again hack...

*** linux-2.6/drivers/net/tun.c~	Sat Mar 13 20:20:17 2004
--- linux-2.6/drivers/net/tun.c	Sat Mar 13 20:20:57 2004
***************
*** 602,608 ****
  
  static struct miscdevice tun_miscdev = {
  	.minor = TUN_MINOR,
! 	.name = "net/tun",
  	.fops = &tun_fops
  };
  
--- 602,608 ----
  
  static struct miscdevice tun_miscdev = {
  	.minor = TUN_MINOR,
! 	.name = "net_tun",
  	.fops = &tun_fops
  };
  

-- 
Rutger Nijlunsing ---------------------------- rutger ed tux tmfweb nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
