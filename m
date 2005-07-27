Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVG0VSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVG0VSI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 17:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbVG0VPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 17:15:38 -0400
Received: from fmr16.intel.com ([192.55.52.70]:1433 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S262160AbVG0VOZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 17:14:25 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [patch] properly stop devices before poweroff
Date: Wed, 27 Jul 2005 14:14:03 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F040022CC@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] properly stop devices before poweroff
Thread-Index: AcWSfonBfLzWFg7xQc+T6bOsqDgaNwAcV99w
From: "Luck, Tony" <tony.luck@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: "Andrew Morton" <akpm@osdl.org>, <kaneshige.kenji@jp.fujitsu.com>,
       <ambx1@neo.rr.com>, <greg@kroah.org>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 27 Jul 2005 21:14:04.0864 (UTC) FILETIME=[1E554C00:01C592F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The remaining problem is cause by the order of the calls in sys_reboot:
>> 
>>                 device_suspend(PMSG_SUSPEND);
>>                 device_shutdown();
>> 
>> The call to device_suspend() shuts down the mpt/fusion 
>driver.  But then
>> device_shutdown() calls sd_shutdown() which prints:
>> 
>>   Synchronizing SCSI cache for disk sdb
>
>Okay, looks to me like sd_shutdown should be done from
>device_suspend(), not device_shutdown [because it needs scsi subsystem
>to be functional]. Also for reboot we probably want PMSG_FREEZE (not
>PMSG_SUSPEND), to keep it slightly faster.

Are you going to work on making those changes?

-Tony
