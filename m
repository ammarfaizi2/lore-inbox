Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265584AbUAGSDg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 13:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265608AbUAGSCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 13:02:52 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:40641 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S265584AbUAGSCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 13:02:21 -0500
Date: Wed, 07 Jan 2004 10:01:34 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: slpratt@us.ibm.com
Subject: [Bug 1806] New: disks stats not kept for DM (device	mapper) devices 
Message-ID: <4340000.1073498494@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1806

           Summary: disks stats not kept for DM (device mapper) devices
    Kernel Version: 2.6.0
            Status: NEW
          Severity: normal
             Owner: axboe@suse.de
         Submitter: slpratt@us.ibm.com


Distribution:all
Hardware Environment:all
Software Environment:all
Problem Description:
Disk stats as reported through sysfs are empty for all DM (device mapper)
devices.  This appears to be due to the fact that the stats are traced via
request structs which are not generated until below the device mapper layer.  It
seems it would be possible to add code to device mapper to track the stats since
the actual location of the stats is in the gendisk entry which does exsist for
DM deivices.  Only problem I see is in tracking ticks for IO since in the non DM
case this is done by storing a start time in the request struct on driving the
request.  Since DM has no request struct (only the BIO) it has no place to
record the start time.

Steps to reproduce:
create a DM device using dmsetup, lvm2 or EVMS.  Do IO to device, look at
/sys/block/dm-xxx/stat.


