Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbREWJf5>; Wed, 23 May 2001 05:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263036AbREWJfs>; Wed, 23 May 2001 05:35:48 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:22102 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263033AbREWJfd>; Wed, 23 May 2001 05:35:33 -0400
Date: Wed, 23 May 2001 10:13:32 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Peter J. Braam" <braam@mountainviewdata.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Andreas Dilger <adilger@turbolinux.com>,
        Alexander Viro <viro@math.psu.edu>, Edgar Toernig <froese@gmx.de>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device arguments from lookup)
Message-ID: <20010523101332.B27177@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0105221204590.3906-100000@penguin.transmeta.com> <Pine.LNX.4.33.0105221311430.1296-100000@lustre.us.mvd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0105221311430.1296-100000@lustre.us.mvd>; from braam@mountainviewdata.com on Tue, May 22, 2001 at 01:16:42PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 22, 2001 at 01:16:42PM -0600, Peter J. Braam wrote:
 
> File system journal recovery can corrupt a snapshot, because it copies
> data that needs to be preserved in a snapshot.

Journal recovery may move data from the journal to other locations on
the device, yes, but that doesn't change the logical contents of the
filesystem.  I don't see how that results in "corruption": the
snapshot is (or at least, ought to be!) fully independent of the
original version of the data, so such recovery should only be taking
the snapshot from one consistent state to a different but equivalent
state.

> During journal replay such
> data may be copied again, but the source can have new data already.

Only if you are recovering a live volume, surely?  And that is
*guaranteed* to cause problems.  

--Stephen
