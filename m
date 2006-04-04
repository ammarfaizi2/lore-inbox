Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWDDT0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWDDT0V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 15:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWDDT0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 15:26:21 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:63499 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750824AbWDDT0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 15:26:20 -0400
Message-ID: <4432C7AC.9020106@vmware.com>
Date: Tue, 04 Apr 2006 12:23:24 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, rdunlap@xenotime.net, fastboot@osdl.org
Subject: Re: 2.6.17-rc1-mm1: KEXEC became SMP-only
References: <20060404014504.564bf45a.akpm@osdl.org>	<20060404162921.GK6529@stusta.de>	<m1acb15ja2.fsf@ebiederm.dsl.xmission.com>	<4432B22F.6090803@vmware.com> <m1irpp41wx.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1irpp41wx.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
>
> If all you are doing is this one little clean up we can probably stop here.
> But this looks like a start on getting a vmi or xen subarch working.
>   

Yes, that is certainly part of the purpose.  But the subarch layer 
really should be cleaned up, and getting rid of code duplication seems 
like a good first step.

> If this is really a prelude to introducing more subarchitectures we
> need to fix the infrastructure, so it is obvious what is going on.
> I would really like to see a machine vector, so we could compile in
> multiple subarchitectures at the same time.  That makes building
> a generic kernel easier, and the requirement that the we need
> to build a generic kernel makes the structure of the subarchiteture
> hooks hierarchical and you wind up with code whose dependencies
> are visible.  Instead of the current linker and preprocessor magic.
> Functions named hook are impossible to comprehend what they
> are supposed to do while reading through the code.
>   

I see your point.  Are you thinking of something like:

struct subarch_hooks subarch_hook_vector = {
     .machine_power_off = machine_power_off,
     .machine_halt = machine_halt,
     .machine_irq_setup = machine_irq_setup,
     .machine_subarch_setup = machine_subarch_probe
     ...
};

And machine_subarch_probe can dynamically change this vector if it 
confirms that the platform is appropriate?

This gets rid of both the code duplication and makes it somewhat more 
obvious what is going on - plus it is easy to extend to other functions, 
and as a bonus feature, you don't need to change any code in other 
subarchitectures if you need to add a new hook.


Zach
