Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315260AbSIDUPs>; Wed, 4 Sep 2002 16:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315370AbSIDUPr>; Wed, 4 Sep 2002 16:15:47 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:58130 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S315260AbSIDUPq>; Wed, 4 Sep 2002 16:15:46 -0400
Message-ID: <3D766A79.D1975DCA@zip.com.au>
Date: Wed, 04 Sep 2002 13:18:01 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Ed Tomlinson <tomlins@cam.org>, William Lee Irwin III <wli@holomorphy.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.33-mm1
References: <200209032251.54795.tomlins@cam.org> <3D757F11.B72BB708@zip.com.au> <20020904202523.A15699@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> 
> Hi,
> 
> On Tue, Sep 03, 2002 at 08:33:37PM -0700, Andrew Morton wrote:
> 
> > I *really* think we need to throw away those pages instantly.
> >
> > The only possible reason for hanging onto them is because they're
> > cache-warm.  And we need a global-scope cpu-local hot pages queue
> > anyway.
> 
> Yep --- except for caches with constructors, for which we do save a
> bit more by hanging onto the pages for longer.

Ah, of course.  Thanks.

We'll still have a significant volume of pre-constructed objects
in the partially-full slabs: it seems that these things are fairly
prone to internal fragmentation, which works to our advantage in
this case.

So yes, perhaps we need to hang onto some preconstructed pages
for these slabs, if the internal fragmentation of the existing
part-filled slabs is low.
