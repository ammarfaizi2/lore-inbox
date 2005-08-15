Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbVHOW66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbVHOW66 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbVHOW66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:58:58 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:60850 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1751094AbVHOW65 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:58:57 -0400
X-IronPort-AV: i="3.96,109,1122872400"; 
   d="scan'208"; a="279920332:sNHT26052096"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
Date: Mon, 15 Aug 2005 17:58:56 -0500
Message-ID: <4277B1B44843BA48B0173B5B0A0DED4352817E@ausx3mps301.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
Thread-Index: AcWh7OovvF1T67llRfyRyPloDBtMCQ==
From: <Michael_E_Brown@Dell.com>
To: <mrmacman_g4@mac.com>
Cc: <linux-kernel@vger.kernel.org>, <Douglas_Warzecha@Dell.com>,
       <Matt_Domsch@Dell.com>
X-OriginalArrivalTime: 15 Aug 2005 22:58:56.0867 (UTC) FILETIME=[EA820330:01C5A1EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> +On some Dell systems, systems management software must access
certain
>> +management information via a system management interrupt (SMI).   
>> The SMI data
>> +buffer must reside in 32-bit address space, and the physical  
>> address of the
>> +buffer is required for the SMI.  The driver maintains the memory  
>> required for
>> +the SMI and provides a way for the application to generate the SMI.
>> +The driver creates the following sysfs entries for systems
management
>> +software to perform these system management interrupts:
>
> Why can't you just implement the system management actions in the
kernel
> driver?  This is tantamount to a binary SMI hook to userspace.  What
> functionality does this provide on a dell system from an
administrator's
> point of view?

Kyle,
	I'm sure that not everybody agrees with the whole concept of SMI

calls. Nevertheless, these calls exist, and in order to have a complete 
systems-management solution, we have to provide a way to do SMI calls. 
Now, we have developed a way to do these SMI calls from userspace
without 
kernel support, but we are trying to be community-friendly and show our 
hooks in the open, rather than trying to sneak them in under the covers.

	You might not like the concept of a generic hook for SMI calls
in 
the kernel, but the alternatives are hardly better. One alternative is 
the already-mentioned method that we do things under the covers in 
userspace. Another alternative is that we write separate kernel code for

each and every SMI call that exists in the Dell BIOS. The second 
alternative is not entirely feasible. We have over 60 SMI functions, and

we would have to write a kernel-mode wrapper for each and every one. I 
hope you agree that code that doesn't exist is less buggy than code that

is, and that code that is in userspace is a whole lot less likely to
cause 
a kernel crash than code that is in the kernel. We are trying to keep
our 
kernel bloat down. We don't really think that customers of IBM or HP
really 
want their Red Hat kernels loaded down with a bunch of Dell-only code.
	
	Additionally, we are releasing an open source library (GPL/OSL
dual 
license) that can use these hooks to perform many systems management 
functions in userspace. See http://linux.dell.com/libsmbios/main/. We 
should have code in libsmbios to do SMI using this driver within about
two 
weeks.  We currently writing the SMI hooks in libsmbios using this
posted 
version of the driver. I am the maintainer of this project, and it is my
goal 
to have code in libsmbios for every Dell SMI call.

	Dell is not trying to use this driver as a method of inserting
binary 
blobs into the kernel, nor are we trying to subvert kernel security by 
implementing this driver. We are simply trying to get all of our systems

management software into the kernel as open source drivers. This
represents 
a fundamental shift in philosophy from the Dell systems-management team
from 
our previous binary-only driver approach. 

	We would welcome feedback on a better way to implement this
driver in 
the kernel, but the fact remains that we have to have a way to do this,
and 
we are open-sourcing all of the code necessary to get this done. 
--
Michael Brown
