Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262798AbSJLELm>; Sat, 12 Oct 2002 00:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262827AbSJLELm>; Sat, 12 Oct 2002 00:11:42 -0400
Received: from air-2.osdl.org ([65.172.181.6]:40085 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262798AbSJLELi>;
	Sat, 12 Oct 2002 00:11:38 -0400
Date: Fri, 11 Oct 2002 21:15:45 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Steven Dake <scd@broked.org>
cc: <linux-kernel@vger.kernel.org>, <linux1394-devel@lists.sourceforge.net>
Subject: RE: [PATCH] [RFC] Advanced TCA Disk Hotswap support in Linux Kernel
 [core 1/2]
In-Reply-To: <002901c27143$53cb5fe0$0200000a@persist>
Message-ID: <Pine.LNX.4.33L2.0210112034340.9200-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2002, Steven Dake wrote:

| > On Thu, 10 Oct 2002, Steven Dake wrote:
| >
| > | I am developing the Linux kernel support required to support
| Advanced
| > | TCA
| > | (PICMG 3.0) architecture.  Advanced TCA is a technology where boards
| > | exist
| > | in a chassis and can either be processor nodes or storage nodes.
| All
| > | blades in the chassis are connected by FibreChannel and Ethernet.
| The
| > | blades can be hot added or hot removed while the Linux processor
| nodes
| > | are
| > | active, meaning that the SCSI subsystem must add devices on
| insertion
| > | requests and remove devices on ejection requests.
| > |
| > | The following is the first public patch that I am posting that adds
| > | support
| > | for SCSI and FibreChannel hotswap via a programmatic kernel
| interface,
| > | as well as userland access via ioctls.
| >
| > Thanks for letting us know about it.
| > Does this project have a web page?
|
| I will post a sourceforge project later today if I have a chance.  My
| mailer
| Is broken and is reformatting patches and its easier just to post a
| link.

Yeah.  :)

| > | The second patch is a FibreChannel driver that is modified to
| support
| > | SCSI hotswap.
| > |
| > | This mechanism is far superior to /proc/scsi/scsi because it:
| > | 1) provides true FibreChannel hotswap support (at this point qlogic
| FC
| > | HBAs)
| > | 2) is programmatic such that errors can be reported from kernel to
| user
| > |    without looking is /var/log/.
| >
| > so where does someone look for errors?
|
| Someone would use return codes, as defined by errno.h to understand how
| An error occurred.  Things are ENOMEM, ENOENT, etc that describe the
| exact
| Error.  The previous mechanism required looking in /var/log to see if
| the Command was completed.

Aha, "user" is software, not a humanoid.  I see now.

| > | 3) Provides superior response times vs opening a file and writing to
| > | proc.

Does the software doing this still have to open a file
and execute an ioctl?
Instead of opening a proc file and writing to it?

| > | 4) Easier to control from kernel and user via C APIs vs using
| > | open/write.
| >
| > Does this suggest adding yet another hotswap/hotplug mechanism
| > to Linux?  It would be a good thing to unify them IMHO.
|
| I am not suggesting adding yet another PCI hotplug mechanism.  What I am
| suggesting is adding a SCSI Device hotswap mechanism.  The current
| technique
| is currently unsupported (emails to the author bounce) and lacking in
| several

which one are you talking about?

| key areas.  I'd prefer to just remove the /proc/scsi/scsi proc
| interface,
| but I'm sure that would raise the ire of users everywhere and will let
| someone else fight the cleanup battle. :)

Agreed.

| > Does this hotswap mechanism require userspace software to activate it?
| > If so, is it available or being developed also?
|
| The interfaces for hotswap are available from both kernel and via an
| IOCTL
| interface to userspace.  I've also implemented shell commands to support
| hotswap for those users that wish to script the commands.
|
| As a side note, I see you are involved in OSDL.  These patches are
| already part of the OSDL CGLE trees.

So they are.
There are many things hidden in the CGL diff against plain vanilla
2.4.18, totaling around 9 MB and 288K lines.
I haven't looked at all of it yet.  :(

-- 
~Randy
  "In general, avoiding problems is better than solving them."
  -- from "#ifdef Considered Harmful", Spencer & Collyer, USENIX 1992.

