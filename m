Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267495AbTA3Loc>; Thu, 30 Jan 2003 06:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267496AbTA3Loc>; Thu, 30 Jan 2003 06:44:32 -0500
Received: from mx9.mail.ru ([194.67.57.19]:13830 "EHLO mx9.mail.ru")
	by vger.kernel.org with ESMTP id <S267495AbTA3Lob>;
	Thu, 30 Jan 2003 06:44:31 -0500
From: "Andrey Borzenkov" <arvidjaar@mail.ru>
To: "Steven Dake" <sdake@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New model for managing dev_t's for partitionable block devices
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Thu, 30 Jan 2003 14:53:44 +0300
Reply-To: "Andrey Borzenkov" <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E18eDGK-0002cr-00@f17.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a problem with hotswap of course, and shouldn't be solved
> by the kernel putting the same device always in the same
> major/minor.  A userspace application should query the OS and build
> the device nodes based upon scsi serial number, FC port WWN, or
> access path (host/channel/id/lun).  The current "MAKEDEV" works
> fine for people with and ide disk and cdrom, but for real systems
> with lots of disks and hotswap capabilities, static naming just
> doesn't work (as you have said).  :)  Devfs solves the naming
> problem by using access path automatically within the OS.  Downside
> of this methodology is that access permissions are not persistent
> between reboots (which is one significant limitation of devfs).


Are you aware of devfsd? It keeps permissions for you across reboots,
and does it just fine.

The real limitation in this case is SCSI host numbers. There is no
way to permanently assign logical controller numbers like it happens
in other systems. add or remove another SCSI adapter and all your
names are shifted.

which is true for any adapter not just SCSI.

-andrey
