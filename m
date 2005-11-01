Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVKAMC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVKAMC4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 07:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVKAMC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 07:02:56 -0500
Received: from spirit.analogic.com ([204.178.40.4]:21003 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750760AbVKAMCz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 07:02:55 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20051031212742.3e43c829.akpm@osdl.org>
References: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com><20051101031305.12488.1224.sendpatchset@schroedinger.engr.sgi.com> <20051031212742.3e43c829.akpm@osdl.org>
X-OriginalArrivalTime: 01 Nov 2005 12:00:48.0017 (UTC) FILETIME=[E58A3010:01C5DEDB]
Content-class: urn:content-classes:message
Subject: Re: [PATCH 5/5] Swap Migration V5: sys_migrate_pages interface
Date: Tue, 1 Nov 2005 07:00:44 -0500
Message-ID: <Pine.LNX.4.61.0511010658270.31439@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 5/5] Swap Migration V5: sys_migrate_pages interface
Thread-Index: AcXe2+WWKMfS+qpRQuywhtZJeTK9Ew==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: "Christoph Lameter" <clameter@sgi.com>, <torvalds@osdl.org>,
       <marcelo.tosatti@cyclades.com>, <kravetz@us.ibm.com>,
       <raybry@mpdtxmail.amd.com>, <lee.schermerhorn@hp.com>,
       <linux-kernel@vger.kernel.org>, <magnus.damm@gmail.com>, <pj@sgi.com>,
       <haveblue@us.ibm.com>, <kamezawa.hiroyu@jp.fujitsu.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 1 Nov 2005, Andrew Morton wrote:

> Christoph Lameter <clameter@sgi.com> wrote:
>>
>> ...
>> Changes V3->V4:
>> - Add Ray's permissions check based on check_kill_permission().
>>
>> ...
>> +	/*
>> +	 * Permissions check like for signals.
>> +	 * See check_kill_permission()
>> +	 */
>> +	if ((current->euid ^ task->suid) && (current->euid ^ task->uid) &&
>> +	    (current->uid ^ task->suid) && (current->uid ^ task->uid) &&
>> +	    !capable(CAP_SYS_ADMIN)) {
>> +		err = -EPERM;
>> +		goto out;
>> +	}
>
> Obscure.  Can you please explain the thinking behind putting this check in
> here?  Preferably via a comment...

Also XOR is not a good substitute for a compare. Except in some
strange corner cases, the code will always take more CPU cycles
because XOR modifies oprands while compares don't need to.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
