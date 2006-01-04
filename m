Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbWADRTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbWADRTL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWADRTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:19:10 -0500
Received: from mail01.fortunecookiestudios.com ([209.208.125.101]:25516 "EHLO
	mail01.fortunecookiestudios.com") by vger.kernel.org with ESMTP
	id S932553AbWADRTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:19:09 -0500
Message-ID: <43BC03EB.7070503@cfl.rr.com>
Date: Wed, 04 Jan 2006 12:20:43 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Forced umount doesn't force very hard
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that umount -f only bypasses the open files check, allowing 
you to unmount a volume with open files.  The kernel still tries to 
flush dirty buffers to the disk before unmounting.  This can be a 
serious problem in the case of an unreachable nfs server or a bad disk 
since the umount can block indefinitely while the kernel tries to flush 
buffers that can't be flushed.  This also causes your syslog to fill up 
very quickly with error messages.

I ran into this with a badly formatted cdrw disk I had mounted and all 
the writes were failing.  There was no way to force the kernel to 
abandon the mount and eject the disc.  The umount process couldn't even 
be killed with kill -9.  After maybe 15 minutes the kernel finally had 
tried and failed to flush all the buffers and completed the unmount, 
allowing me to eject the disc, but my syslog had grown to 50 MB from all 
the errors.

I think that the force option should not bother flushing dirty buffers, 
or maybe a new --i-really-mean-force-and-damn-the-dirty-buffers option 
is needed.

Please CC any thoughts/comments to me as I am not subscribed.

BTW, if anyone knows of somewhere you can download the ML archives, 
preferably in mbox format, I would greatly appreciate it.

