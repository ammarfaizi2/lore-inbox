Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262949AbTDBJT2>; Wed, 2 Apr 2003 04:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262951AbTDBJT2>; Wed, 2 Apr 2003 04:19:28 -0500
Received: from unthought.net ([212.97.129.24]:32483 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S262949AbTDBJT1>;
	Wed, 2 Apr 2003 04:19:27 -0500
Date: Wed, 2 Apr 2003 11:30:50 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: mmap-related questions
Message-ID: <20030402093049.GB17859@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Kenny Simpson <theonetruekenny@yahoo.com>,
	Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
References: <20030401125020.E25225@redhat.com> <20030402031840.60077.qmail@web20005.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030402031840.60077.qmail@web20005.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 07:18:40PM -0800, Kenny Simpson wrote:
> --- Benjamin LaHaise <bcrl@redhat.com> wrote:
> > the act of unmapping them transfers the
> > dirty bit from the page 
> > tables into the page cache where fsync() acts on
> > them.
> >
> Should this info be included with Mel Gorman's
> excellent doc:
> http://www.csn.ul.ie/~mel/projects/vm/guide/html/understand/node31.html#SECTION009411000000000000000
> Or is it there, but I missed it?
> 
> > The
> > one case this breaks down 
> > on is when the mmap()'d file is on NFS -- the
> > reordering there can result in 
> > writebacks from mmap()s occuring in unexpected ways.
> I sometimes wish mmap was not supported on NFS, or at
> least require a special MAP_NFS flag be used.  It has
> caused lots of pain over the years.

Could someone elaborate on this please?

If my client does
  big_map = mmap(... some file ...)
  make_dirty(big_map)
  msync(first half of big_map)
  msync(second half of big_map)    { crash during this }

Then I am guaranteed that (unless the server crashes), the first half of
big_map *will* have reached the server, but not that all of the second
half has.   Right?

Like any local-disk backed file.

Ignoring the case where the NFS *server* crashes, where could the write
ordering differ, compared to local disk files ?

In other words, what does Benjamin's "unexpected ways" refer to ?

Thanks,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
