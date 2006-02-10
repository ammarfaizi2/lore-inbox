Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWBJVzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWBJVzn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 16:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWBJVzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 16:55:42 -0500
Received: from pat.uio.no ([129.240.130.16]:59051 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932214AbWBJVzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 16:55:40 -0500
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com
In-Reply-To: <Pine.LNX.4.64.0602101254081.19172@g5.osdl.org>
References: <20060209071832.10500.qmail@science.horizon.com>
	 <20060209094815.75041932.akpm@osdl.org> <43EC0A44.1020302@yahoo.com.au>
	 <20060209195035.5403ce95.akpm@osdl.org> <43EC0F3F.1000805@yahoo.com.au>
	 <20060209201333.62db0e24.akpm@osdl.org> <43EC16D8.8030300@yahoo.com.au>
	 <20060209204314.2dae2814.akpm@osdl.org> <43EC1BFF.1080808@yahoo.com.au>
	 <20060209211356.6c3a641a.akpm@osdl.org> <43EC24B1.9010104@yahoo.com.au>
	 <20060209215040.0dcb36b1.akpm@osdl.org> <43EC2C9A.7000507@yahoo.com.au>
	 <20060209221324.53089938.akpm@osdl.org> <43EC3326.4080706@yahoo.com.au>
	 <20060209224656.7533ce2b.akpm@osdl.org> <43EC3961.3030904@yahoo.com.au>
	 <Pine.LNX.4.64.0602100759190.19172@g5.osdl.org>
	 <43ECC13F.5080109@yahoo.com.au>
	 <Pine.LNX.4.64.0602100846170.19172@g5.osdl.org>
	 <43ECCF68.3010605@yahoo.com.au>
	 <Pine.LNX.4.64.0602100944280.19172@g5.osdl.org>
	 <43ECDD9B.7090709@yahoo.com.au>
	 <Pine.LNX.4.64.0602101056130.19172@g5.osdl! .org>
	 <43ECF182.9020505@yahoo.com.au>
	 <Pine.LNX.4.64.0602101254081.19172@g5.osdl.org>
Content-Type: text/plain
Date: Fri, 10 Feb 2006 16:55:13 -0500
Message-Id: <1139608513.7877.9.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.32, required 12,
	autolearn=disabled, AWL 1.49, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-10 at 13:10 -0800, Linus Torvalds wrote:
> This historical meaning as far as I can tell, for MS_INVALIDATE really 
> _forgets_ the old mmap'ped contents in a non-coherent system.
> 
> Quoting from a UNIX man-page (as found by google):
> 
> 	...
> 
>      If flags is MS_INVALIDATE,  the  function  synchronizes  the
>      contents  of  the  memory  region  to match the current file
>      contents.
> 
>         o  All writes to the mapped  portion  of  the  file  made
>            prior  to  the  call  are  visible  by subsequent read
>            references to the mapped memory region.
> 
>         o  All write references prior to the call,  by  any  pro-
>            cess,  to memory regions mapped to the same portion of
>            the file using MAP_SHARED, are visible by read  refer-
>            ences to the region.

The Single Unix Spec appears to have a very different interpretation.
See http://www.opengroup.org/onlinepubs/009695399/toc.htm

        When MS_ASYNC is specified, msync() shall return immediately
        once all the write operations are initiated or queued for
        servicing; when MS_SYNC is specified, msync() shall not return
        until all write operations are completed as defined for
        synchronized I/O data integrity completion. Either MS_ASYNC or
        MS_SYNC is specified, but not both.

        When MS_INVALIDATE is specified, msync() shall invalidate all
        cached copies of mapped data that are inconsistent with the
        permanent storage locations such that subsequent references
        shall obtain data that was consistent with the permanent storage
        locations sometime between the call to msync() and the first
        subsequent memory reference to the data.
        
        If msync() causes any write to a file, the file's st_ctime and
        st_mtime fields shall be marked for update.

Cheers,
  Trond

