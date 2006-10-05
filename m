Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWJEBld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWJEBld (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 21:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWJEBld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 21:41:33 -0400
Received: from terminus.zytor.com ([192.83.249.54]:28553 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751313AbWJEBlc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 21:41:32 -0400
Message-ID: <45246276.6000908@zytor.com>
Date: Wed, 04 Oct 2006 18:40:06 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Reinette Chatre <reinette.chatre@linux.intel.com>,
       Joe Korty <joe.korty@ccur.com>,
       Inaky Perez-Gonzalez <inaky@linux.intel.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitmap: separate bitmap parsing for user buffer and kernel
 buffer
References: <200610041756.30528.reinette.chatre@linux.intel.com> <20061004181003.6dae6065.akpm@osdl.org>
In-Reply-To: <20061004181003.6dae6065.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 4 Oct 2006 17:56:30 -0700
> Reinette Chatre <reinette.chatre@linux.intel.com> wrote:
> 
>> +			if (is_user) {
>> +				if (__get_user(c, buf++))
>> +					return -EFAULT;
>> +			}
>> +			else
>> +				c = *buf++;
> 
> Is this actually needed?  __get_user(kernel_address) works OK and (believe
> it or not, given all the stuff it involves) boils down to a single instruction.		

On some architectures, kernel and user space are separate, overlapping 
address spaces.

If __bitmap_parse was an inline (and not exported), this would be okay; 
as it is, you end up doing the test dynamically under all circumstances, 
even though in most (if not all) cases the address space is know a priori.

	-hpa
