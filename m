Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753688AbWKDTjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688AbWKDTjK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 14:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753691AbWKDTjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 14:39:10 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:15786 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1753687AbWKDTjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 14:39:09 -0500
Message-ID: <454CEC5C.2050507@vmware.com>
Date: Sat, 04 Nov 2006 11:39:08 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386: remove IOPL check on task switch
References: <200611031900_MC3-1-D041-6F32@compuserve.com> <454CE7D9.3070308@vmware.com>
In-Reply-To: <454CE7D9.3070308@vmware.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:
> Chuck Ebbert wrote:
>> In-Reply-To: <454B850C.3050402@vmware.com>
>>
>> On Fri, 03 Nov 2006 10:06:04 -0800, Zachary Amsden wrote:
>>
>>  
>>> Chuck Ebbert wrote:
>>>    
>>>> IOPL is implicitly saved and restored on task switch,
>>>> so explicit check is no longer needed.
>>>>       
>>> Nack.  This is used for paravirt-ops kernels that use IOPL'd 
>>> userspace.      
>>
>> How does that work?  In the stock kernel, anything done by
>> the call to set_iopl_mask() (that was removed by the patch)
>> will be nullified by the 'popfl' at the end of the switch_to()
>> macro.
>>   
>
> Who put a popfl back in switch_to?  I took it out some time ago.  It 
> should not be there.  The only reason for it was to stop IOPL leaking 
> from one process to another from a sleep during a sysenter based 
> system call.

Ok, checking shows Linus put it back to stop NT leakage.  This is 
correct, but unlikely.  Would be nice to avoid it unless absolutely 
necessary.  Perhaps xor eflags old and new and only set_system_eflags() 
if non-ALU bits have changed.

Zach
