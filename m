Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754494AbWKHJzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754494AbWKHJzi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 04:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754501AbWKHJzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 04:55:37 -0500
Received: from il.qumranet.com ([62.219.232.206]:8168 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1754496AbWKHJzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 04:55:00 -0500
Message-ID: <4551A970.9090704@qumranet.com>
Date: Wed, 08 Nov 2006 11:54:56 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>,
       kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/14] KVM: Kernel-based Virtual Machine (v4)
References: <454E4941.7000108@qumranet.com>	 <20061107204440.090450ea.akpm@osdl.org>	<adafycuh77b.fsf@cisco.com>	 <455183EA.2020405@qumranet.com> <20061107233323.c984fa9b.akpm@osdl.org>	 <45519033.3060409@qumranet.com> <1162978754.3138.266.camel@laptopd505.fenrus.org>
In-Reply-To: <1162978754.3138.266.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>> Would
>>> really prefer something at Kconfig-time, but we have no way of letting the
>>> assembler version feed into the Kconfig system (nor do we want it, I
>>> suspect).
>>>   
>>>       
>> config AS_VERSION
>>         eval as --version | awk '{ ... }'
>>     
>
>
> config time is not possible (not to mention it's not that uncommon to
> config on a different box than you compile). 

If we add the 'eval' Kconfig keyword, it becomes possible, but I guess 
it isn't worth it if there are more users and anyway split 
configure/compile, as you note, breaks it.


> Makefile side is not that
> hard; in fact what you'd need is a very small check similar to
> scripts/gcc-x86_64-has-stack-protector.sh . While that checks a gcc
> feature, checking the VMX operations via a C program with inline asm is
> actually the most realistic test ANYWAY ...
>   

The problem with that is that the test comes too late: after we've 
configured.  Andrew wants to keep allmodconfig working, and for that we 
need to deselect CONFIG_KVM before compilation starts.

gcc.*protector.sh only affects the Makefile, not the configuration, AFAICT.

-- 
error compiling committee.c: too many arguments to function

