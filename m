Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751561AbWBWAWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbWBWAWw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 19:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWBWAWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 19:22:52 -0500
Received: from terminus.zytor.com ([192.83.249.54]:15493 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751492AbWBWAWv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 19:22:51 -0500
Message-ID: <43FD0057.6030607@zytor.com>
Date: Wed, 22 Feb 2006 16:22:47 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
CC: klibc@zytor.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sys_mmap2 on different architectures
References: <43FCDB8A.5060100@zytor.com> <20060223001411.GA20487@kvack.org>
In-Reply-To: <20060223001411.GA20487@kvack.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> 
> The sys_mmap2() ABI is that the page shift is always fixed to whatever 
> page size is reasonable for the architecture, typically 2^12.  The syscall 
> should never be exposed as mmap2(), only as the large file size version 
> of mmap() (aka mmap64()).  The other consideration is that it should not 
> be implemented in 64 bit ABIs, as those machines should be using a 64 bit 
> native mmap().  Does that clear things up a bit?  Cheers,
> 

That was the theory, but that doesn't seem to be actually what's 
implemented.  At least on MIPS and PPC, where page size is variable (to 
the best of my knowledge), the shift seems to be whatever PAGE_SIZE the 
kernel was compiled with.  On the other hand, that's apparently what's 
implemented on SPARC (with the fixed offset of 12.)

	-hpa

