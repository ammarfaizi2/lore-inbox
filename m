Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287493AbSALVJC>; Sat, 12 Jan 2002 16:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287488AbSALVIw>; Sat, 12 Jan 2002 16:08:52 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:34828 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287484AbSALVIi>; Sat, 12 Jan 2002 16:08:38 -0500
Message-ID: <3C40A481.51306926@zip.com.au>
Date: Sat, 12 Jan 2002 13:02:57 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrea Arcangeli <andrea@suse.de>, rwhron@earthlink.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1-2-3 GB
In-Reply-To: <20020112125625.E1482@inspiron.school.suse.de> <Pine.LNX.4.21.0201121825200.1105-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> ...
> The patch below seems to be enough to convince egcs-2.91.66 and
> gcc-2.95.3 to use a "jb" comparison there.
> ...
> -       for (j = 0; j < PTRS_PER_PMD ; j++) {
> -               prefetchw(pmd+j+(PREFETCH_STRIDE/16));
> -               free_one_pmd(pmd+j);
> +       for (md = pmd, emd = pmd + PTRS_PER_PMD; md < emd; md++) {
> +               prefetchw(md+(PREFETCH_STRIDE/16));
> +               free_one_pmd(md);

You need to add a big fat comment here, describing the compiler
problem, and the risks which attend any change to this code.

-
