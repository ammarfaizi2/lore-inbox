Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289958AbSAKNyE>; Fri, 11 Jan 2002 08:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289957AbSAKNxp>; Fri, 11 Jan 2002 08:53:45 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:34169 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289959AbSAKNxi>; Fri, 11 Jan 2002 08:53:38 -0500
Date: Fri, 11 Jan 2002 14:52:03 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Jens Axboe <axboe@suse.de>, Benjamin LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
Message-ID: <20020111145203.B2270@inspiron.school.suse.de>
In-Reply-To: <20020110120926.J3357@inspiron.school.suse.de> <200201101658.g0AGwfo25510@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200201101658.g0AGwfo25510@eng2.beaverton.ibm.com>; from pbadari@us.ibm.com on Thu, Jan 10, 2002 at 08:58:41AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 08:58:41AM -0800, Badari Pulavarty wrote:
> Andrea,
> 
> > > 
> > > I still wouldn't feel to good doing this, and just because snapshotting
> > > opens the possibility for this to happen doesn't mean it a) ever
> > > triggered in real life, and b) works on all devices.
> > 
> > fair enough. one way to do it certainly safely is to add a bitflag to
> > the struct blkkdev.
> > 
> > Andrea
> > 
> 
> Could you please elaborate on your suggestion. What does a biflag in
> blkdev do ? 
> 
> I am sure by now, you must have understood what my patch is trying to
> do. I am trying to issue 4K buffer heads on RAW whenever possible 
> (instead of 512). But for the first and last pages buffer heads may
> be different size than 4K (due to alignment and length of IO). So, We 
> end up with buffer heads with multiple IO sizes in a single request.
> 
> How does your suggestion fix the problem ? How can I address this
> problem safely. Please let me know.

the bitflag will allow you to enable this feature only on the lowlevel
drivers that you can afford to test. on the hardware that you can afford
to test you will know for sure that enabling the feature is safe. This
way we won't risk random breakage of not-tested drivers.

Andrea
