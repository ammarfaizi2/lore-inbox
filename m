Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267799AbTAHV46>; Wed, 8 Jan 2003 16:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267878AbTAHV46>; Wed, 8 Jan 2003 16:56:58 -0500
Received: from holomorphy.com ([66.224.33.161]:7565 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267799AbTAHV46>;
	Wed, 8 Jan 2003 16:56:58 -0500
Date: Wed, 8 Jan 2003 14:05:33 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH] allow bigger PAGE_OFFSET with PAE
Message-ID: <20030108220533.GD23814@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org
References: <3E1B334E.8030807@us.ibm.com> <20030107233713.GB23814@holomorphy.com> <3E1C9257.2040907@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E1C9257.2040907@us.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 12:06:38PM -0800, Dave Hansen wrote:
>>> Also, this gets the kernel's pagetables right, but neglects 
>>> userspace's for now.  pgd_alloc() needs to be fixed to allocate 
>>> another PMD, if the split isn't PMD-alighed.

William Lee Irwin III wrote:
>> Um, that should be automatic when USER_PTRS_PER_PGD is increased.

On Wed, Jan 08, 2003 at 01:04:23PM -0800, Dave Hansen wrote:
> Nope, you need a little bit more.  pgd_alloc() relies on its memcpy() 
> to provide the kernel mappings.  After the last user PMD is allocated, 
> you still need to copy the kernel-shared part of it in.

See the bit about rounding up. Then again, the pmd entries don't get
filled in by any of that...


Bill
