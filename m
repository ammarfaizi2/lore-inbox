Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319112AbSIJN3F>; Tue, 10 Sep 2002 09:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319115AbSIJN3F>; Tue, 10 Sep 2002 09:29:05 -0400
Received: from quark.didntduck.org ([216.43.55.190]:27917 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S319112AbSIJN3E>; Tue, 10 Sep 2002 09:29:04 -0400
Message-ID: <3D7DF4B1.6010300@didntduck.org>
Date: Tue, 10 Sep 2002 09:33:37 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Venu Vadapalli <bvadapal@vt.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: vmalloc/vfree
References: <3D81FB0C@zathras>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venu Vadapalli wrote:
> Looking at vmalloc implementation, it fills the page table mappings (pgd and 
> pmd) of only init_mm. When other tasks access these pages their mappings are 
> updated on demand by the page fault handler, right? Vfree, also, updates the 
> entries of just init_mm and, of course, flushes the cache and the tlb. But 
> what about other tasks that have acquired mappings to these pages?
> 
> -Venu

The pagetables for the kernel space are shared between all processes, 
except for the top level which is why the page fault handler exists. 
The actual pages that make up the shared pagetables never change once 
allocated which is the reason we can be lazy about updating the top 
level table of each task.

--
				Brian Gerst


