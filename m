Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265100AbUAMSUA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 13:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbUAMSUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 13:20:00 -0500
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:30696 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S265100AbUAMST5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 13:19:57 -0500
Message-ID: <400436C3.6050507@backtobasicsmgmt.com>
Date: Tue, 13 Jan 2004 11:19:47 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: Scott Long <scott_long@adaptec.com>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Proposed Enhancements to MD
References: <40036902.8080403@adaptec.com> <20040113081932.A721@lists.us.dell.com>
In-Reply-To: <20040113081932.A721@lists.us.dell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch wrote:

> DDF is quickly becoming important to RAID and system vendors, and I
> welcome Adaptec's work to implement DDF support on Linux.

Fully agreed, the days of vendor-specific metadata formats need to be 
numbered (with a small number). Speaking a customer with a CMD 
FC-to-SCSI RAID controller, which used to be dual-redundant but is now 
single (because of a dead unit), we are not looking forward to the day 
when the remaining controller dies and we lose all the data on the array 
due to a forced metadata format change.

However, given that this will not likely be 2.6 material until after 
it's built and tested in 2.7 and then backported, it doesn't seem to 
make any sense to me to build any of this on top of the MD subsystem at 
all (see other replies about using DM instead). Additionally, it also 
does not seem to make any sense to build any of the DDF 
reading/writing/management in the kernel _at all_. There is no advantage 
to it being there once initramfs is a standard part of the boot process, 
so all of this should be done is userspace and just communicated into 
the kernel to tell it what logical devices to construct using which DM 
modules.

