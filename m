Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbUBTSj2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 13:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbUBTSj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 13:39:27 -0500
Received: from fmr05.intel.com ([134.134.136.6]:14529 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261256AbUBTSgX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 13:36:23 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH]2.6.3-rc2 MSI Support for IA64
Date: Fri, 20 Feb 2004 10:36:12 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024040580FB@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]2.6.3-rc2 MSI Support for IA64
Thread-Index: AcP30l1mjqZad5o9Qq20aKppHWasDgACEdig
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Andreas Schwab" <schwab@suse.de>
Cc: <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Luck, Tony" <tony.luck@intel.com>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 20 Feb 2004 18:36:13.0037 (UTC) FILETIME=[6AA3F1D0:01C3F7E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friday, Feb. 20, 2004 8:55 AM, Andreas Schwab wrote:

>> @@ -316,6 +310,19 @@
>>  	return current_vector;
>>  }
>>  
>> +int ia64_alloc_vector(void)
>> +{
>> +	static int next_vector = IA64_FIRST_DEVICE_VECTOR;
>> +
>> +	if (next_vector > IA64_LAST_DEVICE_VECTOR)
>> +		/* XXX could look for sharable vectors instead of panic'ing... */
>> +		panic("ia64_alloc_vector: out of interrupt vectors!");
>> +
>> +	nr_alloc_vectors++;
>> +
>> +	return next_vector++;
>> +}
>> +

> IMHO this should be CONFIG_IA64 only.

To avoid some #ifdef statements as possible, "ia64_platform" 
defined in the header file "msi.h" is set to TRUE only if 
setting CONFIG_IA64 to 'Y'. The setting of ia64_platform
to TRUE will execute function ia64_alloc_vector.

This API is only used in assign_msi_vector()in msi.c:

	vector = (ia64_platform ? ia64_alloc_vector() :
		assign_irq_vector(MSI_AUTO));

Thanks,
Long
