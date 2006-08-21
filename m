Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751840AbWHUKVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbWHUKVX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 06:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751843AbWHUKVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 06:21:23 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:20038 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751840AbWHUKVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 06:21:22 -0400
Message-ID: <44E9890F.2080708@de.ibm.com>
Date: Mon, 21 Aug 2006 12:21:03 +0200
From: Thomas Klein <osstklei@de.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: Jan-Bernd Themann <ossthema@de.ibm.com>, netdev@vger.kernel.org,
       Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: Re: [2.6.19 PATCH 2/7] ehea: pHYP interface
References: <200608181330.21507.ossthema@de.ibm.com> <20060818150600.GG5201@martell.zuzino.mipt.ru>
In-Reply-To: <20060818150600.GG5201@martell.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> On Fri, Aug 18, 2006 at 01:30:21PM +0200, Jan-Bernd Themann wrote:
>> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_phyp.c
>> +++ kernel/drivers/net/ehea/ehea_phyp.c
> 
>> +	hret = ehea_h_register_rpage(hcp_adapter_handle, pagesize, queue_type,
>> +				     eq_handle, log_pageaddr, count);
>> +	return hret;
> 
> Just
> 	return ehea_h_register_rpage(...);
> 
>> +	hret = ehea_h_register_rpage(hcp_adapter_handle, pagesize, queue_type,
>> +				     cq_handle, log_pageaddr, count);
>> +	return hret;
> 
> Ditto.
> 
>> +	hret = ehea_h_register_rpage(hcp_adapter_handle, pagesize, queue_type,
>> +				     qp_handle, log_pageaddr, count);
>> +	return hret;
>> +}
> 
> Ditto.

Returncode handling was reworked throughout the whole driver. Those assignments
were modified according to your suggestion.

>> +static inline int hcp_epas_ctor(struct h_epas *epas, u64 paddr_kernel,
>> +				u64 paddr_user)
>> +{
>> +	epas->kernel.fw_handle = (u64) ioremap(paddr_kernel, PAGE_SIZE);
>> +	epas->user.fw_handle = paddr_user;
>> +	return 0;
>> +}
>> +
>> +static inline int hcp_epas_dtor(struct h_epas *epas)
>> +{
>> +
>> +	if (epas->kernel.fw_handle)
>> +		iounmap((void *)epas->kernel.fw_handle);
>> +	epas->user.fw_handle = epas->kernel.fw_handle = 0;
>> +	return 0;
>> +}
> 
> Always returns 0;

Correct. They're returning void now.

Thanks
Thomas
