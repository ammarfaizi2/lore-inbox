Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271973AbTHSPmQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 11:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272011AbTHSPmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 11:42:16 -0400
Received: from fmr05.intel.com ([134.134.136.6]:61422 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S271973AbTHSPmO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 11:42:14 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Updated MSI Patches
Date: Tue, 19 Aug 2003 08:42:10 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E50240154171D@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Updated MSI Patches
Thread-Index: AcNg/tHVGCz5f2AFQ5qZlQ6qwvUpLQFZjIjQ
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Zwane Mwaikambo" <zwane@linuxpower.ca>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "long" <tlnguyen@snoqualmie.dp.intel.com>
X-OriginalArrivalTime: 19 Aug 2003 15:42:11.0283 (UTC) FILETIME=[7472FA30:01C36668]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tuesday, August 12, 2003, Zwane Mwaikambo wrote
>> +#ifdef CONFIG_PCI_MSI
>> +			/* Is this an active MSI? */
>> +			if (msi_desc[j])
>> +				continue;
>> +#endif

>> Since the code determinces whether this entry is NULL or not, I think any  
>> locking for msi_desc may not be required.

>Yes but there is other code which modifies msi_desc members. i think a per 
>msi_desc lock is needed. You could also use a kmem_cache to allocate them, 
>and perhaps utilise HWCACHE_ALIGN.
We will have set_affinity support for MSI in our next update release. The above
code will be deleted. Utilize HWCACHE_ALIGN to allocate msi_desc is a good
suggestion. Thanks!

On Thu, 7 Aug 2003, Zwane Mwaikambo wrote:
>> - Change the interface name from msi_free_vectors to msix_free_vectors since 
>> this interface is used for MSI-X device drivers, which request for releasing 
>> the number of vector back to the PCI subsystem.
>> - Change the function name from remove_hotplug_vectors to 
>> msi_remove_pci_irq_vectors to have a close match with function name 
>> msi_get_pci_irq_vector.

>I think the vector allocator code can all be arch specific generic, 
>there is no particular reason as to why it has to be MSI specific.
Some IHVs suggest changing the interface names from msi_alloc_vectors/
msi_free_vectors to msix_alloc_vectors/msix_free_vectors. You have a good point 
of keeping these generic. Agree.

Thanks,
Long

