Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758687AbWLDKhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758687AbWLDKhE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 05:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758763AbWLDKhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 05:37:04 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:20096 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1758687AbWLDKhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 05:37:01 -0500
Message-ID: <365228617.22656@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Mon, 4 Dec 2006 18:37:04 +0800
From: WU Fengguang <wfg@mail.ustc.edu.cn>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Frank van Maarseveen <frankvm@frankvm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@google.com>
Subject: Re: radix-tree.c:__lookup_slot() dead code removal
Message-ID: <20061204103704.GA7792@mail.ustc.edu.cn>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	Frank van Maarseveen <frankvm@frankvm.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@google.com>
References: <20061203170231.GA20298@janus> <4573F600.50306@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4573F600.50306@yahoo.com.au>
X-GPG-Fingerprint: 53D2 DDCE AB5C 8DC6 188B  1CB1 F766 DA34 8D8B 1C6D
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 09:18:40PM +1100, Nick Piggin wrote:
> Frank van Maarseveen wrote:
> >Most of the code suggests that it is valid to insert a NULL item,
> >possibly a zero item with pointer cast. However, in __lookup_slot()
> >whether or not the slot is found seems to depend on the actual value
> >of the item in one special case. But further on it doesn't make any
> >difference so to remove some dead code:
> >
> >--- a/lib/radix-tree.c	2006-12-03 13:23:00.000000000 +0100
> >+++ b/lib/radix-tree.c	2006-12-03 17:57:03.000000000 +0100
> >@@ -319,9 +319,6 @@ static inline void **__lookup_slot(struc
> > 	if (index > radix_tree_maxindex(height))
> > 		return NULL;
> >
> >-	if (height == 0 && root->rnode)
> >-		return (void **)&root->rnode;
> >-
> > 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
> > 	slot = &root->rnode;
>
> I would say it is not valid to insert a NULL item (because NULL
> means an unsuccessful lookup, you may as well just delete the
> item).
>
> Also, I don't see how this is dead code anyway. height == 0
> radix-trees are a special case and do not have a radix_tree_node
> at ->rnode.

Sorry.

For linux-2.6.19 it was redundant code:

        if (height == 0 && root->rnode)
                return (void **)&root->rnode;

        shift = (height-1) * RADIX_TREE_MAP_SHIFT;
        slot = &root->rnode;

        while (height > 0) {
                ......
        }

        return (void **)slot;

I just find out it is no longer the case for -mm: the function has been heavily
reworked.

So, the patch is no longer valid.

Fengguang Wu
