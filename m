Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWDDWC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWDDWC1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 18:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWDDWC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 18:02:27 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:3332 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750762AbWDDWC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 18:02:26 -0400
Message-ID: <4432ECF1.8040606@vmware.com>
Date: Tue, 04 Apr 2006 15:02:25 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: ebiederm@xmission.com, bunk@stusta.de, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net, fastboot@osdl.org
Subject: Re: 2.6.17-rc1-mm1: KEXEC became SMP-only
References: <20060404014504.564bf45a.akpm@osdl.org>	<20060404162921.GK6529@stusta.de>	<m1acb15ja2.fsf@ebiederm.dsl.xmission.com>	<4432B22F.6090803@vmware.com>	<m1irpp41wx.fsf@ebiederm.dsl.xmission.com>	<4432C7AC.9020106@vmware.com> <20060404132546.565b3dae.akpm@osdl.org>
In-Reply-To: <20060404132546.565b3dae.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>
>>  struct subarch_hooks subarch_hook_vector = {
>>       .machine_power_off = machine_power_off,
>>       .machine_halt = machine_halt,
>>       .machine_irq_setup = machine_irq_setup,
>>       .machine_subarch_setup = machine_subarch_probe
>>       ...
>>  };
>>
>>  And machine_subarch_probe can dynamically change this vector if it 
>>  confirms that the platform is appropriate?
>>     
>
> I don't recall anyone expressing any desire for the ability to set these
> things at runtime.  Unless there is such a requirement I'd suggest that the
> best way to address Eric's point is to simply rename the relevant functions
> from foo() to subarch_foo().
>   

Avoiding the runtime assignment isn't possible if you want a generic 
subarch that truly can run on multiple different platforms.

I prefer runtime assignment not for this reason, but simply because it 
also eliminates two artifacts:

1) You can add new subarch hooks without breaking every other 
sub-architecture
2) You don't need #ifdef SUBARCH_FUNC_FOO goo to do this (renaming 
voyager_halt -> default)

Zach
