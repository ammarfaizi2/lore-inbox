Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUGSGHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUGSGHI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 02:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264717AbUGSGHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 02:07:08 -0400
Received: from fmr06.intel.com ([134.134.136.7]:25750 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264704AbUGSGHB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 02:07:01 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Preempt Violation
Date: Mon, 19 Jul 2004 14:06:45 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8403BD5605@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Preempt Violation
Thread-Index: AcRrmFEr85aAfQoUTIG1P/mrPl07ZQBvbjaw
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Lee Revell" <rlrevell@joe-job.com>,
       "Gabriel Devenyi" <devenyga@mcmaster.ca>
Cc: <ck@vds.kolivas.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 Jul 2004 06:06:46.0606 (UTC) FILETIME=[928596E0:01C46D56]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-kernel-owner@vger.kernel.org wrote:
> On Fri, 2004-07-16 at 20:06, Gabriel Devenyi wrote:
>> This one looks particularly nasty.
>> 
>> 20ms non-preemptible critical section violated 4 ms preempt
>> threshold starting a
> 
>> t sys_ioctl+0x42/0x260 and ending at sys_ioctl+0xbd/0x260
>> [<c015881d>] sys_ioctl+0xbd/0x260  [<c0116510>]
>> dec_preempt_count+0x110/0x120  [<c015881d>] sys_ioctl+0xbd/0x260
>> [<c0103e95>] sysenter_past_esp+0x52/0x71
> 
> Yes, it looks like there are serious issues with ioctl.
> 
> Are you using either of the recent patches to fully daemonize
> softirqs? This should help a lot.  I am using this one:
> 
> http://lkml.org/lkml/2004/7/13/125
> 
> It applied against 2.6.8-mm1, with only one PPC-specific reject, I
> use i386 so it doesn't matter. 
> 
> Here is another:
> 
> http://lkml.org/lkml/2004/7/13/152
> 
> Have not tested yet.
> 
> Lee

ioctl is called with the BKL held, which will disable preempt.
I don't think the patch helps.

Thanks,
-yi
