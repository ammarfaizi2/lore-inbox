Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319269AbSIFRU0>; Fri, 6 Sep 2002 13:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319270AbSIFRU0>; Fri, 6 Sep 2002 13:20:26 -0400
Received: from pc-80-195-6-65-ed.blueyonder.co.uk ([80.195.6.65]:6788 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S319269AbSIFRUZ>; Fri, 6 Sep 2002 13:20:25 -0400
Date: Fri, 6 Sep 2002 18:24:57 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Aaron Lehmann <aaronl@vitelus.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ext3 throughput woes on certain (possibly heavily fragmented) files
Message-ID: <20020906182457.F3029@redhat.com>
References: <20020903092419.GA5643@vitelus.com> <20020906170614.A7946@redhat.com> <15736.57972.202889.872554@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15736.57972.202889.872554@laputa.namesys.com>; from Nikita@Namesys.COM on Fri, Sep 06, 2002 at 09:14:28PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 06, 2002 at 09:14:28PM +0400, Nikita Danilov wrote:

> Another possible solution is to try to "defer" allocation. For example,
> in reiser4 (and XFS, I believe) extents are allocated on the transaction
> commit and as a result, if file was created by several writes, it will
> still be allocated as one extent.

Ext2 has a preallocation mechanism so that if you have multiple
writes, they get dealt with to some extent as a single allocation.
However, that doesn't work over close(): the preallocated blocks are
discarded wheneven we close the file.

The problem with mail files, though, is that they tend to grow quite
slowly, so the writes span very many transactions and we don't have
that opportunity for coalescing the writes.  Actively defragmenting on
writes is an alternative in that case.

Cheers,
 Stephen
