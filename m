Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274244AbRJNE5N>; Sun, 14 Oct 2001 00:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274248AbRJNE5E>; Sun, 14 Oct 2001 00:57:04 -0400
Received: from gear.torque.net ([204.138.244.1]:53771 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S274244AbRJNE4v>;
	Sun, 14 Oct 2001 00:56:51 -0400
Message-ID: <3BC919DE.7E3C9F23@torque.net>
Date: Sun, 14 Oct 2001 00:51:42 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Bigot <linuxopinion@yahoo.com>, linux-kernel@vger.kernel.org
CC: linux-scsi@vger.kernel.org
Subject: Re: SCSI driver query
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Bigot <linuxopinion@yahoo.com> wrote:

> How is the ioctl() entry point in Scsi_Host_Template
> used. What device node is associated with it and what
> all commands can be passed down through this
> interface.

That ioctl can be accessed (if defined) via a "trickle
down" ioctl call to any open SCSI device name (e.g. /dev/sda).

When an ioctl is called on an open SCSI device name
then the first match in the following list processes
it:
   - the associated upper level SCSI driver looks for 
     a match on the ioctl 'cmd' number
   - the mid-level looks for a match on the ioctl
     'cmd' number
   - otherwise if Scsi_Host_Template::ioctl is non-NULL
     then it is called for the given SCSI device with
     the 'cmd' and 'arg' of the original user ioctl call

A SCSI lower level (adapter) driver is not required to
support Scsi_Host_Template::ioctl in which case it will
be NULL. If it is supported then it is up to that adapter
driver what is supported.


This mechanism only allows an adapter which has attached 
SCSI devices to be sent an ioctl. The proc_fs interface
may be useful for contacting an adapter driver even if it
doesn't have any attached devices. Something like:
 $ echo "<some_command>" > /proc/scsi/advansys/0


Doug Gilbert
