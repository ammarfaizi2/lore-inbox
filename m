Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313415AbSDESiw>; Fri, 5 Apr 2002 13:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313414AbSDESim>; Fri, 5 Apr 2002 13:38:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56842 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313413AbSDESi0>;
	Fri, 5 Apr 2002 13:38:26 -0500
Message-ID: <3CADEEF5.1A73C602@zip.com.au>
Date: Fri, 05 Apr 2002 10:37:41 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Lord <lord@sgi.com>
CC: Dave Jones <davej@suse.de>, svetljo <galia@st-peter.stw.uni-erlangen.de>,
        linux-kernel@vger.kernel.org, linux-xfs@thebarn.com
Subject: Re: REPOST : linux-2.5.5-xfs-dj1 - 2.5.7-dj2  (raid0_make_request bug)
In-Reply-To: <3CAD8B9D.8070902@st-peter.stw.uni-erlangen.de> <20020405184103.F14828@suse.de> <3CADD6CA.8010600@sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Lord wrote:
> 
> Dave Jones wrote:
> 
> >On Fri, Apr 05, 2002 at 01:33:49PM +0200, svetljo wrote:
> > > i'm having some interesting troubles
> > > i have lvm over soft RAID-0 with LV's formated with XFS and JFS
> > > i can work with the JFS LV's,
> > >    but i can not with the XFS one's, i can not mount them ( no troubles
> > > with XFS normal partitions)
> > > so i'd like to ask is this problem with XFS or with raid or lvm
> > > and is there a way to fix it
> >
> >IIRC, this was reported a while ago, and it was something to do with
> >XFS creating too large requests that upset the raid code.
> >
> Or the raid code not handling the bio layer too well, depends on your point
> of view ;-)
> 

Stephen's point of view is correct.  RAID0 fails
in the same manner with the large pagecache BIOs
which I'm feeding it.  It fails in the same manner
with O_DIRECT on ext2.

Neil knows about it, and will get to it.  mkp has
a 2.4 request splitter which he will turn into a
2.5 BIO splitter.

As you said - it's being worked on.

-
