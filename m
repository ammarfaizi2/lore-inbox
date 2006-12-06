Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759711AbWLFCrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759711AbWLFCrH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 21:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759737AbWLFCrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 21:47:07 -0500
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:60156 "EHLO
	rwcrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759711AbWLFCrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 21:47:04 -0500
Message-ID: <45762F1E.4030805@comcast.net>
Date: Tue, 05 Dec 2006 21:46:54 -0500
From: Ed Sweetman <safemode2@comcast.net>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Why SCSI module needed for PCI-IDE ATA only disks ?
References: <fa.juE97gahpb4n2kNNH/Todtcvh3s@ifi.uio.no> <fa.IqtlZas3d+ZPuhF6S6N/ivdF8Wo@ifi.uio.no> <fa.HDRhmOhDQliejH7ijqJBWw9Jw0o@ifi.uio.no> <45761B2F.9060804@shaw.ca> <457625CF.2080105@comcast.net> <45762781.8020207@shaw.ca>
In-Reply-To: <45762781.8020207@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Ed Sweetman wrote:
>> What's not a legitimate configuration is libata drivers, no low level 
>> scsi drivers, no ide drivers and no sd,sr,sg drivers.  Yet, that is 
>> the configuration the kernel currently gives you. How is that more 
>> correct than any of the 3 solutions I have suggested?
>
> You can't build libata without low-level SCSI drivers. CONFIG_ATA 
> automatically selects CONFIG_SCSI.
>
config scsi isn't low level.  There are no scsi controllers selected by 
selecting config_ata. Mening, that the user hasn't bothered going into 
the SCSI section.  In effect you have a system that detects the ata 
controllers but nothing that can use the drives on them. How is that a 
valid system, a system where no drives are usable, but having some 
mention of the configuration in the Help of libata or automatically 
selecting those scsi_sd, sr, and sg drivers and letting the user 
deselect them as needed instead of the other way around Not a valid are 
more correct system?  

No matter what when you select a scsi controller or libata controller 
you are going to need to select one or more of those scsi device drivers 
(sr,sg,sd) the issue is that when you are only using libata, you have no 
reason to bother with the scsi section so it's not readily apparent that 
you would need those block device drivers.   I'm not saying we should 
auto select them, but I am saying that auto selecting is way better than 
keeping the kernel configuration the way it is and selecting none.



In the end the problem is in the layout of the config.  SCSI is _THE_ 
device interface protocol but most people dont have scsi physical 
interfaces. The kernel differentiates between the two inside the SCSI 
section.  This made sense before ide was marked for eventual replacement 
by libata. Now everything uses that scsi top level for block device 
access.  That effectively makes those scsi block devices generic block 
devices.  SCSI and LIBATA sections should have configuration options 
that are relevant to those physical devices and interfaces and not 
require options from eachother's sections to get drivers in their own 
sections to work.   Massively shared config options shouldn't be stuck 
in some sub menu below where all the things that use it are located.
But that's for some much later version of the kernel to deal with (when 
ide is removed and such). 
