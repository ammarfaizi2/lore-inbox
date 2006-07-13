Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751542AbWGMObG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbWGMObG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 10:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbWGMObG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 10:31:06 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:62404 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751542AbWGMObF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 10:31:05 -0400
Message-ID: <44B65924.7060602@us.ibm.com>
Date: Thu, 13 Jul 2006 07:31:00 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: HOLZHEU@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 hypfs fixes for 2.6.18-rc1-mm1
References: <44B5C7CE.6090606@us.ibm.com>	<44B5C971.7030403@us.ibm.com> <20060713022304.9291852d.akpm@osdl.org>
In-Reply-To: <20060713022304.9291852d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 12 Jul 2006 21:17:53 -0700
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
>   
>> +static ssize_t hypfs_aio_read(struct kiocb *iocb, const struct iovec *iov,
>> +			      unsigned long nr_segs, loff_t offset)
>>  {
>>  	char *data;
>>  	size_t len;
>>  	struct file *filp = iocb->ki_filp;
>> +	/* XXX: temporary */
>> +	char __user *buf = iov[0].iov_base;
>> +	size_t count = iov[0].iov_len;
>> +
>> +	if (nr_segs != 1) {
>> +		count = -EINVAL;
>> +		goto out;
>> +	}
>>     
>
> err, "temporary" things tend to become permanent.  What's the real fix?
>   
I am not sure, if we really need to vectorize this method or not - 
meaning will this be ever called
with more than one items in the vector. 

Micheal, is it possible ? Can some one directly use AIO interface on 
hypfs ? If not, we can always
look at only first element and ignore rest of them. Otherwise, we need 
to iterate on all the elements
of the vector.

Thanks,
Badari


