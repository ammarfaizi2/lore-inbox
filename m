Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267918AbTAHU4f>; Wed, 8 Jan 2003 15:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267919AbTAHU4e>; Wed, 8 Jan 2003 15:56:34 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:6789 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267918AbTAHU4e>;
	Wed, 8 Jan 2003 15:56:34 -0500
Message-ID: <3E1C9257.2040907@us.ibm.com>
Date: Wed, 08 Jan 2003 13:04:23 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH] allow bigger PAGE_OFFSET with PAE
References: <3E1B334E.8030807@us.ibm.com> <20030107233713.GB23814@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Tue, Jan 07, 2003 at 12:06:38PM -0800, Dave Hansen wrote:
> 
>>Also, this gets the kernel's pagetables right, but neglects 
>>userspace's for now.  pgd_alloc() needs to be fixed to allocate 
>>another PMD, if the split isn't PMD-alighed.
> 
> Um, that should be automatic when USER_PTRS_PER_PGD is increased.

Nope, you need a little bit more.  pgd_alloc() relies on its memcpy() 
to provide the kernel mappings.  After the last user PMD is allocated, 
you still need to copy the kernel-shared part of it in.

-- 
Dave Hansen
haveblue@us.ibm.com

