Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVBNQ4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVBNQ4i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 11:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVBNQ4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 11:56:38 -0500
Received: from fmr13.intel.com ([192.55.52.67]:21417 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S261487AbVBNQ4Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 11:56:16 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: possible CPU bug and request for Intel contacts
Date: Mon, 14 Feb 2005 08:55:05 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB600400357E@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: possible CPU bug and request for Intel contacts
Thread-Index: AcUSCA19r+ILkiunSsaMezGFLaoUDwArX5gQ
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>, "Seth, Rohit" <rohit.seth@intel.com>
Cc: "Kirill Korotaev" <dev@sw.ru>, "Linus Torvalds" <torvalds@osdl.org>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Andrey Savochkin" <saw@sawoct.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Feb 2005 16:55:06.0858 (UTC) FILETIME=[EFA07CA0:01C512B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>-----Original Message-----
>From: Ingo Molnar [mailto:mingo@elte.hu] 
>Sent: Sunday, February 13, 2005 12:10 PM
>To: Seth, Rohit
>Cc: Kirill Korotaev; Linus Torvalds; Saxena, Sunil; Pallipadi, 
>Venkatesh; Andrey Savochkin; linux-kernel@vger.kernel.org
>Subject: Re: possible CPU bug and request for Intel contacts
>
>
>* Seth, Rohit <rohit.seth@intel.com> wrote:
>
>> On a little different note, while running the 4G-4G kernel on our
>> machine, we saw occasional hangs.  Those are root caused to the fact
>> that this kernel was first chaging the stack pointer from virtual
>> stack to kernel and then changing the CR3 to that of kernel.  Any
>> interrupt between these two instructions will result in 
>those hangs as
>> the interruption handler will execute with user's CR3(as the kernel
>> thinks that it is already in kernel because of the value of esp). 
>> Swapping the order, first loading the CR3 with kernel and then
>> switching the stack to kernel fixes this issue.  Venki will generate
>> that patch and send to lkml.
>
>i'm not sure what you mean. Here's the relevant 4:4 code from Fedora:
>
>#define __SWITCH_KERNELSPACE                            \
>...
>        movl %edx, %cr3;                                \
>        movl %ebx, %esp;                                \
>
>i.e. we _first_ load cr3 with the kernel pagetable value, then do we
>switch esp to the real kernel stack.
>

Yes. I verified that and that's the reason I didn't send any patch. But,

the kernel we were using in our testing of this bug, came from some 
earlier version of 4:4 code and had this cr3 switch and esp switch in 
reverse order. 

With the latest kernels there is no issue related to this.

Thanks,
Venki
