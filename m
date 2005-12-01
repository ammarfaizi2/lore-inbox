Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbVLAA0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbVLAA0i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbVLAA0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 19:26:38 -0500
Received: from terminus.zytor.com ([192.83.249.54]:61625 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751406AbVLAA0h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 19:26:37 -0500
Message-ID: <438E432A.2010304@zytor.com>
Date: Wed, 30 Nov 2005 16:26:18 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
CC: Andrew Morton <akpm@osdl.org>, Adam Litke <agl@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Fix handling of ELF segments with zero filesize
References: <20051201002049.GB14247@localhost.localdomain>
In-Reply-To: <20051201002049.GB14247@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote:
> Andrew, please apply
> 
> mmap() returns -EINVAL if given a zero length, and thus elf_map() in
> binfmt_elf.c does likewise if it attempts to map a (page-aligned) ELF
> segment with zero filesize.  Such a situation never arises with the
> default linker scripts, but there's nothing inherently wrong with
> zero-filesize (but non-zero memsize) ELF segments.  Custom linker
> scripts can generate them, and the kernel should be able to map them;
> this patch makes it so.
> 

More than that: even with some versions of the default linker scripts 
they can be created, according to reports I have received on the klibc 
mailing list.  It just doesn't happen with glibc binaries.

This is a real bug and should be fixed.

	-hpa
