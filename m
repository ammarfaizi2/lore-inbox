Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWGLRMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWGLRMh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 13:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWGLRMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 13:12:37 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:63940 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S932102AbWGLRMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 13:12:36 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Martin Bligh <mbligh@google.com>
Subject: Re: xfs fails dbench in 2.6.18-rc1-mm1
Date: Wed, 12 Jul 2006 19:12:52 +0200
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andy Whitcroft <apw@shadowen.org>
References: <44B52A19.3020607@google.com>
In-Reply-To: <44B52A19.3020607@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607121912.52785.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 July 2006 18:58, Martin Bligh wrote:
> http://test.kernel.org/abat/40891/debug/test.log.1
>
> Filesystem type for /mnt/tmp is xfs
> write failed on handle 13786
> 4 clients started
> Child failed with status 1
> write failed on handle 13786
> write failed on handle 13786
> write failed on handle 13786
>
> Works fine in -git4
> All other fs's seemed to run OK.
>
> Machine is a 4x Opteron.

You need to revert 92eb7a2f28d551acedeb5752263267a64b1f5ddf

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff;h=3f356086061d7076a379b76e265295a5fe3750fe;hp=55f4e70225631b275f85215ee543b104507caacc;hb=92eb7a2f28d551acedeb5752263267a64b1f5ddf;f=fs/file.c

or change in alloc_fdtable()

nfds = max_t(int, 8 * L1_CACHE_BYTES, roundup_pow_of_two(nfds));

into

nfds = max_t(int, 8 * L1_CACHE_BYTES, roundup_pow_of_two(nr+1));

Eric
