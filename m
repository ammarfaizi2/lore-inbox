Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262738AbREVTPi>; Tue, 22 May 2001 15:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262736AbREVTP2>; Tue, 22 May 2001 15:15:28 -0400
Received: from teranet244-12-200.monarch.net ([24.244.12.200]:43012 "HELO
	lustre.us.mvd") by vger.kernel.org with SMTP id <S262734AbREVTPS>;
	Tue, 22 May 2001 15:15:18 -0400
Date: Tue, 22 May 2001 13:16:42 -0600 (MDT)
From: "Peter J. Braam" <braam@mountainviewdata.com>
X-X-Sender: <braam@lustre.us.mvd>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andreas Dilger <adilger@turbolinux.com>,
        Alexander Viro <viro@math.psu.edu>, Edgar Toernig <froese@gmx.de>,
        Ben LaHaise <bcrl@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <Pine.LNX.4.21.0105221204590.3906-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0105221311430.1296-100000@lustre.us.mvd>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 May 2001, Linus Torvalds wrote:
>


> On Tue, 22 May 2001, Andreas Dilger wrote:  Actually, the LVM snapshot
> interface has (optional) hooks into the filesystem to ensure that it
> is consistent at the time the snapshot is created.

But I think that LVM is implemented "the wrong way around".

File system journal recovery can corrupt a snapshot, because it copies
data that needs to be preserved in a snapshot. During journal replay such
data may be copied again, but the source can have new data already.

Most LVM snapshot systems write the new data in the separate volume and
don't copy the old data that eliminates this problem (and also eliminates
the copy of data but introduces data copy when a snapshot is removed).

- Peter -

