Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264857AbSJVUIx>; Tue, 22 Oct 2002 16:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264852AbSJVUH5>; Tue, 22 Oct 2002 16:07:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:7095 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S264829AbSJVUHp>;
	Tue, 22 Oct 2002 16:07:45 -0400
Date: Tue, 22 Oct 2002 22:27:00 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@digeo.com>
Cc: Christoph Hellwig <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: [patch] generic nonlinear mappings, 2.5.44-mm2-D0
In-Reply-To: <3DB5A5BD.D3E00B4A@digeo.com>
Message-ID: <Pine.LNX.4.44.0210222220480.22282-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Oct 2002, Andrew Morton wrote:

> We seem to have lost a pte_page_unlock() from fremap.c:zap_pte()? I
> fixed up the ifdef tangle in there within the shpte-ng patch and then
> put the pte_page_unlock() back.

ok. I too fixed up the shpte #ifdef tangle in there as well, and it was
complex for no good reason, so i suspected that it was missing a line or
two.

> I also added a page_cache_release() to the error path in
> filemap_populate(), if install_page() failed.

hm, i somehow missed to add this, this was reported once already.

> The 2TB file size limit for mmap on non-PAE is a little worrisome. [...]

the limit is only there for 32-bit ptes on 32-bit platforms. 64-bit ptes
(both true 64-bit architectures and x86-PAE) has a ~64 zetabyte filesize
limit. I do not realistically believe that any 32-bit x86 box that is
connected to a larger than 2 TB disk array cannot possibly run a PAE
kernel. Just like you need PAE for more than 4 GB physical RAM. I find it
a bit worrisome that 32-bit x86 ptes can only support up to 4 GB of
physical RAM, but such is life :-)

	Ingo

