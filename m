Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133073AbRDLIpF>; Thu, 12 Apr 2001 04:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133074AbRDLIoz>; Thu, 12 Apr 2001 04:44:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:65165 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S133073AbRDLIot>;
	Thu, 12 Apr 2001 04:44:49 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15061.27388.843554.687422@pizda.ninka.net>
Date: Thu, 12 Apr 2001 01:44:44 -0700 (PDT)
To: Alexander Viro <viro@math.psu.edu>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Andreas Dilger <adilger@turbolinux.com>, kowalski@datrix.co.za,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [CFT][PATCH] Re: Fwd: Re: memory usage - dentry_cache
In-Reply-To: <Pine.GSO.4.21.0104120257070.18135-100000@weyl.math.psu.edu>
In-Reply-To: <3AD550F0.8058FAA@mandrakesoft.com>
	<Pine.GSO.4.21.0104120257070.18135-100000@weyl.math.psu.edu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alexander Viro writes:
 > OK, how about wider testing? Theory: prune_dcache() goes through the
 > list of immediately killable dentries and tries to free given amount.
 > It has a "one warning" policy - it kills dentry if it sees it twice without
 > lookup finding that dentry in the interval. Unfortunately, as implemented
 > it stops when it had freed _or_ warned given amount. As the result, memory
 > pressure on dcache is less than expected.

The reason the code is how it is right now is there used to be a bug
where that goto spot would --count but not check against zero, making
count possibly go negative and then you'd be there for a _long_ time
:-)

Just a FYI...

Later,
David S. Miller
davem@redhat.com
