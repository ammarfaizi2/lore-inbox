Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbVCVEhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbVCVEhM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 23:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbVCVEeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 23:34:50 -0500
Received: from fmr15.intel.com ([192.55.52.69]:12775 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S262450AbVCVE3m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 23:29:42 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Distinguish real vs. virtual CPUs?
Date: Mon, 21 Mar 2005 20:29:30 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB600448EE27@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Distinguish real vs. virtual CPUs?
Thread-Index: AcUujLNdaqo7UK/bSdSGE8YXnX44XgACheKA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "J.A. Magallon" <jamagallon@able.es>, "Dan Maas" <dmaas@maasdigital.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Mar 2005 04:29:35.0909 (UTC) FILETIME=[C0C65550:01C52E97]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>This is 2xXeonHT, is, 4 cpus on 2 packages:
>
>cat /proc/cpuinfo:
>
>processor	: 0
>...
>physical id	: 0
>siblings	: 2
>core id		: 0
>cpu cores	: 1
>
>processor	: 1
>...
>physical id	: 0
>siblings	: 2
>core id		: 0
>cpu cores	: 1
>
>processor	: 2
>...
>physical id	: 3
>siblings	: 2
>core id		: 3
>cpu cores	: 1
>
>processor	: 3
>...
>physical id	: 3
>siblings	: 2
>core id		: 3
>cpu cores	: 1
>
>So something like:
>
>cat /proc/cpuinfo | grep 'core id' | uniq | wc -l
>
>would give you the number of packages or 'real cpus'. Then you have to
>choose which ones are unrelated. Usually evens are siblings of 
>odds, but
>I won't trust on it...
>

Number of unique physical id will tell you the number of physical CPU
packages in the system.
Number of unique core id will tell you the total number of CPU cores in
the system.
Number of processor will tell you the total number of logical CPUs on
the system.

Then to find out the matching pairs, 
- to pair up all HT siblings on a core: Processors that have same "core
id" are HT siblings in a core.
- to pair up all CPUs in a package: Processors that have same "physical
id" are all the CPUs belonging to the same physical package.

Thanks,
Venki
