Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbVCSNC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbVCSNC7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbVCSNC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:02:59 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:48261 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262459AbVCSNC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:02:57 -0500
In-Reply-To: <20050319105632.GH31328@cl.cam.ac.uk>
References: <E1DBsgI-0001Cg-00@mta1.cl.cam.ac.uk> <m1k6o40x0p.fsf@ebiederm.dsl.xmission.com> <20050319105632.GH31328@cl.cam.ac.uk>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ca43c5769187191af6e1b3c3e91d4bf8@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, akpm@osdl.org,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>, linux-kernel@vger.kernel.org,
       riel@redhat.com, Ian.Pratt@cl.cam.ac.uk, kurt@garloff.de
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
Date: Sat, 19 Mar 2005 13:01:31 +0000
To: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 19 Mar 2005, at 10:56, Christian Limpach wrote:

>> For this specific case there may be another resolution but could
>> you please, please look at marking the missing pages PG_reserved
>> and not hacking phys_to_virt.
>>
>> At this point anything short of explicitly introducing an intermediate
>> step say virt_to_logical() logical_to_virt() will be extremely
>> confusing and lead to very hard to spot bugs.  Silently changing
>> the semantics of functions is bad.
>
> We also use the additional level of indirection to implement suspend/
> resume and relocation of virtual machines between physical machines  --
> you won't get the same sparse allocation of memory on the target 
> machine.
> Also, this will make it much easier to support hot plug memory at the
> hypervisor level since it will be able to substitute memory with very
> little support from the OS running in the virtual machine.

Also, more generally, I don't believe Linux would deal well with a 
highly fragmented memory map. I wonder how far Linux would boot if you 
PG_reserved every other page? We'd also need to deal with 
virtual<->lowmem not being a 1:1 mapping (at least for kernel code and 
data, as at least that obviously needs to be contiguous in virtual 
space).

  -- Keir

