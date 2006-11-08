Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754427AbWKHIHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754427AbWKHIHU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 03:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754429AbWKHIHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 03:07:19 -0500
Received: from il.qumranet.com ([62.219.232.206]:21717 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1754427AbWKHIHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 03:07:18 -0500
Message-ID: <45519033.3060409@qumranet.com>
Date: Wed, 08 Nov 2006 10:07:15 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Roland Dreier <rdreier@cisco.com>, kvm-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/14] KVM: Kernel-based Virtual Machine (v4)
References: <454E4941.7000108@qumranet.com>	<20061107204440.090450ea.akpm@osdl.org>	<adafycuh77b.fsf@cisco.com>	<455183EA.2020405@qumranet.com> <20061107233323.c984fa9b.akpm@osdl.org>
In-Reply-To: <20061107233323.c984fa9b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 08 Nov 2006 09:14:50 +0200
> Avi Kivity <avi@qumranet.com> wrote:
>
>   
>> Roland Dreier wrote:
>>     
>>>  > That's gas 2.16.1.  I assume it needs some super-new binutils.
>>>  > 
>>>  > I'm not sure what to do about this.  What's the minimum version?
>>>
>>> According to http://kvm.sourceforge.net/howto.html :
>>>     A recent enough binutils (>= 2.16.91.0.2) for vmx instruction support
>>>   
>>>       
>> Either that or a bunch of ugly .byte macros.
>>
>>     
>
> I think we could live with the binutils requirement as long as we can find
> some automagic way of not breaking people's `make allmodconfig'.  Because
> quite a lot of those people who do cross-compilation tend to use older
> binutilses.
>   

These crosses are usually for $wierd target on x86 host, right?  But no 
one will compile kvm for non-x86:

        depends on X86 && EXPERIMENTAL

> But I don't know how to do that.  We _could_ do a trick similar to the
> `cc-version' make rule, and then use the new `as-version' to make the whole
> kvm.o compile down to an empty .o file.  But that's pretty hacky.  

Not only hacky, it will confuse the regular user who gets a nonworking 
kvm.ko due to old binutils.


> Would
> really prefer something at Kconfig-time, but we have no way of letting the
> assembler version feed into the Kconfig system (nor do we want it, I
> suspect).
>   

config AS_VERSION
        eval as --version | awk '{ ... }'

?

-- 
error compiling committee.c: too many arguments to function

