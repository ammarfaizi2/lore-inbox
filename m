Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVEIJrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVEIJrG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 05:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVEIJrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 05:47:06 -0400
Received: from godzilla.roxen.com ([212.247.28.43]:23252 "EHLO mail.roxen.com")
	by vger.kernel.org with ESMTP id S261176AbVEIJrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 05:47:02 -0400
Date: Mon, 9 May 2005 11:46:49 +0200 (MET DST)
From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: "sct@redhat.com" <sct@redhat.com>, "akpm@osdl.org" <akpm@osdl.org>,
       "neilb@cse.unsw.edu.au" <neilb@cse.unsw.edu.au>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Support for dx directories in ext3_get_parent (NFSD)
In-Reply-To: <20050509092417.GF25935@schnapps.adilger.int>
Message-ID: <Pine.GSO.4.21.0505091135290.22820-100000@jms.roxen.com>
Organization: Roxen Internet Software AB
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2005, Andreas Dilger wrote:

> On May 09, 2005  10:57 +0200, Henrik Grubbström wrote:
> > The 2.6.10 ext3_get_parent attempts to use ext3_find_entry to look up the
> > entry "..", which fails for dx directories since ".." is not present in
> > the directory hash table. The patch below solves this by looking up the
> > dotdot entry in the dx_root block.
> 
> ext3_get_parent() is IMHO the wrong place to fix this bug as it introduces
> a lot of internals from htree into that function.  Instead, I think this
> should be fixed in ext3_find_entry() as in the below patch.  This has the
> added advantage that it works for any callers of ext3_find_entry() and not
> just ext3_lookup_parent().

The reason I didn't put it there is that handling of ".." is usually
performed by fs/namei.c:link_path_walk() and putting it in
ext3_find_entry() or one of the functions it calls would slow down the
common case.

> Cheers, Andreas

--
Henrik Grubbström					grubba@roxen.com
Roxen Internet Software AB

