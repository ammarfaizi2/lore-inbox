Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422751AbWBNSUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422751AbWBNSUS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422752AbWBNSUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:20:18 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:41433 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1422751AbWBNSUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:20:17 -0500
Message-ID: <43F21F21.1010509@cfl.rr.com>
Date: Tue, 14 Feb 2006 13:19:13 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Seewer Philippe <philippe.seewer@bfh.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: RFC: disk geometry via sysfs
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com> <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com> <43F206E7.70601@bfh.ch>
In-Reply-To: <43F206E7.70601@bfh.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Feb 2006 18:21:27.0634 (UTC) FILETIME=[7862EB20:01C63193]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14267.000
X-TM-AS-Result: No--4.200000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seewer Philippe wrote:
> 
> IDE tries to return the actual hardware geometry. Most other drivers
> implement a "fake". Or try to guess the geometry from the MBR...
> 

But there is no "actual hardware geometry".  IDE disks can report a 
geometry, but that is no more real than any other made up geometry.  If 
you take the geometry that the disk itself reports and write that to the 
MBR, then software that actually uses the geometry ( i.e. non LBA boot 
loaders ) will fail because it is not the geometry that the bios uses.

The only remaining purpose to geometry values that I see is to store in 
the MBR for non LBA boot loaders to use.  Since they must have the 
values the bios uses, then you need to get the values from the bios when 
creating such an MBR.

> My personal answer is here: Because there are so many tools around which
> use the kernel values, that it is easier to overwrite the kernel than
> patch all other software... (i know, i know...)

The only tools that I am aware of are boot loaders and disk 
partitioners, and these tools do not need the geometry, they just try to 
get it to maintain compatibility with ancient systems.  As such, it is 
long past time for them to no longer require this information.

> 
> And additionally: When partitioning its sometimes necessary or safer to
> write a whole new mbr (dd if=... of=... ; parted mklabel msdos). When
> dd'ing the mbr goes away. And some drivers return geometry based on the
> mbr...... So overwriting these values might come handy.
> 

But what would you overwrite them with?  The only values that have any 
actual use are the ones from the bios.  If you get the values from the 
bios, it makes no sense to change them later.

