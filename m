Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313882AbSEAS0C>; Wed, 1 May 2002 14:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313902AbSEAS0B>; Wed, 1 May 2002 14:26:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22283 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313882AbSEASZ5>;
	Wed, 1 May 2002 14:25:57 -0400
Date: Wed, 1 May 2002 20:25:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reworked IDE/general tagged command queueing
Message-ID: <20020501182544.GF811@suse.de>
In-Reply-To: <Pine.LNX.4.44.0205010900050.4589-100000@home.transmeta.com> <3CD0119D.1080905@evision-ventures.com> <3CD02139.3020009@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01 2002, Martin Dalecki wrote:
> >Well after a short cross over look at it I agree.
> >The generic interface looks sane for me as well. However
> >I will have to look a bit deeper, becouse at the first sight
> >the double pointer to tag_index looks a bit "overelaborate"
> >to me. But I may change my opinnion after looking at the
> >actual usage - so please take this small bit of critique
> >with a good grain of salt...
> >
> >+#define BLK_TAGS_PER_LONG    (sizeof(unsigned long) * 8)
> >+#define BLK_TAGS_MASK        (BLK_TAGS_PER_LONG - 1)
> >+
> >+struct blk_queue_tag {
> >+ struct request **tag_index;    /* map of busy tags */
> >+ unsigned long *tag_map;        /* bit map of free/busy tags */
> >+ struct list_head busy_list;    /* fifo list of busy tags */
> >+ int busy;            /* current depth */
> >+ int max_depth;
> >+};
> >+
> 
> Well I revoke my objections. tag_index is fine :-).

It should be, it's just an index of pointer to request, so no double
indirections :)

-- 
Jens Axboe

