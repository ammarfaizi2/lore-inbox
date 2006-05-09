Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWEIQCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWEIQCT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWEIQCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:02:19 -0400
Received: from dvhart.com ([64.146.134.43]:14307 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1750820AbWEIQCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:02:18 -0400
Message-ID: <4460BD03.4000404@mbligh.org>
Date: Tue, 09 May 2006 09:02:11 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 15/35] subarch support for controlling interrupt delivery
References: <20060509084945.373541000@sous-sol.org> <20060509085154.095325000@sous-sol.org> <4460AC06.4000303@mbligh.org> <20060509155153.GJ7834@cl.cam.ac.uk>
In-Reply-To: <20060509155153.GJ7834@cl.cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Limpach wrote:
> On Tue, May 09, 2006 at 07:49:42AM -0700, Martin J. Bligh wrote:
> 
>>>+#define __cli()							 \
>>>+do {									\
>>>+	struct vcpu_info *_vcpu;					\
>>>+	preempt_disable();						\
>>>+	_vcpu = &HYPERVISOR_shared_info->vcpu_info[__vcpu_id];		\
>>>+	_vcpu->evtchn_upcall_mask = 1;					\
>>>+	preempt_enable_no_resched();					\
>>>+	barrier();							\
>>>+} while (0)
>>
>>Should be a real function
> 
> 
> Yes, except it's not trivially done because if __cli was an inline
> function, you need to have everything that is used in the declaration
> defined when the function is declared as opposed to when the #define
> gets used.  I'll give it another try, but it very quickly becomes
> #include hell.
> 
> Anybody want to comment on the performance impact of making
> local_irq_* non-inline functions?

I wasn't concerned with inline vs non-inline - that's your choice.
Just the inherent foulness of multi-line macros ;-)

M.


