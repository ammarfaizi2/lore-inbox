Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWHVJVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWHVJVY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 05:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWHVJVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 05:21:24 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54189 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751084AbWHVJVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 05:21:23 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: Magnus Damm <magnus@valinux.co.jp>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: Reload CS when startup_64 is used.
References: <20060821095328.3132.40575.sendpatchset@cherry.local>
	<1156208306.21411.85.camel@localhost>
	<m1u045sagu.fsf@ebiederm.dsl.xmission.com>
	<200608221003.12608.ak@suse.de>
	<m1y7thqi7b.fsf_-_@ebiederm.dsl.xmission.com>
	<20060822110106.7582fcb9.ak@suse.de>
Date: Tue, 22 Aug 2006 03:20:54 -0600
In-Reply-To: <20060822110106.7582fcb9.ak@suse.de> (Andi Kleen's message of
	"Tue, 22 Aug 2006 11:01:06 +0200")
Message-ID: <m1psetqg7d.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Tue, 22 Aug 2006 02:37:44 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> 
>> In long mode the %cs is largely a relic.  However there are a few cases
>> like lret 
>
> You mean iret?

Yes, sorry.

>
>> +	 * jump.  In addition we need to ensure %cs is set so we make this
>> +	 * a far return.	
>>  	 */
>>  	movq	initial_code(%rip),%rax
>> -	jmp	*%rax
>> +	pushq	$__KERNEL_CS
>> +	pushq	%rax
>> +	lretq
>
> Ok merged thanks
>
> -Andi
