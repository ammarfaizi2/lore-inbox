Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWHLPYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWHLPYU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 11:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbWHLPYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 11:24:20 -0400
Received: from mail1.cenara.com ([193.111.152.3]:16339 "EHLO
	kingpin.cenara.com") by vger.kernel.org with ESMTP id S964892AbWHLPYT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 11:24:19 -0400
From: Magnus =?iso-8859-15?q?Vigerl=F6f?= <wigge@bigfoot.com>
To: linux-input@atrey.karlin.mff.cuni.cz
Subject: input: evdev.c EVIOCGRAB semantics question
Date: Sat, 12 Aug 2006 17:24:16 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200608121724.16119.wigge@bigfoot.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What is the purpose of the EVIOCGRAB ioctl in evdev.c? Is it to prevent the 
device driver from sending events to other event handlers? Is it to prevent 
other applications from receiving events that has the device handler open? 
First, last, or both?

I discovered the following behavior when I fired up a second X-server on my 
machine with my Wacom tablet connected: The second X-server opened the tablet 
as well and everything worked as it should. However when I switched back to 
the first X-server the tablet didn't work at all. Only when I stopped the 
second X-server did the tablet start working in the first X-server again. If 
I changed the code in evdev to ignore the EVIOCGRAB-ioctl the tablet works in 
both X-servers, but that caused other problems.

Now, having two X-servers might not be the most common thing to have, but 
having other applications that depends on the movement from the tablet might 
be more common.

As is it now, it's useless (more or less) to run wacdump to display the tablet 
specific events in a understandable manner. An application that generates 
events through uinput based on tablet events and some other qualifiers 
(mouseemu, simulating mouse scroll wheel) will not work either.

And yes, the X-server must grab the tablet. Otherwise events will go 
through /dev/input/mice as well and mess up applications that depend on the 
tablet-specific absolute events.

Thanks
 Magnus
