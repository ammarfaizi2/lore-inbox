Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318219AbSIEUWe>; Thu, 5 Sep 2002 16:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318221AbSIEUWd>; Thu, 5 Sep 2002 16:22:33 -0400
Received: from pat.uio.no ([129.240.130.16]:61116 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S318219AbSIEUWd>;
	Thu, 5 Sep 2002 16:22:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15735.48664.951983.418842@charged.uio.no>
Date: Thu, 5 Sep 2002 22:27:04 +0200
To: Andrew Morton <akpm@zip.com.au>
Cc: Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
In-Reply-To: <3D77BB7C.5F20939F@zip.com.au>
References: <3D77A22A.DC3F4D1@zip.com.au>
	<Pine.BSO.4.33.0209051439540.12826-100000@citi.umich.edu>
	<3D77ADC3.938C09F8@zip.com.au>
	<shsvg5k9pg3.fsf@charged.uio.no>
	<3D77BB7C.5F20939F@zip.com.au>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Morton <akpm@zip.com.au> writes:

     > It's a bit worrisome if NFS is dependent upon successful
     > pagecache takedown in invalidate_inode_pages.

Why? We don't use all that buffer crap, so in principle
invalidate_inode_page() is only supposed to fail for us if

  - page is locked (i.e. new read in progress or something like that)
  - page is refcounted (by something like mmap()).

neither of which should be the case here.

Cheers,
  Trond
