Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWHNNc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWHNNc4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 09:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWHNNc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 09:32:56 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:54960 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751316AbWHNNcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 09:32:55 -0400
Message-ID: <44E07267.7070007@de.ibm.com>
Date: Mon, 14 Aug 2006 14:53:59 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: michael@ellerman.id.au
CC: netdev <netdev@vger.kernel.org>, Thomas Klein <tklein@de.ibm.com>,
       linux-ppc <linuxppc-dev@ozlabs.org>,
       Christoph Raisch <raisch@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>
Subject: Re: [PATCH 4/6] ehea: header files
References: <44D99F56.7010201@de.ibm.com> <1155190921.9801.43.camel@localhost.localdomain>
In-Reply-To: <1155190921.9801.43.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman wrote:
>> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea.h	1969-12-31 16:00:00.000000000 -0800
>> +++ kernel/drivers/net/ehea/ehea.h	2006-08-08 23:59:39.927452928 -0700
>> +
>> +#define EHEA_PAGESHIFT  12
>> +#define EHEA_PAGESIZE   4096UL
>> +#define EHEA_CACHE_LINE 128
> 
> This looks like a very bad idea, what happens if you're running on a
> machine with 64K pages?
> 

The EHEA_PAGESIZE define is needed for queue management to hardware side.

>> +
>> +#define EHEA_ENABLE	1
>> +#define EHEA_DISABLE	0
> 
> Do you really need hash defines for 0 and 1 ? They're fairly well
> understood in C as meaning true and false.
> 

removed

>> +
>> +/*
>> + *  h_galpa:
>> + *  for pSeries this is a 64bit memory address where
>> + *  I/O memory is mapped into CPU address space
>> + */
>> +
>> +struct h_galpa {
>> +	u64 fw_handle;
>> +};
> 
> What is a h_galpa? And why does it need a struct if it's just a u64?
> 

The eHEA chip is not PCI attached but directly connected to a proprietary
bus. Currently, we can access it by a simple 64 bit address, but this is not
true in all cases. Having a struct here allows us to encapsulate the chip
register access and to respond to changes to system hardware.

We'll change the name to h_epa meaning "ehea physical address"

>> +
>> +struct h_galpas {
>> +	struct h_galpa kernel;	/* kernel space accessible resource,
>> +				   set to 0 if unused */
>> +	struct h_galpa user;	/* user space accessible resource
>> +				   set to 0 if unused */
>> +	u32 pid;		/* PID of userspace galpa checking */
>> +};
>> +

>> +struct port_res_cfg {
>> +	int max_entries_rcq;
>> +	int max_entries_scq;
>> +	int max_entries_sq;
>> +	int max_entries_rq1;
>> +	int max_entries_rq2;
>> +	int max_entries_rq3;
>> +};
> 
> Enormous structs with no comments.
> 

changed

Regards,
Jan-Bernd
