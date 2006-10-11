Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161521AbWJKVai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161521AbWJKVai (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161527AbWJKVae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:30:34 -0400
Received: from 1-1-8-31a.gmt.gbg.bostream.se ([82.182.75.118]:39664 "EHLO
	lin5.shipmail.org") by vger.kernel.org with ESMTP id S1161522AbWJKVa1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:30:27 -0400
Message-ID: <452D626E.9040606@tungstengraphics.com>
Date: Wed, 11 Oct 2006 23:30:22 +0200
From: =?ISO-8859-1?Q?Thomas_Hellstr=F6m?= <thomas@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: sv, en-us, en
MIME-Version: 1.0
To: Nick Piggin <npiggin@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 4/5] mm: add vm_insert_pfn helpler
References: <20061010121314.19693.75503.sendpatchset@linux.site> <20061010121357.19693.7339.sendpatchset@linux.site> <452CC383.4050401@tungstengraphics.com> <20061011112436.GA6835@wotan.suse.de>
In-Reply-To: <20061011112436.GA6835@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

>On Wed, Oct 11, 2006 at 12:12:19PM +0200, Thomas Hellstrom wrote:
>  
>
>>Nick, I just realized: would it be possible to have a pgprot_t argument 
>>to this one, instead of it using vma->vm_pgprot?
>>
>>The motivation for this (DRM again) is that some architectures (powerpc) 
>>cannot map the AGP aperture through IO space, but needs to remap the 
>>page from memory with a nocache attribute set. Others need special 
>>pgprot settings for write-combined mappings.
>>
>>Now, there's a possibility to change vma->vm_pgprot during the first 
>>->fault(), but again, we only have the mmap_sem in read mode.
>>    
>>
>
>I don't see a problem with that. It would be nice if vm_pgprot could
>be kept in synch with the pte protections, but I guess a crazy
>driver should be allowed to do anything it wants ;)
>
>
>  
>
:).
Actually, the caching bits are sort of left out from the mm code anyway. 
For example, mprotect will reset them, which is sort of a security risc, 
since an unpriviliged user can call mprotect on uncached page mappings, 
causing inconsistent mappings and stability problems.

Thomas

