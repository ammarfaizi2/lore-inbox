Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263259AbTDBXcB>; Wed, 2 Apr 2003 18:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263260AbTDBXcB>; Wed, 2 Apr 2003 18:32:01 -0500
Received: from unthought.net ([212.97.129.24]:6634 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S263259AbTDBXb5>;
	Wed, 2 Apr 2003 18:31:57 -0500
Date: Thu, 3 Apr 2003 01:43:23 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Kenny Simpson <theonetruekenny@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: mmap-related questions
Message-ID: <20030402234322.GB19708@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Benjamin LaHaise <bcrl@redhat.com>,
	Kenny Simpson <theonetruekenny@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20030401125020.E25225@redhat.com> <20030402031840.60077.qmail@web20005.mail.yahoo.com> <20030402093049.GB17859@unthought.net> <20030402101006.A30582@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030402101006.A30582@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 10:10:06AM -0500, Benjamin LaHaise wrote:
> On Wed, Apr 02, 2003 at 11:30:50AM +0200, Jakob Oestergaard wrote:
> >   make_dirty(big_map)
> >   msync(first half of big_map)
> >   msync(second half of big_map)    { crash during this }
> > 
> > Then I am guaranteed that (unless the server crashes), the first half of
> > big_map *will* have reached the server, but not that all of the second
> > half has.   Right?
> 
> Assuming you used MS_SYNC for the msync() flags.  MS_ASYNC could still be 
> proceeding to flush the pages out in the background.  And the kernel may 
> have triggered writeback of the second half -- it is free to do so as it 
> sees fit.

Yes. MS_ASYNC is "advisory" only, as I understand it.  (too bad it isn't
select()'able actually, I could use that to work wonders with a database
engine here...)

> 
> > Like any local-disk backed file.
> > 
> > Ignoring the case where the NFS *server* crashes, where could the write
> > ordering differ, compared to local disk files ?
> 
> > In other words, what does Benjamin's "unexpected ways" refer to ?
> 
> All local clients will see the mmap() being updated from the time it is 
> dirtied, but there is no ordering of write()s with respect to the mmap 
> unless you explicitely msync(..MS_SYNC..) as in your example.

Ok, so we're talking multiple processes reading/writing.

Now it makes a lot more sense - I was thinking one process only.  Silly
simple-minded me  ;)

Thanks,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
