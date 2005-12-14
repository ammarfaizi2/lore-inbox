Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbVLNFjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbVLNFjH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 00:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbVLNFjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 00:39:07 -0500
Received: from fmr18.intel.com ([134.134.136.17]:4541 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751373AbVLNFjF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 00:39:05 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: [discuss] [PATCH] Export cpu topology for IA32 and x86_64 by sysfs
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Wed, 14 Dec 2005 13:38:57 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E840431BCA8@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [discuss] [PATCH] Export cpu topology for IA32 and x86_64 by sysfs
Thread-Index: AcYAYaOHrIm5oLI6Qvu/4atQ7a4WsQADLbRg
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
X-OriginalArrivalTime: 14 Dec 2005 05:38:59.0200 (UTC) FILETIME=[AE956000:01C60070]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>-----Original Message-----
>>From: Andi Kleen [mailto:ak@suse.de]
>>Sent: 2005Äê12ÔÂ14ÈÕ 11:51
>>To: Zhang, Yanmin
>>Cc: linux-kernel@vger.kernel.org; discuss@x86-64.org; Pallipadi, Venkatesh
>>Subject: Re: [discuss] [PATCH] Export cpu topology for IA32 and x86_64 by sysfs
>>
>>On Wed, Dec 14, 2005 at 11:11:00AM +0800, Zhang, Yanmin wrote:
>>> The patch exports the cpu topology info through sysfs on ia32/x86_64
>>> machines. The info is similar to /proc/cpuinfo.
>>>
>>> The exported items are:
>>> /sys/devices/system/cpu/cpuX/topology/physical_package_id(representing
>>> the physical package id of  cpu X)
>>> /sys/devices/system/cpu/cpuX/topology/core_id (representing the cpu core
>>> id  to cpu X)
>>> /sys/devices/system/cpu/cpuX/topology/thread_siblings (representing the
>>> thread siblings to cpu X)
>>> /sys/devices/system/cpu/cpuX/topology/core_siblings (represeting the
>>> core siblings to cpu X)
>>
>>Hmm, I'm not sure it is that useful. Did someone decide to move
>>all information from cpuinfo into sysfs?
It's more convenient for shell scripts to get cpu topology info from sysfs.

>>
>>And if it's done I think it needs Documentation somewhere.
There is no appropriate file to write down the info under Documentation.

>>
>>Anyways, the notifier is wrong. You need to handle CPU_UP_CANCELLED
>>too.
No. The node and related data are created/registered only when cpu is CPU_ONLINE. If CPU_UP_CANCELED is delivered to the notifier, the cpu is not online, and its node is not registered, so we needn't do anything when CPU_UP_CANCELED.

>>
>>And you could probably shrink the code size of the show function
>>in half by switching data instead of functions.
I don't quite understand what you said. My patch just uses the attribute address (a kind of data, not function) as parameter. If the function needs to be shrunken, I think I have to define a sub function per attribute which causes even longer code size.

