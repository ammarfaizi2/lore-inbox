Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315358AbSFTQ6o>; Thu, 20 Jun 2002 12:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSFTQ6m>; Thu, 20 Jun 2002 12:58:42 -0400
Received: from host194.steeleye.com ([216.33.1.194]:47371 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S315358AbSFTQ6k>; Thu, 20 Jun 2002 12:58:40 -0400
Message-Id: <200206201658.g5KGwYL04775@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map 
In-Reply-To: Message from Martin Dalecki <dalecki@evision-ventures.com> 
   of "Thu, 20 Jun 2002 18:30:36 +0200." <3D12032C.7040105@evision-ventures.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 20 Jun 2002 12:58:34 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dalecki@evision-ventures.com said:
> 1. There was the mistake of using different major numbers for SCSI and
> IDE/ATAPI devices. (disk and CD-ROM are the most striking). 

Don't confuse major numbers (which are really a kernel internal thing) with 
names.  Major numbers serve a very useful purpose in allowing quick device 
driver identification.  It would be an unhappy state of affairs if we had to 
parse both the major and minor numbers extensively just to identify the device 
driver to handle the request.  There's no reason why we can't use a consistent 
naming scheme for all CD-ROMs and yet have them using different major numbers.

One of the advantages of driverfs, I think, is that it separates the device 
name from a static entry in /dev which is tied to a major/minor number.

> 6. The /name is entierly redundant logically to the fact that we have
> already a unique path to the device. For "pretty" printing we have
> userspace. For PCI it's for example repeating the ID info found
> already by lspci. 

The /name is useful in the enterprise for persistent device identification.  
Leaves in the device tree can move as boxes are regconfigured.  The name entry 
helps you find your leaf again when this happens.  It also helps you find the 
same storage in a cluster regardless of the device driver or storage 
connection method.

> And last but not least: I still don't see any kind of abstraction
> there which would allow to easly enumerate for example all disks in
> the system. 

Doesn't this depend on the semantics provided in the device node (leaf)?  If 
you had a way of identifying disk devices (say from an empty type=disk file) 
then you could do a simple find to list all the disks in the system regardless 
of being SCSI, IDE, SSA etc.

James




