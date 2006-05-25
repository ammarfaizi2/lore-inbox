Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWEYCUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWEYCUE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 22:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbWEYCUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 22:20:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50838 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964807AbWEYCUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 22:20:02 -0400
To: vgoyal@in.ibm.com
Cc: Magnus Damm <magnus@valinux.co.jp>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [Fastboot] Re: [PATCH 02/03] kexec: Avoid overwriting the
 current pgd (V2, i386)
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
	<20060524044242.14219.50618.sendpatchset@cherry.local>
	<20060524225845.GB23291@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 24 May 2006 20:18:57 -0600
In-Reply-To: <20060524225845.GB23291@in.ibm.com> (Vivek Goyal's message of
 "Wed, 24 May 2006 18:58:45 -0400")
Message-ID: <m164juu9ri.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Wed, May 24, 2006 at 01:40:41PM +0900, Magnus Damm wrote:
>>  
>> @@ -170,45 +151,16 @@ void machine_kexec_cleanup(struct kimage
>>  NORET_TYPE void machine_kexec(struct kimage *image)
>>  {
>>  	unsigned long page_list;
>> -	unsigned long reboot_code_buffer;
>> -
>> +	unsigned long control_code;
>> +	unsigned long page_table_a;
>>  	relocate_new_kernel_t rnk;
>>  
>> -	/* Interrupts aren't acceptable while we reboot */
>> -	local_irq_disable();
>
> Why are you getting rid of this call? Looks sane to disable interrupts
> early.

Agreed, this and changing the segment and idt handling is gratuitous.
If you are going to make multiple unrelated changes place do them
as separate patches.

Eric
