Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263026AbSKHXY5>; Fri, 8 Nov 2002 18:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263135AbSKHXY4>; Fri, 8 Nov 2002 18:24:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42251 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263026AbSKHXY4>; Fri, 8 Nov 2002 18:24:56 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: RFC: mmap(PROT_READ, MAP_SHARED) fails if !writepage.
Date: Fri, 8 Nov 2002 23:31:09 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <aqhhft$19b$1@penguin.transmeta.com>
References: <24305.1036795742@passion.cambridge.redhat.com>
X-Trace: palladium.transmeta.com 1036798269 18783 127.0.0.1 (8 Nov 2002 23:31:09 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 8 Nov 2002 23:31:09 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <24305.1036795742@passion.cambridge.redhat.com>,
David Woodhouse  <dwmw2@infradead.org> wrote:
>Why does a _readonly_ mapping fail if the file system has no writepage 
>method? 
>
>do_mmap_pgoff() sets VM_MAYWRITE on the vma and then generic_file_mmap() 
>refuses to allow it. 
>
>Suggested patch below.... or should I just hack fsx-linux to use 
>MAP_PRIVATE for its readonly mappings and ignore it?

This is broken. Since it has VM_MAYWRITE, a subsequent mprotect() may
mark it writable, and you you went boom.

If you really want a shared mapping, you'd better open with O_RDONLY, at
which point the existing code should be perfectly happy and does the
right thing.

In other words: the code is correct as-is.

		Linus
