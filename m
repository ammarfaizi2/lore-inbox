Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317126AbSEXMOq>; Fri, 24 May 2002 08:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317128AbSEXMOp>; Fri, 24 May 2002 08:14:45 -0400
Received: from tomts22-srv.bellnexxia.net ([209.226.175.184]:3541 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S317126AbSEXMOp>; Fri, 24 May 2002 08:14:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC][PATCH] using page aging to shrink caches (pre8-ac5)
Date: Fri, 24 May 2002 08:14:25 -0400
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <200205180010.51382.tomlins@cam.org> <200205240728.45558.tomlins@cam.org> <20020524123535.A9618@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200205240814.25293.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 24, 2002 07:35 am, Christoph Hellwig wrote:
> On Fri, May 24, 2002 at 07:28:45AM -0400, Ed Tomlinson wrote:
> > Comments, questions and feedback very welcome,
>
> Just from a short look:
>
> What about doing mark_page_accessed in kmem_touch_page?

mark_page_accessed expects a page struct.  kmem_touch_page takes an
address in the page, converts it to a kernel address and then marks the page.

> And please do a s/pruner_t/kmem_pruner_t/

Yes.  Done.

One other style question.  I am not completely happy with kmem_shrink_slab.
Think that instead of setting the reference bit I should probably do something
like return:

-1	- cache is growing
  0	- slab has inuse objects
  n    - pages were freed

Comments?
Ed Tomlinson

