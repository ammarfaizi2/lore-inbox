Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318118AbSIETIs>; Thu, 5 Sep 2002 15:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318123AbSIETIs>; Thu, 5 Sep 2002 15:08:48 -0400
Received: from [195.223.140.120] ([195.223.140.120]:14194 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318118AbSIETIr>; Thu, 5 Sep 2002 15:08:47 -0400
Date: Thu, 5 Sep 2002 21:13:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       lord@sgi.com
Subject: Re: 2.4.20pre5aa1
Message-ID: <20020905191325.GI1657@dualathlon.random>
References: <20020904233528.GA1238@dualathlon.random> <20020905134414.A1784@infradead.org> <20020905165307.GC1254@dualathlon.random> <20020905180904.A8406@infradead.org> <20020905184125.GA1657@dualathlon.random> <20020905194649.A11789@infradead.org> <20020905185917.GG1657@dualathlon.random> <20020905200240.A12253@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020905200240.A12253@infradead.org>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 08:02:40PM +0100, Christoph Hellwig wrote:
> we either need to use your accessors for i_size or take the XFS inode
> lock around vmtruncate.

the latter would take care of O_DIRECT too I think. Of course it's
mostly a theorical issue, I mentioned it just so you would check it,
keep it in mind and eventually fix it, we had this kind of races in the
32bit architectures in on all the fs for ages, infact you know 2.4-aa is
the only tree out there with these race fixed for most important fs, 2.4
and 2.5 mainline are still racy too (2.4 because it was a recent
discovery, 2.5 because it's my mistake that I didn't yet had time to
submit fixes, btw, if anybody is interested to port to 2.5 that's
welcome).  For the normal fs I didn't want to add locks around the read
and truncate paths, and that's why I implemented the lockless accessors,
also consiering the accessors are zerocost noops on all the 64bit archs
(long [or should now say "short" :) ] term thinking).

Andrea
