Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbVJaB1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbVJaB1h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 20:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbVJaB1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 20:27:37 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:44883 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751269AbVJaB1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 20:27:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=vF1/UnORzCNk38qXjPRKj1R5eEkdjGKbxhl8iSqkAfOBRFsucE4VwqDnpzSPqXABVGv/tyZwQnRsJuhRcf2KNyzVAE1qNmH6ZKg96yCveTp2IkBehQ53T40VJoVtZA1/sUSczowv92dXPQ3MuQQtn6j8bK8BfPgEXVM582kl6uU=  ;
Message-ID: <4365736B.4050506@yahoo.com.au>
Date: Mon, 31 Oct 2005 12:29:15 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/5] i386 generic cmpxchg
References: <436416AD.3050709@yahoo.com.au> <4364171C.7020103@yahoo.com.au> <Pine.LNX.4.61.0510301157440.1526@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0510301157440.1526@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> Hi Nick,
> 
> On Sun, 30 Oct 2005, Nick Piggin wrote:
> 
> +#define cmpxchg(ptr,o,n)						\
> +({									\
> +	__typeof__(*(ptr)) __ret;					\
> +	if (likely(boot_cpu_data.x86 > 3))				\
> +		__ret = __cmpxchg((ptr), (unsigned long)(o),		\
> +					(unsigned long)(n), sizeof(*(ptr))); \
> +	else								\
> +		__ret = cmpxchg_386((ptr), (unsigned long)(o),		\
> +					(unsigned long)(n), sizeof(*(ptr))); \
> +	__ret;								\
> +})
> +#endif
> 
> How about something similar to the following to remove the branch on 
> optimised kernels?
> 

Hi Zwane,
This is only in the !CONFIG_X86_CMPXCHG case, though, so the branch would
only be there on a 386 kernel, I think?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
