Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUDTW72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUDTW72 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 18:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264512AbUDTW0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 18:26:06 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:24 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S264280AbUDTTt4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 15:49:56 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6527.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC] Enhanced MD / alternatives in userspace
Date: Tue, 20 Apr 2004 14:49:52 -0500
Message-ID: <D69989B48C25DB489BBB0207D0BF51F7096023@ausx2kmpc104.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] Enhanced MD / alternatives in userspace
Thread-Index: AcQj/goVjK2cczaYQdyN/FzoMh7RlQDEKbMg
From: <Andre_Dumouchelle@Dell.com>
To: <c-d.hailfinger.kernel.2004@gmx.net>, <linux-kernel@vger.kernel.org>
Cc: <linux-raid@vger.kernel.org>
X-OriginalArrivalTime: 20 Apr 2004 19:49:52.0559 (UTC) FILETIME=[A5AA7BF0:01C42710]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel,

>From a high level, there is definitely interest in any solution that has
the ability to get around the need for proprietary binary drivers that
enable driver based RAID solutions, and enables common metadata formats
like DDF.  

The main features of interest from a server perspective in any RAID
solution (Software or Hardware) are 

- Full RAID support (0/1/5/10)
- DDF
- OS RAID Management / configuration 
- Robust error handling 
- Installable to the RAID logical device.  Need the ability for Linux to
understand the RAID array prior to installation, and not force the user
to add RAID support post installation (protected boot arrays)

Enhanced MD has accomplished these features through E-MD and E-MDADM,
however, it has not met the needs of the community from an architectural
standpoint.  We're looking for something that meets both sides of this
equation.

Thanks
Andre

-----Original Message-----
From: linux-raid-owner@vger.kernel.org
[mailto:linux-raid-owner@vger.kernel.org] On Behalf Of Carl-Daniel
Hailfinger
Sent: Friday, April 16, 2004 4:35 PM
To: Linux Kernel Mailing List
Cc: Linux RAID Mailing List
Subject: [RFC] Enhanced MD / alternatives in userspace


Hi,

during development of raiddetect I asked myself if this tool could be
extended to set up not only the classic vendor ATARAID devices, but also
things like Adaptec ASR (HostRAID) and DDF based RAID formats.

Raiddetect is a utility which searches all disks for known RAID
superblocks/metadata and parses the contents for validity. The results
of this scan can either be outputted to the console or used to tell
dm/md to set up the RAID devices. The newest version of raiddetect was
posted to linux-kernel a few minutes ago and I will provide a web home
for it soon.

So far, the development of raiddetect is at a stage where I can find
(and mostly validate) the metadata of all ATARAID devices recognized by
2.4 kernels. Adding ASR and DDF detection should be relatively easy
since I tried to make the code moular and extensible.

Assuming the on-disk format of RAID5 et al. does not differ between the
Linux md implementation and e.g. DDF (modulo some offset and different
superblocks), DDF support is possible today with combinations of plain
MD and DM. No additional kernel code needed at all. Simply teach
raiddetect to understand the DDF metadata and pass this information to
MD in a format md understands. The DDF metadata can be masked away from
MD by using DM so you don't have to worry about it being trashed.

Since this is marked as [RFC], please comment on its (in-)feasibility.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

-
To unsubscribe from this list: send the line "unsubscribe linux-raid" in
the body of a message to majordomo@vger.kernel.org More majordomo info
at  http://vger.kernel.org/majordomo-info.html
