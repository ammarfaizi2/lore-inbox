Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263422AbREXI6o>; Thu, 24 May 2001 04:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263425AbREXI6f>; Thu, 24 May 2001 04:58:35 -0400
Received: from zeus.kernel.org ([209.10.41.242]:45209 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S263427AbREXI6V>;
	Thu, 24 May 2001 04:58:21 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105222010.f4MKAWZk011755@webber.adilger.int>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD  w/info-PATCH]device
 arguments from lookup)
In-Reply-To: <Pine.LNX.4.33.0105221311430.1296-100000@lustre.us.mvd>
 "from Peter J. Braam at May 22, 2001 01:16:42 pm"
To: "Peter J. Braam" <braam@mountainviewdata.com>
Date: Tue, 22 May 2001 14:10:32 -0600 (MDT)
CC: Linus Torvalds <torvalds@transmeta.com>,
        Andreas Dilger <adilger@turbolinux.com>,
        Alexander Viro <viro@math.psu.edu>, Edgar Toernig <froese@gmx.de>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Braam writes:
> On Tue, 22 May 2001, Andreas Dilger wrote:
> > Actually, the LVM snapshot
> > interface has (optional) hooks into the filesystem to ensure that it
> > is consistent at the time the snapshot is created.
> 
> File system journal recovery can corrupt a snapshot, because it copies
> data that needs to be preserved in a snapshot. During journal replay such
> data may be copied again, but the source can have new data already.

The way it is implemented in reiserfs is to wait for existing transactions
to complete, entirely flush the journal and block all new transactions from
starting.  Stephen implemented a journal flush API to do this for ext3, but
the hooks to call it from LVM are not in place yet.  This way the journal is
totally empty at the time the snapshot is done, so the read-only copy does
not need to do journal recovery, so no problems can arise.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
