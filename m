Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbVHKQdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbVHKQdj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 12:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbVHKQdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 12:33:39 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:10144 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751106AbVHKQdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 12:33:39 -0400
Message-ID: <42FB7DE5.2080506@zabbo.net>
Date: Thu, 11 Aug 2005 09:33:41 -0700
From: Zach Brown <zab@zabbo.net>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Mark Fasheh <mark.fasheh@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       David Teigland <teigland@redhat.com>, Pekka Enberg <penberg@gmail.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: GFS
References: <Pine.LNX.4.58.0508111006470.13379@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0508111006470.13379@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What I meant was that, if a filesystem requires vma walks, we need to do 
> it VFS level with something like the following patch.

I don't think this patch is the way to go at all.  It imposes an
allocation and vma walking overhead for the vast majority of IOs that
aren't interested.  It doesn't look like it will get a consistent
ordering when multiple file systems are concerned.  It doesn't record
the ranges of the mappings involved so Lustre can't properly use its
range locks.  And finally, it doesn't prohibit mapping operations for
the duration of the IO -- the whole reason we ended up in this thread in
the first place :)

Christoph, would you be interested in looking at a more thorough patch
if I threw one together?

- z
