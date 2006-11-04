Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753665AbWKDTTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665AbWKDTTy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 14:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753667AbWKDTTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 14:19:54 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:17575 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1753665AbWKDTTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 14:19:54 -0500
Message-ID: <454CE7D9.3070308@vmware.com>
Date: Sat, 04 Nov 2006 11:19:53 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386: remove IOPL check on task switch
References: <200611031900_MC3-1-D041-6F32@compuserve.com>
In-Reply-To: <200611031900_MC3-1-D041-6F32@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> In-Reply-To: <454B850C.3050402@vmware.com>
>
> On Fri, 03 Nov 2006 10:06:04 -0800, Zachary Amsden wrote:
>
>   
>> Chuck Ebbert wrote:
>>     
>>> IOPL is implicitly saved and restored on task switch,
>>> so explicit check is no longer needed.
>>>       
>> Nack.  This is used for paravirt-ops kernels that use IOPL'd userspace.  
>>     
>
> How does that work?  In the stock kernel, anything done by
> the call to set_iopl_mask() (that was removed by the patch)
> will be nullified by the 'popfl' at the end of the switch_to()
> macro.
>   

Who put a popfl back in switch_to?  I took it out some time ago.  It 
should not be there.  The only reason for it was to stop IOPL leaking 
from one process to another from a sleep during a sysenter based system 
call.

Zach
