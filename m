Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161217AbWKEIB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161217AbWKEIB6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 03:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965848AbWKEIB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 03:01:58 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:34003 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S965847AbWKEIB6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 03:01:58 -0500
Message-ID: <454D9A75.7010204@vmware.com>
Date: Sun, 05 Nov 2006 00:01:57 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Benjamin LaHaise <bcrl@kvack.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc patch] i386: don't save eflags on task switch
References: <200611040200_MC3-1-D04D-6EA3@compuserve.com> <20061105035556.GQ9057@kvack.org> <Pine.LNX.4.64.0611041959260.25218@g5.osdl.org> <200611050641.14724.ak@suse.de>
In-Reply-To: <200611050641.14724.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> For me, when compiled with -O2, it results in
>>
>> 	84
>> 	88
>> 	132
>>
>> which basically says: a "rdtsc->rdtsc" is 84 cycles, putting a "pushfl" in 
>> between is another _4_ cycles, and putting a "popfl" in between is about 
>> another 48 cycles. 
>>     
>
> This means we should definitely change restore_flags() to only STI, 
> never popf
>   

sti is expensive as well; iirc just as expensive on most processors as 
popf, although I don't have hard numbers to back this up on hand.  An 
_unlikely_ jcc + popf? is better than a sti, for sure, but a likely 
jcc+popf could cost more than a jcc+sti, depending on model.

Zach
