Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262761AbVCXKVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbVCXKVD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 05:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbVCXKVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 05:21:03 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:44984 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263084AbVCXKS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 05:18:58 -0500
Message-ID: <4242941A.3050501@in.ibm.com>
Date: Thu, 24 Mar 2005 15:49:06 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fastboot <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] Obtaining memory information for kexec/kdump
References: <424254E0.6060003@in.ibm.com> <1111650644.9881.43.camel@localhost>
In-Reply-To: <1111650644.9881.43.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Thu, 2005-03-24 at 11:19 +0530, Hariprasad Nellitheertha wrote:
>
...

> I think there's likely a lot of commonality with the needs of memory
> hotplug systems here.  We effectively dump out the physical layout of
> the system, but in sysfs.  We do this mostly because any memory hotplug
> changes generate hotplug events, just like all other hardware.  If you
> do this in /proc, it's another thing that memory hotplug will have to
> update.  

We put it in /proc primarily because what we wanted was 
similar in many ways to /proc/iomem and so we (re)use a bit 
of the code. Also, we were wondering if it is appropriate to 
put in multiple values in a single file in sysfs.

> 
> Also, we already have a concept of active and non-active physical
> memory: we call it online and offline.  Some tweaks to the information
> that we export might be all that you need, instead of creating a new
> interface. 

Looks like. And the tweaks could be handled by the user 
space kexec-tools.

  I've attached a document I started writing a couple days ago
> about the sysfs layout and the call paths for hotplug.  It's horribly
> incomplete, but not a bad start.
> 
> If you want to see some more details of the layout, please check out
> this patch set:
> 
> http://www.sr71.net/patches/2.6.12/2.6.12-rc1-mhp1/patch-2.6.12-rc1-mhp1.gz

This does not have the sysfs related code. Is there a 
separate patch for adding the sysfs entries?

> 
> A good example of all of the hotplug stuff enabled for a normal machine
> is this .config, it boots on my 4-way PIII Xeon.  
> 
> http://www.sr71.net/patches/2.6.12/2.6.12-rc1-mhp1/configs/config-i386-sparse-hotplug
> 
> You're welcome to borrow the machine that I normally boot this config
> on.  Should make booting it relatively foolproof. :)
> 
> -- Dave
> 
> 
> ------------------------------------------------------------------------
> 
> block_size_bytes:  The size of each memory section (in hex)

This value is per memoryXXXX directory, right?


Regards, Hari
