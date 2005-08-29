Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbVH2A2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbVH2A2E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 20:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbVH2A2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 20:28:04 -0400
Received: from cavan.codon.org.uk ([217.147.81.22]:13186 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S1751007AbVH2A2D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 20:28:03 -0400
Date: Mon, 29 Aug 2005 01:26:52 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: pavel@ucw.cz
Cc: linux-kernel@vger.kernel.org
Subject: swsusp console change/userspace hang
Message-ID: <20050829002652.GA23582@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on cavan.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm currently working on an entirely userspace bootsplash program. It 
works quite happily, except in the case of resuming from hibernation. 
The splash program is launched at the start of initramfs, and at the 
end of initramfs (after the disk modules have been loaded) we attempt to 
trigger resume from userspace.

The code registers a signal that's fired on VT change. If a console
change is requested when it's currently drawing, it disables drawing and
schedules an alarm to fire 0.1 seconds later in order to avoid switching
the console when part-way through a framebuffer operation.

The problem seems to be that swsusp tries to change the console and then 
immediately freezes userspace. For reasons I don't entirely understand, 
this freezes the machine. If I remove the pm_prepare_console call from 
pm_prepare_processes, resume functions correctly.

For now I'll probably just work around this by removing the console 
change from our kernels (we can do that in userspace scripting instead), 
but this still seems to be a less than ideal situation - I'm guessing 
that the same would happen if we were displaying the splash on suspend. 
Any ideas what might be causing this, and how to rectify it?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
