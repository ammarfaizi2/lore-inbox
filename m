Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266409AbSKZQZ0>; Tue, 26 Nov 2002 11:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266411AbSKZQZ0>; Tue, 26 Nov 2002 11:25:26 -0500
Received: from host194.steeleye.com ([66.206.164.34]:41742 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S266409AbSKZQZZ>; Tue, 26 Nov 2002 11:25:25 -0500
Message-Id: <200211261632.gAQGWWj03059@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Patrick Finnegan <pat@purdueriots.com>
cc: James.Bottomley@HansenPartnership.com, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel on NCR Worldmark 5100 and 3450 Workstation
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Nov 2002 10:32:32 -0600
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does anyone know anything about getting a Linux kernel to boot on
> either of these machines?  The Worldmark 5100 is a massive
> multiprocessor Pentium Pro machine with two MCA buses.  The 3450 is a
> quad-Pentium workstation with a single MCA bus.

The WorldMark was the new name for the voyager systems (I even forgot that 
they changed it).  A (somewhat contorted) boot process is documented here.

The 3450 should work flawlessly as long as it has either a buslogic or D700 
SCSI controller (I use a relative of this, the 3455 for my SCSI development 
work).

The 5100 should work, but you'll have trouble with the Q720 SCSI controller.  
The patches I had to make this card work with the 53c7,8xx driver are defunct 
in 2.5 (although they may work for 2.4).  I had planned to try to leverage 
Richard Hirst's parisc Zalon SCSI work to do this and trick the consistent 
memory allocation routines to use the 2Mb memory window behind the MCA bridge, 
but I haven't even begun that yet.

I'm just starting to look at support for the secondary microchannel in the 
5100---If you follow the mca-sysfs thread on linux-kernel, you'll see all the 
necessary abstractions.  Unfortunately, I don't actually have a machine with 
two MCA busses, only the specs, so I'm flying by simulator only.

The project and its patches are all available here:

http://www.hansenpartnership.com/voyager

James Bottomley



