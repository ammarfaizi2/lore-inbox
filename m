Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262295AbREXVHK>; Thu, 24 May 2001 17:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262288AbREXVHA>; Thu, 24 May 2001 17:07:00 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:22024 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S262286AbREXVGs>; Thu, 24 May 2001 17:06:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@turbolinux.com>,
        "Peter J. Braam" <braam@mountainviewdata.com>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device arguments from lookup)
Date: Thu, 24 May 2001 23:07:57 +0200
X-Mailer: KMail [version 1.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Andreas Dilger <adilger@turbolinux.com>,
        Alexander Viro <viro@math.psu.edu>, Edgar Toernig <froese@gmx.de>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <200105222010.f4MKAWZk011755@webber.adilger.int>
In-Reply-To: <200105222010.f4MKAWZk011755@webber.adilger.int>
MIME-Version: 1.0
Message-Id: <0105242307570P.06233@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 May 2001 22:10, Andreas Dilger wrote:
> Peter Braam writes:
> > File system journal recovery can corrupt a snapshot, because it
> > copies data that needs to be preserved in a snapshot. During
> > journal replay such data may be copied again, but the source can
> > have new data already.
>
> The way it is implemented in reiserfs is to wait for existing
> transactions to complete, entirely flush the journal and block all
> new transactions from starting.  Stephen implemented a journal flush
> API to do this for ext3, but the hooks to call it from LVM are not in
> place yet.  This way the journal is totally empty at the time the
> snapshot is done, so the read-only copy does not need to do journal
> recovery, so no problems can arise.

I suppose I'm just reiterating the obvious, but we should eventually
have a generic filesystem transaction API at the VFS level, once we
have enough data points to know what the One True API should be.

--
Daniel
