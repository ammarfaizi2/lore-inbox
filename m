Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263233AbUJ2Kwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263233AbUJ2Kwu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 06:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263236AbUJ2Kwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 06:52:50 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:59118 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263233AbUJ2Kwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 06:52:36 -0400
Message-ID: <418220C5.2030004@in.ibm.com>
Date: Fri, 29 Oct 2004 16:21:49 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, ebiederm@xmission.com, varap@us.ibm.com,
       fastboot@osdl.org
Subject: Re: Compile error on 2.6.10-rc1-mm1
References: <41820F72.5020203@in.ibm.com> <20041029024305.7bd9778c.akpm@osdl.org>
In-Reply-To: <20041029024305.7bd9778c.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Hariprasad Nellitheertha <hari@in.ibm.com> wrote:
> 
>>The compile time error that few people have been seeing with 
>> the last couple of -mm releases are due to the changes 
>> introduced to arch/i386/kernel/vmlinux.lds.S to enable kexec 
>> based crashdumps.
>>...
>> --- linux-2.6.10-rc1/arch/i386/kernel/vmlinux.lds.S~kdump-fix-bss-compile-error	2004-10-28 15:15:43.000000000 +0530
>> +++ linux-2.6.10-rc1-hari/arch/i386/kernel/vmlinux.lds.S	2004-10-28 15:18:04.000000000 +0530
>> @@ -117,8 +117,9 @@ SECTIONS
>>    /* freed after init ends here */
>>  	
>>    __bss_start = .;		/* BSS */
>> +  .bss.page_aligned  : AT(ADDR(.bss.page_aligned) - LOAD_OFFSET) {
>> +	*(.bss.page_aligned) }
>>    .bss : AT(ADDR(.bss) - LOAD_OFFSET) {
>> -	*(.bss.page_aligned)
>>  	*(.bss)
>>    }
>>    . = ALIGN(4);
> 
> 
> It's hard to see how that could go wrong.  Did you compare the before- and
> after- output from `objdump -h vmlinux'?
> 

The output of objdump for the bss related sections are as below..

Without patch - machine with newer binutils

  24 .bss          0002cf38  c03df000  003df000  002df000  2**12
                   ALLOC

With patch - machine with newer binutils

  24 .bss.page_aligned 00002000  c03df000  c03df000  002df000  2**2

  25 .bss          0002af38  c03e1000  003e1000  002df000  2**12
                   ALLOC

With patch - machine with old binutils

  24 .bss.page_aligned 00002000  c03df000  c03df000  002df000  2**2
                   CONTENTS
  25 .bss          0002af38  c03e1000  003e1000  002df000  2**12
                   ALLOC

Regards, Hari
