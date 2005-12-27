Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbVL0KW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbVL0KW6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 05:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbVL0KW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 05:22:58 -0500
Received: from fmr17.intel.com ([134.134.136.16]:45700 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932285AbVL0KW5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 05:22:57 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH v2:3/3]Export cpu topology by sysfs
Date: Tue, 27 Dec 2005 18:22:48 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E84044DEE70@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2:3/3]Export cpu topology by sysfs
Thread-Index: AcYKp/jta8cVSz2rS9mpHo8jBDZjzwAJhKaA
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "Greg KH" <greg@kroah.com>
Cc: "Yanmin Zhang" <ymzhang@unix-os.sc.intel.com>,
       <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>,
       <linux-ia64@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Shah, Rajesh" <rajesh.shah@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
X-OriginalArrivalTime: 27 Dec 2005 10:22:53.0972 (UTC) FILETIME=[7F780D40:01C60ACF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>-----Original Message-----
>>From: Greg KH [mailto:greg@kroah.com]
>>Sent: 2005Äê12ÔÂ27ÈÕ 13:35
>>To: Zhang, Yanmin
>>Cc: Yanmin Zhang; linux-kernel@vger.kernel.org; discuss@x86-64.org; linux-ia64@vger.kernel.org; Siddha, Suresh B; Shah, Rajesh;
>>Pallipadi, Venkatesh
>>Subject: Re: [PATCH v2:3/3]Export cpu topology by sysfs
>>
>>> Sorry. My previous explanation is confusing. It's a link warning on
>>> ia64. On ia64, the kernel vmlinux doesn't include section .exit.text,
>>> so ld will report a link warning when a function is in section
>>> .exit.text and another function (not in .exit.text) calls the first
>>> one. When CONFIG_HOTPLUG_CPU=n, function topology_remove_dev is in
>>> section .exit.text, but its caller topology_remove_dev is not in
>>> .exit.text.
>>>
>>> i386 and x86_64 kernel vmlinux does include .exit.text and discard it
>>> only when running, so there is no such warning on i386/x86_64.
>>>
>>> There is no other better approach to get rid of the warning unless we
>>> change arch/ia64/kernel/vmlinux.lds.S to keep all .exit.text in kernel
>>> image.
>>
>>Or just move that function to not be __exit, as you are calling it from
>>an __init function.  That would be the best solution.

I will change topology_remove_dev's attribute from __cpuexit to __cpuinit, and the problem will be resolved thoroughly.

Thanks.
