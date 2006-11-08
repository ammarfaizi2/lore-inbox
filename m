Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWKHKKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWKHKKa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 05:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWKHKK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 05:10:29 -0500
Received: from il.qumranet.com ([62.219.232.206]:29414 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S932106AbWKHKK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 05:10:29 -0500
Message-ID: <4551AD0A.4080309@qumranet.com>
Date: Wed, 08 Nov 2006 12:10:18 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>,
       kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/14] KVM: Kernel-based Virtual Machine (v4)
References: <454E4941.7000108@qumranet.com>	 <20061107204440.090450ea.akpm@osdl.org>	<adafycuh77b.fsf@cisco.com>	 <455183EA.2020405@qumranet.com> <20061107233323.c984fa9b.akpm@osdl.org>	 <45519033.3060409@qumranet.com>	 <1162978754.3138.266.camel@laptopd505.fenrus.org>	 <4551A970.9090704@qumranet.com> <1162980101.3138.276.camel@laptopd505.fenrus.org>
In-Reply-To: <1162980101.3138.276.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>> The problem with that is that the test comes too late: after we've 
>> configured.  Andrew wants to keep allmodconfig working, and for that we 
>> need to deselect CONFIG_KVM before compilation starts.
>>     
>
> not really. You can also select to just not compile kvm at all *from the
> Makefile*
>   

Yes.  And then a real user (not an allmodconfig user) selects CONFIG_KVM 
and wonders where it went.

For users, we want it to fail fatally.  For allmodconfig, we want it to 
succeed but don't care about the output.


>> gcc.*protector.sh only affects the Makefile, not the configuration, AFAICT.
>>     
>
> but it is the Makefile that goes into the kvm directory and compiles
> stuff!
>
> yes it's ugly and not so elegant, but it's effective and you can warn
> bigtime via nasty messages if you want ;)
>   

We already have an ugly solution:

    #define VMLAUNCH ".byte 0x0f, foo, bar"

etc.  We were looking for an elegant one.

-- 
error compiling committee.c: too many arguments to function

