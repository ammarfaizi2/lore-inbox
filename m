Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266142AbUALLN3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 06:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266145AbUALLN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 06:13:29 -0500
Received: from [212.239.225.130] ([212.239.225.130]:43648 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S266142AbUALLN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 06:13:28 -0500
From: Jan De Luyck <lkml@kcore.org>
To: Bart Samwel <bart@samwel.tk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
Date: Mon, 12 Jan 2004 12:12:44 +0100
User-Agent: KMail/1.5.4
Cc: Dax Kelson <dax@gurulabs.com>, Kiko Piris <kernel@pirispons.net>,
       Bartek Kania <mrbk@gnarf.org>, Simon Mackinlay <smackinlay@mail.com>
References: <3FFFD61C.7070706@samwel.tk>
In-Reply-To: <3FFFD61C.7070706@samwel.tk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401121212.44902.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 January 2004 11:38, Bart Samwel wrote:
> I've created a new version of the laptop-mode patch, this time against
> linux 2.6.1. It can be found here:
>
> http://www.liacs.nl/~bsamwel/laptop_mode/laptop-mode-2.6.1-7.patch

Patch applied, kernel built, laptop_mode activated, but my disk just doesn't 
want to spin down... 

I have to activate it using ACPI BATT events, since my machine does not send 
out ACAD events. This is in /var/log/acpid:

[Mon Jan 12 11:26:18 2004] received event "battery BAT2 00000080 00000000"
[Mon Jan 12 11:26:18 2004] executing action "/etc/acpi/battery.sh"
[Mon Jan 12 11:26:18 2004] BEGIN HANDLER MESSAGES
Setting HD spindown to 20 seconds
Starting laptop_mode.

/dev/hda:
 setting Advanced Power Management level to 0x01 (1)
 setting standby to 4 (20 seconds)
[Mon Jan 12 11:26:18 2004] END HANDLER MESSAGES
[Mon Jan 12 11:26:18 2004] action exited with status 0
[Mon Jan 12 11:26:18 2004] completed event "battery BAT2 00000080 00000000"

Laptop mode is active:
$ cat /proc/sys/vm/laptop_mode 
1

Commit values have been applied:
$ mount -t reiserfs
/dev/hda6 on / type reiserfs (rw,noatime,notail,commit=600)
/dev/hda7 on /home type reiserfs (rw,noatime,notail,commit=600)

But the disk never spins down. Not that I can tell, hdparm -C /dev/hda always 
tells me active/idle, and the sdsl tool also reports 100% disk spinning...

anything else I have to activate/check?

-- 
To err is human, to repent, divine, to persist, devilish.
		-- Benjamin Franklin

