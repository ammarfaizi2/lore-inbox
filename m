Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWBWA7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWBWA7M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 19:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWBWA7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 19:59:12 -0500
Received: from terminus.zytor.com ([192.83.249.54]:39657 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751422AbWBWA7K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 19:59:10 -0500
Message-ID: <43FD08D8.70300@zytor.com>
Date: Wed, 22 Feb 2006 16:59:04 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: bcrl@kvack.org, klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: sys_mmap2 on different architectures
References: <43FCDB8A.5060100@zytor.com>	<20060223001411.GA20487@kvack.org> <20060222.164347.12864037.davem@davemloft.net>
In-Reply-To: <20060222.164347.12864037.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: Benjamin LaHaise <bcrl@kvack.org>
> Date: Wed, 22 Feb 2006 19:14:11 -0500
> 
> 
>>The sys_mmap2() ABI is that the page shift is always fixed to whatever 
>>page size is reasonable for the architecture, typically 2^12.  The syscall 
>>should never be exposed as mmap2(), only as the large file size version 
>>of mmap() (aka mmap64()).  The other consideration is that it should not 
>>be implemented in 64 bit ABIs, as those machines should be using a 64 bit 
>>native mmap().  Does that clear things up a bit?  Cheers,
> 
> 
> Aha, that part I didn't catch.  Thanks for the clarification
> Ben.
> 
> I wonder why we did things that way with a fixed shift...

Except the above doesn't seem to match reality on anything other than 
SPARC, and the architectures where the shift is 12 anyway because that's 
the only pagesize supported.

On the other hand, sys32_mmap2 on SPARC64 matches the SPARC32 sys_mmap2 
in that the shift is hard-coded to 12:

         .globl          sys32_mmap2
sys32_mmap2:
         sethi           %hi(sys_mmap), %g1
         jmpl            %g1 + %lo(sys_mmap), %g0
          sllx           %o5, 12, %o5


At this point, I'm more than willing to treat SPARC as a special case, 
but I really want to know what the rules actually _ARE_ as opposed to 
what they are supposed to be (which they clearly are not.)

	-hpa
