Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWARRqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWARRqI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 12:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWARRqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 12:46:08 -0500
Received: from fmr19.intel.com ([134.134.136.18]:35225 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751381AbWARRqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 12:46:07 -0500
Message-ID: <43CE7EDB.7030201@ichips.intel.com>
Date: Wed, 18 Jan 2006 09:46:03 -0800
From: Sean Hefty <mshefty@ichips.intel.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Grundler <iod00d@hp.com>
CC: Sean Hefty <sean.hefty@intel.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] RE: [PATCH 2/5] [RFC] Infiniband: connection
 abstraction
References: <ORSMSX401FRaqbC8wSA0000003e@orsmsx401.amr.corp.intel.com>	<ORSMSX401FRaqbC8wSA00000040@orsmsx401.amr.corp.intel.com> <20060118020342.GB3740@esmail.cup.hp.com>
In-Reply-To: <20060118020342.GB3740@esmail.cup.hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
>>+static void cm_mask_compare_data(u8 *dst, u8 *src, u8 *mask)
>>+{
>>+	int i;
>>+
>>+	for (i = 0; i < IB_CM_PRIVATE_DATA_COMPARE_SIZE; i++)
>>+		dst[i] = src[i] & mask[i];
>>+}
> 
> Is this code going to get invoked very often?

In practice, it would be invoked when matching any listen requests originating 
from the CMA (RDMA connection abstraction).

> If so, can the mask operation use a "native" size since
> IB_CM_PRIVATE_DATA_COMPARE_SIZE is hard coded to 64 byte?
> 
> e.g something like:
> 	for (i = 0; i < IB_CM_PRIVATE_DATA_COMPARE_SIZE/sizeof(unsigned long);
> 									i++)
> 		((unsigned long *)dst)[i] = ((unsigned long *)src)[i] 
> 						& ((unsigned long *)mask)[i];

Yes - something like this should work.  Thanks.

- Sean
