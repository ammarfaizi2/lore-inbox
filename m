Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261509AbSJTUrj>; Sun, 20 Oct 2002 16:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261781AbSJTUrj>; Sun, 20 Oct 2002 16:47:39 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:2176 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S261509AbSJTUri>;
	Sun, 20 Oct 2002 16:47:38 -0400
Date: Sun, 20 Oct 2002 15:53:08 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Mike Anderson <andmike@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi segfaults under 2.5.44
In-Reply-To: <20021020181825.GA3915@beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0210201541340.860-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2002, Mike Anderson wrote:

> Thomas,
> 	It looks like sg.c was missed in the update from put_device to
> 	device_unregister.
> 
> I have only compile tested the patch below, but it should fix the
> problem. I will have a chance to run later on today.

OK, well that was interesting.  Your patch cleared up my problem with sg.  
Now I have a new ide-scsi failure mode.  I'm pounding on this one because 
whatever magic was supposed to happen with ide-cd didn't.  I've documented 
it in a separate message.

I can now insert and remove ide-scsi modules (sr_mod, sg, scsi_mod, cdrom, 
ide-scsi).  However, when I then insert the ide-scsi modules a second 
time, it sees my disks at a different device!  I have a CDROM at ide1 
primary, and a CDRW at ide1 secondary.  ide-scsi normally sees them as 
/dev/scd0 and /dev/scd1, respectively.  After the modules are reinserted I 
get them reversed.  ide1 primary is now seen at /dev/scd1 and ide1 
secondary is seen at /dev/scd0.  Furthermore, this happens each time I 
repeat the cycle.  On the next cycle they are back to ide1 primary at 
/dev/scd0.  In other words, they alternate, depending on how many 
remove/insert cycles I go through.

If I simply insert the modules and leave them, thing act normally.  
However, once I remove them I get a segfault and system hang at reboot.

