Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161086AbWBNPnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086AbWBNPnr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 10:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWBNPnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 10:43:47 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:50884 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S964807AbWBNPnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 10:43:47 -0500
Message-ID: <43F1FA74.80607@cfl.rr.com>
Date: Tue, 14 Feb 2006 10:42:44 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: jzb@aexorsyst.com
CC: linux-kernel@vger.kernel.org
Subject: Re: root=/dev/sda1 fails but root=0x0801 works...
References: <200602132316.15992.jzb@aexorsyst.com>
In-Reply-To: <200602132316.15992.jzb@aexorsyst.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Feb 2006 15:44:56.0810 (UTC) FILETIME=[9B04E4A0:01C6317D]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14267.000
X-TM-AS-Result: No--21.399000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Z. Bohach wrote:
> This is probably a question with an obvious answer, but I haven't found it
> elsewhere, so I hope its okay if I ask here...
>
> As the subject says, if I have my kernel command line with
> '...root=/dev/sda1...' then I get
>
> VFS: Cannot open root device "sda1" or unknown-block(0,0)
>
> however, everything else being the same, if I have
> '...root=0x0801...', then it works fine.  Note that 
>
> SCSI device sda: 2001888 512-byte hdwr sectors (1025 MB)
> sda: Write Protect is off
> sda: assuming drive cache: write through
>  sda: sda1
> Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
>
> preceeds this in the console both for the failed case and the succeeding case
> (as I already have the rootdelay=10 param. on the command line as well).
>
> I've narrowed this down to another CONFIG_* option, but I can't find which
> one in tractable time...
>
> Does anybody know which CONFIG_* option might contribute to text string
> root=/dev/sda1 failing while its root=0x0801 cousin works?  I've already tried the
> CONFIG_KALLSYMS one, but no luck.  Would this possibly have to do with
> CONFIG_NLS=m (et al),  as I have those as modules, and if so, is this intentional?
>
> Thanks,
> John
>   

This is expected behavior.  The kernel doesn't have a /dev at the time 
it mounts the root fs so it has no idea what /dev/sda1 is.  Typically 
lilo will translate /dev/sda1 to 0x0801 automatically for you and pass 
that to the kernel for this reason. 

These days most distributions are using an initrd which the kernel 
mounts as the root fs, and that sets up a minimal /dev and does some 
hardware detection.  In that scenario, you can use free form /dev 
strings, assuming that they actually exist by the time the initrd's 
startup scripts finish running. 


