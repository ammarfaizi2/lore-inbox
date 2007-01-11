Return-Path: <linux-kernel-owner+w=401wt.eu-S965299AbXAKGQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965299AbXAKGQQ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 01:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965300AbXAKGQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 01:16:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:17785 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965299AbXAKGQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 01:16:15 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jzlb6oHzPH5DbkgLifpgBBm5PIFbF34oVUJXpp54Iwk5w6Qifv2xzys8ijN+IS+xUsdLvoycu49TPzifogi9p6Hyw7HVbL3UkyggxpNKrN8mqoWmGY2xRS6T9hL3THf8G+13CLYODPBfioN/kybWU+2yFacIt6z/YIopACXaq+U=
Message-ID: <71a0d6ff0701102216l7572bc6j10e3a810eab07b08@mail.gmail.com>
Date: Thu, 11 Jan 2007 09:16:14 +0300
From: "Alexander Shishkin" <alexander.shishckin@gmail.com>
To: Aubrey <aubreylee@gmail.com>
Subject: Re: O_DIRECT question
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Hua Zhong" <hzhong@gmail.com>,
       "Hugh Dickins" <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org,
       mjt@tls.msk.ru
In-Reply-To: <6d6a94c50701102150w4c3b46d0w6981267e2b873d37@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
	 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>
	 <6d6a94c50701102150w4c3b46d0w6981267e2b873d37@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/07, Aubrey <aubreylee@gmail.com> wrote:
> Firstly I want to say I'm working on no-mmu arch and uClinux.
> After much of file operations VFS cache eat up all of the memory.
> At this time, if an application request memory which order > 3, the
> kernel will report failure.
>
> uClinux use a memory mapped MTD driver to store rootfs, of course it's
> in the ram,
> So I don't need VFS cache to improve performance. And when order > 3,
> __alloc_page() even doesn't try to shrunk cache and slab, just report
> failure.
>
> So my thought is remove cache, or limit it. But currently there seems
> to be no way in the kernel to do it.  So I want to try to use
> O_DIRECT. But it seems not to be a right way.
One possibility might be to poke the open method in struct
file_operations of your fs like

static int my_open_file(struct inode *inode, struct file *filp)
{
        filp->f_flags |= O_DIRECT;
...
}

which is a nasty thing to do but might give you an idea of what happens next.

Regards,
-- 
I like long walks, especially when they are taken by people who annoy me.
