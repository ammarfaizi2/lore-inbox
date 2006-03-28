Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWC1U5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWC1U5p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 15:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWC1U5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 15:57:45 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:28592 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S932162AbWC1U5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 15:57:44 -0500
Message-ID: <4429AF42.1090101@soleranetworks.com>
Date: Tue, 28 Mar 2006 14:48:50 -0700
From: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: e2label suggestions
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


e2label takes as parms:

e2label <device name> <mount point>

What's useless about this is the association of device name and file 
system label which is completely broken on SATA systems which do dynamic
assignment.  e2label was a great idea, but did not go far enough to 
abstract. 

The Initial mount sequence using:

 root=LABEL=/

should be modified to ignore the device assignment and dunamically scan 
the drives for the root drive for initial bootup and DETECT
the device assignment rather then reverting to fixed device 
assignments.  As implemented it's pretty useless and is simply an aliasing
mechanism rather than solving the problem of the system being truly 
dynamic. 

On many systems, including the systems we ship, /dev/sda, /dev/sdb, and 
/dev/sdc are dynamically created from 3Ware RAID arrays and the boot drive
on the SATA connectors of the motherboard tends to "float" (i.e. sdc can 
move to sda or sdb between boots depending on how the arrays are 
configured).
On a RAID 0 failure, by way of example, sdc becomes sdb and renders a 
system unable to boot.  The solution is to setup the initial scanning 
for root to look for the "/" assignment from e2label, and dynamically 
assign the /dev/sdX handle from this scanning. 

Just a suggestion.

Jeff


