Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319292AbSIKTEy>; Wed, 11 Sep 2002 15:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319293AbSIKTEy>; Wed, 11 Sep 2002 15:04:54 -0400
Received: from [143.166.83.88] ([143.166.83.88]:20742 "HELO
	AUSADMMSRR501.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S319292AbSIKTEx>; Wed, 11 Sep 2002 15:04:53 -0400
X-Server-Uuid: ff595059-9672-488a-bf38-b4dee96ef25b
Message-ID: <20BF5713E14D5B48AA289F72BD372D68C1E7FF@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: mochel@osdl.org, greg@kroah.com
cc: phillips@arcor.de, linux-kernel@vger.kernel.org
Subject: RE: [RFC][PATCH] x86 BIOS Enhanced Disk Device (EDD) polling
Date: Wed, 11 Sep 2002 14:09:32 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 11614B7B3806843-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The next logical extension would be to make a symlink 'disk' in each
> directory that points at the PCI 
> bus:dev.fn/scsiX/a:b:c:d:disk file for the
> appropriate disk.  However, I'm in a quandry...  There's no 
> simple way to do this.

Or is there? :-)

Patrick, in drivers/base/core.c, there's this concept of platform_notify()
and platform_notify_remove().  Could I exploit this to get callbacks to the
EDD code to create a symlink at that point?  These aren't exported to
modules ATM, and I could see how multiple things may want to use this hook -
so instead, how about notifier lists (ala reboot notifiers) that the EDD
code could register with, instead of a single entry?  As a list, modules
could add/remove themselves easily.

Then, one more request - giving back the ability to make a symlink given the
device, not just a name.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

