Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274752AbRIUEmP>; Fri, 21 Sep 2001 00:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274753AbRIUEmE>; Fri, 21 Sep 2001 00:42:04 -0400
Received: from rj.sgi.com ([204.94.215.100]:58801 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S274752AbRIUEly>;
	Fri, 21 Sep 2001 00:41:54 -0400
Date: Fri, 21 Sep 2001 15:42:00 +1100
From: Nathan Scott <nathans@sgi.com>
To: Steve Lord <lord@sgi.com>
Cc: hch@ns.caldera.de, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Gonyou, Austin" <austin@coremetrics.com>,
        narancs@narancs.tii.matav.hu, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: XFS to main kernel source
Message-ID: <20010921154159.H416300@wobbly.melbourne.sgi.com>
In-Reply-To: <adilger@turbolabs.com> <200109210325.f8L3PKi20270@jen.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109210325.f8L3PKi20270@jen.americas.sgi.com>; from lord@sgi.com on Thu, Sep 20, 2001 at 10:25:20PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

On Thu, Sep 20, 2001 at 10:25:20PM -0500, Steve Lord wrote:
> > On Sep 20, 2001  16:31 -0500, Steve Lord wrote:
> > > XFS quotas are transactional, when space is added to a file the quota is
> > > adjusted in the same transaction. It is fairly hard to do this without your
> > > own quota code.
> > 
> > Actually not.  The quotas in ext3 are transactional as well.  It's just
> > that the "ext3" journal layer allows nested transactions, so it is possible
> > to start a write transaction, call into the journal code which calls back
> > into the ext3 write code to start a nested transaction on the journal file
> > (i.e. it is in the same transaction as the initial write), and then the
> > initial write completes.
> 
> OK, good point, but doing a major rewrite of XFS to use a different
> transaction mechanism is not really on the cards, plus we have on disk
> compatibility with the Irix version to consider.
> 

XFS also uses quite a different _model_ of quota, and it is
tightly integrated into XFS (by its very nature).  There
are a number of issues that it attempts to address, and in
particular it works around the inherent problems of the
traditional quotacheck/mount/quotaon/quotaoff model (ie. the
BSD quota model which the Linux VFS also uses, and which was
used in IRIX for the EFS filesystem).

Its simply different, there are advantages and disadvantages
of each way, but XFS is particularly aimed at scalability,
and the desire to never have to run quotacheck(8) on large
filesystems was one of the issues which the original design
aimed to address.

So XFS quota should be a non-issue.  I have had discussions
with Jan Kara and Alan in the past about how to most cleanly
integrate it with their (new) VFS quota, and they seem happy
with the design we collectively came up with (its slightly
different to the one in both the XFS patch and Alan's patch
at the moment).

cheers.

-- 
Nathan
