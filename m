Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262392AbREXWDx>; Thu, 24 May 2001 18:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262390AbREXWDo>; Thu, 24 May 2001 18:03:44 -0400
Received: from idiom.com ([216.240.32.1]:27142 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S262382AbREXWDb>;
	Thu, 24 May 2001 18:03:31 -0400
Message-ID: <3B0D8465.B1A13674@namesys.com>
Date: Thu, 24 May 2001 15:00:05 -0700
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Andreas Dilger <adilger@turbolinux.com>,
        "Peter J. Braam" <braam@mountainviewdata.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, Edgar Toernig <froese@gmx.de>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <200105222010.f4MKAWZk011755@webber.adilger.int> <0105242307570P.06233@starship>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Tuesday 22 May 2001 22:10, Andreas Dilger wrote:
> > Peter Braam writes:
> > > File system journal recovery can corrupt a snapshot, because it
> > > copies data that needs to be preserved in a snapshot. During
> > > journal replay such data may be copied again, but the source can
> > > have new data already.
> >
> > The way it is implemented in reiserfs is to wait for existing
> > transactions to complete, entirely flush the journal and block all
> > new transactions from starting.  Stephen implemented a journal flush
> > API to do this for ext3, but the hooks to call it from LVM are not in
> > place yet.  This way the journal is totally empty at the time the
> > snapshot is done, so the read-only copy does not need to do journal
> > recovery, so no problems can arise.
> 
> I suppose I'm just reiterating the obvious, but we should eventually
> have a generic filesystem transaction API at the VFS level, once we
> have enough data points to know what the One True API should be.
> 
> --
> Daniel
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Daniel, implementing transactions is not a trivial thing as you probably know. 
It requires that you resolve such issues as, what happens if the user forgets to
close the transaction, issues of lock/transaction duration, of transaction
batching, of levels of isolation, of concurrent transactions modifying global fs
metadata and some but not all of those concurrent transactions receiving a
rollback, and of permissions relating to keeping transactions open.  I would
encourage you to participate in the reiser4 design discussion we will be having
over the next 6 months, and give us your opinions.  Josh will be leading that
design effort for the ReiserFS team.

Hans
