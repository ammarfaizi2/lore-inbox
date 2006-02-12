Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWBLQ50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWBLQ50 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 11:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWBLQ50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 11:57:26 -0500
Received: from mx1.rowland.org ([192.131.102.7]:51976 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1751149AbWBLQ50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 11:57:26 -0500
Date: Sun, 12 Feb 2006 11:57:21 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Kyle Moffett <mrmacman_g4@mac.com>, Alon Bar-Lev <alon.barlev@gmail.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
Message-ID: <Pine.LNX.4.44L0.0602121147040.9971-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both of you are missing an important difference between Suspend-to-RAM and 
Suspend-to-Disk.

Suspend-to-RAM is a true suspend operation, in that the hardware's state
is maintained _in the hardware_.  External buses like USB will retain
suspend power, for instance (assuming the motherboard supports it; some
don't).

Suspend-to-Disk, by contrast, is _not_ a true suspend.  It can more 
accurately be described as checkpoint-and-turn-off.  Hardware state is not 
maintained.  (Some systems may support a special ACPI state that does 
maintain suspend power to external buses during shutdown, I forget what 
it's called.  And I down't know whether swsusp uses this state.)

So for example, let's say you have a filesystem mounted on a USB flash or
disk drive.  With Suspend-to-RAM, there's a very good chance that the
connection and filesystem will still be intact when you resume.  With
Suspend-to-Disk, the USB connection will terminate when the computer shuts
down.  When you resume, the device will be gone and your filesystem will
be screwed.

Alan Stern

