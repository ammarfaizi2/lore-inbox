Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316309AbSGATtE>; Mon, 1 Jul 2002 15:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316342AbSGATtD>; Mon, 1 Jul 2002 15:49:03 -0400
Received: from mail.broadpark.no ([217.13.4.2]:12208 "HELO mail.broadpark.no")
	by vger.kernel.org with SMTP id <S316309AbSGATtD>;
	Mon, 1 Jul 2002 15:49:03 -0400
Message-ID: <3D20B29B.ED186C3B@broadpark.no>
Date: Mon, 01 Jul 2002 21:50:51 +0200
From: Helge Hafting <helge.hafting@broadpark.no>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.24-dj1 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: akpm@zip.com.au, davej@suse.de
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org,
       neilb@cse.unsw.edu.au
Subject: Re: [Fwd: Re: 2.5.24-dj1,smp,ext2,raid0: I got random zero blocks in my 
 files.]
References: <3D20539F.C7D7A4C4@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> 
> -------- Original Message --------
> Subject: Re: 2.5.24-dj1,smp,ext2,raid0: I got random zero blocks in my
> files.
> Date: Mon, 01 Jul 2002 01:18:20 -0700
> From: Andrew Morton <akpm@zip.com.au>
> To: Helge Hafting <helgehaf@aitel.hist.no>
> CC: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au,davej@suse.de
> References: <3D200BF6.3A6D9B59@aitel.hist.no>
> 
> Helge Hafting wrote:
> >
> > 2.5.24-dj1 gave me files with zeroed blocks inside.
[...]
> > The filesystems use 4k blocks.
> > I haven't seen any trouble on non-raid or raid-1
> > partitions.
> 
> Yes, the large BIO stuff went into 2.5.19.  RAID0 doesn't
> like those big BIOs.  Jens is cooking up a fix for that.
> 
> Just to confirm that this is the problem, could you please
> set MPAGE_BIO_MAX_SIZE in 32768 in fs/mpage.c and see if the
> failure goes away?

I tried that, and it didn't help.  Could this be as simple
as non-aligned 32k requests?  A size limit might not be
enough if the request starts in the middle of one stripe
extending into the next?


I got lots of these,
monster kernel: raid0_make_request bug: can't convert block across
chunks or bigger than 32k 2944376 32

and untarred files with strings of zeroes in them.  One
file had several sets of zeroes.

Helge Hafting
