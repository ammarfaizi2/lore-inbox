Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbUKHRjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUKHRjl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 12:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUKHRjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:39:06 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:22453 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id S261983AbUKHRgl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 12:36:41 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: KSTK_EIP and KSTK_ESP
Date: Mon, 8 Nov 2004 10:36:04 -0700
Message-ID: <C863B68032DED14E8EBA9F71EB8FE4C20542D290@azsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: KSTK_EIP and KSTK_ESP
Thread-Index: AcTD5w85nlXzze6fT9iSIE07b0boCQByRhLA
From: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
To: <pageexec@freemail.hu>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Nov 2004 17:36:06.0151 (UTC) FILETIME=[6CFF5170:01C4C5B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>  Can someone explain the structure of the memory that these two
>> macros are accessing? Specifically, where do the 1019 and 1022
offsets
>> come from? Also, what other things are stored at other offsets? Where
is
>> this stack structure defined?

> if you treat the second (upper) page of the kernel stack as an array
> of dwords and you realize that the initial kernel (ring-0) stack
pointer
> is set at element 1024 then the top elements look like this after a
ring
> transition:
>
> [1023] ring-3 SS
> [1022] ring-3 ESP
> [1021] ring-3 EFLAGS
> [1020] ring-3 CS
> [1019] ring-3 EIP
>
> the ring-0 ESP is stored in the TSS and the thread structure, and it's
> initialized in arch/i386/kernel/process.c:copy_thread().

	Thank you for your reply.
	If I dereference the address in 1022 (the ring 3 ESP address) it
does indeed return the value in EBX. I then thought that I could use
this address to feed to dump_thread() since EBX is the first thing in
the pt_regs structure, but that's not correct in this case because the
other registers are definitely incorrect. Shouldn't the ESP value
pointed to by KSTK_ESP() point to the beginning of the pt_regs structure
for the user space application?

