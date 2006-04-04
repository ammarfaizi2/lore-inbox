Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWDDRoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWDDRoZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 13:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWDDRoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 13:44:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50062 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750773AbWDDRoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 13:44:25 -0400
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       linux-kernel@vger.kernel.org, rdunlap@xenotime.net, fastboot@osdl.org
Subject: Re: 2.6.17-rc1-mm1: KEXEC became SMP-only
References: <20060404014504.564bf45a.akpm@osdl.org>
	<20060404162921.GK6529@stusta.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 04 Apr 2006 11:43:01 -0600
In-Reply-To: <20060404162921.GK6529@stusta.de> (Adrian Bunk's message of
 "Tue, 4 Apr 2006 18:29:21 +0200")
Message-ID: <m1acb15ja2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> On Tue, Apr 04, 2006 at 01:45:04AM -0700, Andrew Morton wrote:
>>...
>> Changes since 2.6.16-mm2:
>>...
>> +x86-clean-up-subarch-definitions.patch
>>...
>>  x86 updates.
>>...
>
> The following looks bogus:

It is. 

>
>  config KEXEC
>         bool "kexec system call (EXPERIMENTAL)"
> -       depends on EXPERIMENTAL
> +       depends on EXPERIMENTAL && (!X86_VOYAGER && SMP)
>
> The dependencies do now say that KEXEC is only offered for machines that 
> are _both_ non-Voyager and SMP.
>
> Is the problem you wanted to express that a non-SMP Voyager config 
> didn't compile?
>
> AFAIR I recently sent a patch disallowing non-SMP Voyager configurations 
> that wasn't yet applied.

I think this cleanup patch is even going in the wrong direction.  The
subarch code right now is a real pain because it is never clear when
you are calling a function with multiple definitions.  Which makes it
really easy to break.

If we are going to refactor this can we please move in the direction
of a machine vector like alpha, ppc, and arm.  I don't see the current
this cleanup making it any easier to tell there is code in a subarch.

Eric
