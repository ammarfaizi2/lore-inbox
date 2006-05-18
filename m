Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWERUqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWERUqk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 16:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWERUqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 16:46:40 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:17092 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1751395AbWERUqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 16:46:39 -0400
In-Reply-To: <446CD6FF.30409@vmware.com>
References: <20060509084945.373541000@sous-sol.org> <20060509085154.802230000@sous-sol.org> <446CD6FF.30409@vmware.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <81aacc969cab9227fef758ca63b3da15@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 17/35] Segment register changes for Xen
Date: Thu, 18 May 2006 21:41:48 +0100
To: Zachary Amsden <zach@vmware.com>
X-Mailer: Apple Mail (2.624)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18 May 2006, at 21:20, Zachary Amsden wrote:

>> 1. We clear FS/GS before changing TLS entries and switching LDT, as
>> otherwise the hypervisor will fail to restore thread-local values on
>> return to the guest kernel and we take a slow exception path.
>
>> @@ -647,6 +647,8 @@ struct task_struct fastcall * __switch_t
>>  	 */
>>  	savesegment(fs, prev->fs);
>>  	savesegment(gs, prev->gs);
>> +	clearsegment(fs);
>> +	clearsegment(gs);
>>
>
> Really not needed.  Think about it.  You can even speed up Xen.  I'm 
> glad the native operation here is a nop, but it should be 
> hypervisor_clearsegment or xen_clearsegment if you really want to keep 
> it.

Maybe you could explain in more detail? It's not needed for 
correctness, but it is faster for us to clear at that point.

  -- Keir

