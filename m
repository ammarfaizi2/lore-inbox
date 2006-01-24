Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbWAXOvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWAXOvM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 09:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWAXOvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 09:51:12 -0500
Received: from havoc.gtf.org ([69.61.125.42]:24210 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964984AbWAXOvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 09:51:10 -0500
Date: Tue, 24 Jan 2006 09:51:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Ed Sweetman <safemode@comcast.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.16-rc1-mm2 pata driver confusion
Message-ID: <20060124145109.GC23269@havoc.gtf.org>
References: <43D5CC88.9080207@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D5CC88.9080207@comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 01:43:20AM -0500, Ed Sweetman wrote:
> I have an nforce4 based motherboard.  Currently i'm using the amd/nvidia 
> driver under the normal ide,ata driver section (2.6.14). 
> 
> It appears that the new ata code is hiding under scsi/sata drivers, 
> including apparently pata code.  This alone reads confusing, pata 

libata PATA support is under development.  Use only if you feel lucky.
Really lucky.  I mean, really really lucky.


> 1.  Atapi is most definitely not supported by libata, right now.

Not true.


> 2. whether libata sets the controller up better or not, ide cdroms MUST 
> be loaded before libata is or the ide controller will be detected as 
> "already in use" and the cdrom drivers wont have any device to attach 
> to, since unlike scsi drivers, ide drivers dont probe the hardware on 
> controllers to see if any driver has claimed them.

Either use drivers/ide or libata for PATA, not both.


> 3. For hdd's alone, the pata libata + sata drivers are a "complete" 
> replacement for the ide drivers and thus, if you dont have atapi 
> devices, you dont need to compile in ide support.

Again, ATAPI works just fine.


> 4.  moving to pata libata drivers _will_ change the enumeration of your 
> sata devices, it seems that pata is initialized first, so when setting 
> up your fstab entries and grub, you'll have to take into account how 
> many pata devices you have and offset your current sata device names by 
> that amount.

Enumeration of devices depends on which driver is loaded first.
Check your /etc/modprobe.conf.

	Jeff


