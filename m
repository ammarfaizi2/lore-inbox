Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVC2TVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVC2TVh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 14:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVC2TUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 14:20:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61625 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261317AbVC2TSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 14:18:17 -0500
Message-ID: <4249A9EA.10901@redhat.com>
Date: Tue, 29 Mar 2005 14:18:02 -0500
From: William Cohen <wcohen@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ananth@in.ibm.com
CC: SystemTAP <systemtap@sources.redhat.com>, akpm@osdl.org,
       prasanna@in.ibm.com, linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: kprobe_handler should  check pre_handler function
References: <424872C8.6080207@redhat.com> <20050329023408.GA4847@in.ibm.com>
In-Reply-To: <20050329023408.GA4847@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ananth N Mavinakayanahalli wrote:
> On Mon, Mar 28, 2005 at 04:10:32PM -0500, William Cohen wrote:
> 
> Hi Will,
> 
> 
>>I found kprobes expects there to be a pre_handler function in the 
>>structure. I was writing a probe that only needed a post_handler 
>>function, no pre_handler function. The probe was tracking the 
>>destinations of indirect calls and jumps, the probe needs to fire after 
>>the instruction single steps to get the target address. The probe 
>>crashed the machine because arch/i386/kernel/kprobe.c:kprobe_handler() 
>>blindly calls p->pre_handler().  There should be a check to verify that 
>>the pointer is non-null. There are cases where the pre_handler is not 
>>needed and it would make sense to set it to NULL. Thus, a check should 
>>be done for pre_handler like post_handler and fault_handler.
> 
> 
> You are right. The check for pre_handler is needed and here is a patch
> against 2.6.12-rc1-mm3 that does this.
> 
> Thanks,
> Ananth

Ananth,

Thanks. It looks like it addresses the problem. Could you see about 
getting this patch in the upstream kernel?

-Will


