Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUDCWPi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 17:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbUDCWPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 17:15:38 -0500
Received: from [80.72.36.106] ([80.72.36.106]:58564 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S261991AbUDCWPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 17:15:36 -0500
Date: Sun, 4 Apr 2004 00:15:31 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.[45]-.*: weird behavior
In-Reply-To: <200404032314.27866.rjwysocki@sisk.pl>
Message-ID: <Pine.LNX.4.58.0404032341450.18910@alpha.polcom.net>
References: <200404032122.54823.rjwysocki@sisk.pl>
 <Pine.LNX.4.58.0404032135230.15963@alpha.polcom.net> <200404032314.27866.rjwysocki@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Apr 2004, R. J. Wysocki wrote:

> On Saturday 03 of April 2004 21:50, Grzegorz Kulewski wrote:
> > On Sat, 3 Apr 2004, R. J. Wysocki wrote:
> [...]
> > Can you attach config files for both the AMD64 and the laptop?
> 
> The config for the laptop is attached, the other one must wait.  If you think 
> of what they have in common, there's not much.

Ok, some questions to that config file. Why do you have:
- scsi emulation
- scsi
- both generic ide options
- large block devices (2TB)?

Can you post:
- distro name and version
- dmesg or log at the end of testing - better after such kb lock if you 
can reproduce, maybe after some stressing to see if any unnormal messages 
appeared
- lspci -v
- lsmod
- mount
- hdparm hdparm -iIvtT for all drives
- some files from /proc describing configuration if you think they are 
important.

Does any process sleep in D state in ps output all the time or bechaves 
strangely? If so, maybe you should find and apply the patch for kernel 
stack for each process in /proc (it was included in wolk for example) and 
check what kernel function is causing the waits (for example I found some 
usb problems causing D state lock of processes using some usb ioctls).

If it all does not help, maybe you should compile kernel with all debug 
and kernel hacking options to see if some driver does not lock the kernel 
and sleep or something like that, or possibly try to find what changeset 
between 2.6.3 and 2.6.4 broke your setup :)


good luck

Grzegorz Kulewski

