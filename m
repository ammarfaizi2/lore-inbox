Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263556AbTDDLDP (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 06:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263557AbTDDLDO (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 06:03:14 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:50646 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S263556AbTDDLC5 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 06:02:57 -0500
Date: Fri, 04 Apr 2003 23:12:02 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: New Software Suspend Patch for testing.
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Patrick Mochel <mochel@osdl.org>,
       Andrew Morton <akpm@digeo.com>
Message-id: <1049454721.2418.33.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

A new 2.5 port of the 2.4 version is available on
www.sourceforge.net/projects/swsusp. 

The changes from the last version are not huge; perhaps most significant
is that the dynamically allocated bitmaps (in place of pageflags) are
implemented. This won't mean anything to most people, but Andrew Morton,
Pavel and Patrick should be happy. Note for Patrick: The driver code was
using KERN_EMERGENCY to print when devices were suspended/resumed. Can
we lower this to INFO (I did something alone these lines in this patch).
It mucks up the nice display :>

Hopefully I'll soon find time to start bombarding Pavel, Patrick and
Linus with incremental patches for merging :>. In the meantime, please
give it a go.

Under 2.4, we use scripts that unload problematic drivers, switch to a
text console and so on before starting the process. Hopefully this will
end up being unneeded in 2.5 once the driver model is complete. In the
meantime, however (especially if you get problems!), you might like to
try first with a minimal load, and slowly add things. It does work fine
on my Omnibook XE3! YMMV.

Brief howto:
(Assuming you've applied the patch against 2.5.66 - other versions may
work too).
1. Patch, compile as normal.
2. Ensure your kernel commandline includes resume=/dev/hdaX where X is a
swap partition you will be using. More than one swap partition can be
used. This just specifies which will have its header used to indicate
that the system is suspended and where to find the data.
3. If you want debugging info: echo 1 20 15 31 > /proc/sys/kernel/swsusp
(See line 201ff of kernel/suspend.c for what the numbers mean).
4. echo 4 > /proc/acpi/sleep to start the process. 
The system should save the image and powerdown.
If you choose the debugging info, you'll have to press SHIFT at the end
of each step.
If you press SHIFT at other times, you can toggle this pausing on and
off.
Whether you selected the debugging info or not, you can press ALT to
cancel the process.
5. To resume, reboot with the same kernel. The image should be detected
and reloaded without you needing to do anything special. Pausing or not
is state-persistent from when you suspended.
6. You should (DV) get your system back to where it was when you started
the process.

Please report success/failure/questions on the swsusp mailing list. See
Florent's home page for details.

Regards,

Nigel


-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

