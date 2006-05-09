Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWEITsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWEITsN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbWEITsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:48:13 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:3978 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750980AbWEITsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:48:12 -0400
Message-ID: <4460F1F0.7000602@us.ibm.com>
Date: Tue, 09 May 2006 14:48:00 -0500
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Hollis Blanchard <hollisb@us.ibm.com>
CC: Christoph Hellwig <hch@infradead.org>, Chris Wright <chrisw@sous-sol.org>,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org, Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [Xen-devel] Re: [RFC PATCH 03/35] Add Xen interface header files
References: <20060509084945.373541000@sous-sol.org>	<20060509085147.903310000@sous-sol.org>	<20060509151516.GA16332@infradead.org> <1147203309.19485.62.camel@basalt.austin.ibm.com>
In-Reply-To: <1147203309.19485.62.camel@basalt.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hollis Blanchard wrote:
> On Tue, 2006-05-09 at 16:15 +0100, Christoph Hellwig wrote:
>   
>>> +#ifdef __XEN__
>>> +#define __DEFINE_GUEST_HANDLE(name, type) \
>>> +    typedef struct { type *p; } __guest_handle_ ## name
>>> +#else
>>> +#define __DEFINE_GUEST_HANDLE(name, type) \
>>> +    typedef type * __guest_handle_ ## name
>>> +#endif
>>>       
>> please get rid of all these stupid typedefs 
>>     
>
> These typedefs are a new hack to work around a basic interface problem:
> instead of explicitly-sized types, Xen uses longs and pointers in its
> interface. On PowerPC in particular, where we need a 32-bit userland
> communicating with a 64-bit hypervisor, those types don't work.
>
> However, the maintainers are reluctant to switch the interface to use
> explicitly-sized types because it would break binary compatibility.
> These ugly "HANDLE" macros allow PowerPC to do what we need without
> affecting binary compatibility on x86.
>   

Is this strictly true though?  The ABI for Power and x86 are not 
necessarily dependent on each other.  One could just as easily define a 
typedef like:

#if defined(__ppc__)
typedef uint64_t guest_handle_t;
#elif defined(__x86__)
typedef unsigned long guest_handle_t;
#endif

I thought the use of GUEST_HANDLE was to maintain type safety.  It 
certainly helps the issue you point out but it's not strictly necessary.

IMHO, this trick makes the code pretty ugly.  I'd rather see it 
disappear in favor of something more akin to the above.

Regards,

Anthony Liguori

