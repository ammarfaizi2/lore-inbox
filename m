Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264837AbTE1TJF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 15:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264839AbTE1TJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 15:09:05 -0400
Received: from devil.servak.biz ([209.124.81.2]:33172 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S264837AbTE1TJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 15:09:02 -0400
Subject: 2.5.70 explodes when connecting to SBP2 (firewire) storage
From: Torrey Hoffman <thoffman@arnor.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1054149723.1135.15.camel@torrey.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 May 2003 12:22:15 -0700
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This actually started happening sometime late in the 2.5.69-bk series, I
haven't tracked down exactly which bk snapshot introduced the problem.

Shortly after attempting to log into an SBP2 device, the system locks up
and a very very long trace dumps on the screen.  It pauses for a while
and then dumps more stack trace.

This happens either if SBP2 and firewire are compiled into the kernel or
as modules.  It does not happen if there is no firewire drive attached,
or the drive is powered down.  But in that case, plugging in or powering
up the drive after boot will trigger the crash as well.

The system is a boring, ordinary Pentium III, non-SMP, non-preempt, most
kernel debugging options turned on.


Nothing useful is saved in the system log. The last logged lines from my
attempt to boot 2.5.70-bk2 are:

May 28 11:26:00 torrey /sbin/hotplug: no runnable
/etc/hotplug/scsi_host.agent is installed
May 28 11:26:00 torrey /etc/hotplug/ieee1394.agent: ... no drivers for
IEEE1394 product 0x000000/0x00609e/0x010483
May 28 11:26:00 torrey kernel: scsi0 : SCSI emulation for IEEE-1394
SBP-2 Devices
May 28 11:26:00 torrey kernel: ieee1394: sbp2: Logged into SBP-2 device

(kaboom!  and then I reboot. )

Sorry I don't have a decoded oops.  I'll have to set up a serial console
I guess.

-- 
Torrey Hoffman <thoffman@arnor.net>

