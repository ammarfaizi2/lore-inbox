Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261287AbSI3S7P>; Mon, 30 Sep 2002 14:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261283AbSI3S7P>; Mon, 30 Sep 2002 14:59:15 -0400
Received: from packet.digeo.com ([12.110.80.53]:10943 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261173AbSI3S7H>;
	Mon, 30 Sep 2002 14:59:07 -0400
Message-ID: <3D98A04C.2FE206EE@digeo.com>
Date: Mon, 30 Sep 2002 12:04:44 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Chuck Lever <cel@netapp.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: Re: [PATCH] 2.4.20 Direct IO patch for NFS. (Note: a trivial API 
 change...)
References: <15768.39196.468797.249573@charged.uio.no> <20020930194227.A22095@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2002 19:04:24.0705 (UTC) FILETIME=[311AFF10:01C268B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> On Mon, Sep 30, 2002 at 08:34:04PM +0200, Trond Myklebust wrote:
> >
> > Hi Marcelo,
> >
> >   The following patch implements direct I/O for NFS as a compilation option.
> > It does not in any way touch the standard NFS read/write code, however it
> > does change the interface for generic direct I/O: Instead of taking a
> > 'struct inode' argument, we need to take the full 'struct file' in order
> > to be able to pass the RPC credential information down to the NFS layer.
> 
> I don't think changing the filesystem entry points during 2.4 is an option.
> 

It's a very small change; I wouldn't be very fussed about it personally.

To be source-compatible with out-of-kernel filesystems you could add
a new a_op and do

	if (mapping->direct_IO_which_uses_a_filp)
		use that
	else
		use mapping->direct_IO

but ick.
