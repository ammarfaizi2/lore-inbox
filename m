Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261325AbSJPR5v>; Wed, 16 Oct 2002 13:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261326AbSJPR5v>; Wed, 16 Oct 2002 13:57:51 -0400
Received: from packet.digeo.com ([12.110.80.53]:38532 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261325AbSJPR5u>;
	Wed, 16 Oct 2002 13:57:50 -0400
Message-ID: <3DADA9FA.1D578A27@digeo.com>
Date: Wed, 16 Oct 2002 11:03:38 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@cambridge.redhat.com>
CC: Rik van Riel <riel@conectiva.com.br>, David Howells <dhowells@redhat.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] do_generic_file_read / readahead adjustments
References: Message from Rik van Riel <riel@conectiva.com.br> 
	   of "Wed, 16 Oct 2002 14:36:14 -0200." <Pine.LNX.4.44L.0210161435470.1648-100000@duckman.distro.conectiva> <30901.1034790945@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Oct 2002 18:03:38.0290 (UTC) FILETIME=[5A483920:01C2753E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> 
> This patch is the alternative: make a function (do_generic_mapping_read())
> that I can pass an inode or an address_space to, and make
> do_generic_file_read() call that. This allows me to make use of readahead
> semantics without having to reinvent them for myself.
> 

OK.  The current readahead and mpage code is really designed just
for ext2-style filesystems.  It was always expected that it would 
have to grow as more sophisticated filesytems put demands upon it.

Your change is a perfectly sensible generalisation.  The reiserfs
team have been making noises about lower-level readahead hooks as well,
and I think your patch largely addresses those.  I shall ping them.
