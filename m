Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVAGDOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVAGDOp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 22:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVAGDOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 22:14:39 -0500
Received: from smtp.nuvox.net ([64.89.70.9]:34658 "EHLO
	smtp03.gnvlscdb.sys.nuvox.net") by vger.kernel.org with ESMTP
	id S261288AbVAGDMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 22:12:48 -0500
Subject: sr.c media_changed handling
From: Dan Dennedy <dan@dennedy.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 06 Jan 2005 22:00:20 -0500
Message-Id: <1105066820.5048.38.camel@kino.dennedy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am working with a PowerFile DVD jukebox (firewire/sbp2) on kernel
2.6.10, and it works quite well except for media change handling. The
problem is sr limits reads of subsequent discs to the capacity of the
first disc opened. If I remove the line "if (cd->needs_sector_size)"
from sr_open() and make it always get the capacity when a disc is
opened, then it resolves my issues. Alternatively, I can send a
CDROM_MEDIA_CHANGED ioctl when no disc is loaded to force a Read
Capacity request when the next disc is mounted and opened. I have
another, non-changer sbp2 disc drive that does not exhibit this problem.
Therefore, I have two questions:

1) How does a SCSI device that reports media-changed capable
(CDC_MEDIA_CHANGED) actually send that signal or flag? Does it come up
through block device operation media_changed, or is that just a means to
query the driver's current status?

2) I suspect there are other devices that have a similar flaw. What is
the harm in sending an inexpensive Read Capacity command each time a
disc is opened? IOW, removing that line from sr.c in bitkeeper. It seems
it would improve compatibility for less well-behaved devices with
little-to-no impact on the majority.

p.s. please include my address in the reply; I am not subscribed.


