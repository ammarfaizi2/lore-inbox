Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280227AbRJaOS5>; Wed, 31 Oct 2001 09:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280234AbRJaOSi>; Wed, 31 Oct 2001 09:18:38 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:31229 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280227AbRJaOSS>;
	Wed, 31 Oct 2001 09:18:18 -0500
Date: Wed, 31 Oct 2001 09:18:37 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: pre6 oom killer oops
In-Reply-To: <3BE006D4.92E6D23A@mandrakesoft.com>
Message-ID: <Pine.GSO.4.21.0110310916210.5536-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 31 Oct 2001, Jeff Garzik wrote:

> further comments #2:
> 
> when rebooting, there was some disk corruption in the ext2 filesystem.
> 
> It is my guess that this is to the large number of buffers in the vmstat
> output, which I believe are dirty buffers that never got written out

Judging by your log it's not an OOM - page table corruption got caught by
do_wp_page(), which means that handle_mm_fault() fails (surprise, surprise),
which kills the process.

Looks like a massive memory corruption - later it fscked you in pte_alloc()
and then it screwed buffer cache lists.

