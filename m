Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274638AbRITUk5>; Thu, 20 Sep 2001 16:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274641AbRITUks>; Thu, 20 Sep 2001 16:40:48 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:49896 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274638AbRITUkc>;
	Thu, 20 Sep 2001 16:40:32 -0400
Date: Thu, 20 Sep 2001 16:40:51 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Steve Lord <lord@sgi.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Gonyou, Austin" <austin@coremetrics.com>,
        narancs@narancs.tii.matav.hu, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: XFS to main kernel source 
In-Reply-To: <200109202016.f8KKGrL19642@jen.americas.sgi.com>
Message-ID: <Pine.GSO.4.21.0109201633530.5631-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Sep 2001, Steve Lord wrote:

> > > Won't there be a lot of changes which need to be made for it to go into 2.5
> > > anyway though beyond just current development? Isn't 2.5 supposed to be
> > > "radically" different?
> > 
> > Not really. 2.5 will change over time for certain but if anything the 2.5
> > changes will make it easier. One problem area with XFS is that it duplicates
> > chunks of what should be generic functionality - and 2.5 needs to provide
> > the generic paths it wants
> 
> Since we have your attention - which chunks? One of the frustrations we have
> had is the lack of feedback from anyone who has looked at XFS.

Locking.  There is a _lot_ of duplication between fs/namei.c and fs/xfs/* -
you definitely don't need most of the stuff you do with locks there.

I understand that some of that stuff may be needed for CXFS, and I would
really like to see the description of locking requirements of that animal.

Parts that are needed only on IRIX since IRIX VFS is braindead should go.
Parts that can be moved to generic code should be moved (with sane set of
methods provided by filesystems a-la CXFS). The rest will become much simpler.

