Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWHCEyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWHCEyV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 00:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWHCEyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 00:54:21 -0400
Received: from terminus.zytor.com ([192.83.249.54]:23960 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932255AbWHCEyU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 00:54:20 -0400
Message-ID: <44D1815C.1040508@zytor.com>
Date: Wed, 02 Aug 2006 21:53:48 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Don Zickus <dzickus@redhat.com>, fastboot@osdl.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [RFC] ELF Relocatable x86 and x86_64 bzImages
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>	<20060802183709.GJ3435@redhat.com> <m1wt9qr5ur.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1wt9qr5ur.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Don Zickus <dzickus@redhat.com> writes:
> 
>>> There is one outstanding issue where I am probably requiring too much
>> alignment
>>> on the arch/i386 kernel.  
>> There was posts awhile ago about optimizing the kernel performance by
>> loading it at a 4MB offset.  
>>
>> http://www.lkml.org/lkml/2006/2/23/189
>>
>> Your changes breaks that on i386 (not aligned on a 4MB boundary).  But a
>> 5MB offset works.  Is that the correct update or does that break the
>> original idea?
> 
> That patch should still apply and work as described.
> 
> Actually when this stuipd cold I have stops slowing me down,
> and I fix the alignment to what it really needs to be ~= 8KB.
> 
> Then bootloaders should be able to make the decision.
> 
> HPA Does that sound at all interesting?
> 

I'm sorry, it's not clear to me what you're asking here.

The bootloaders will load bzImage at the 1 MB point, and it's up to the 
decompressor to locate it appropriately.  It has (correctly) been 
pointed out that it would be faster if the decompressed kernel is 
located to the 4 MB point -- large pages don't work below 2/4 MB due to 
interference with the fixed MTRRs -- but that's doesn't affect the boot 
protocol in any way.

I was under the impression that your relocatable patches allows the boot 
loader to load the bzImage at a different address than the usual 
0x100000; but again, that shouldn't affect the kernel's final resting place.

	-hpa

