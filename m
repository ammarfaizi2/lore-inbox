Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129904AbRAaEyg>; Tue, 30 Jan 2001 23:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130098AbRAaEy0>; Tue, 30 Jan 2001 23:54:26 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:9220 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129904AbRAaEyP>; Tue, 30 Jan 2001 23:54:15 -0500
Date: Wed, 31 Jan 2001 01:05:02 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
cc: linux-mm@kvack.org
Subject: [PATCH] vma limited swapin readahead 
Message-ID: <Pine.LNX.4.21.0101310037540.16187-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

The current swapin readahead code reads a number of pages (1 >>
page_cluster)  which are physically contiguous on disk with reference to
the page which needs to be faulted in.

However, the pages which are contiguous on swap are not necessarily
contiguous in the virtual memory area where the fault happened. That means
the swapin readahead code may read pages which are not related to the
process which suffered a page fault.

I've changed the swapin code to not readahead pages if they are not
virtually contiguous on the vma which is being faulted to avoid
the problem described above.

Testers are very welcome since I'm unable to test this in various
workloads.

The patch is available at
http://bazar.conectiva.com.br/~marcelo/patches/v2.4/2.4.1pre10/swapin_readahead.patch


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
