Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263136AbTJQAgm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 20:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTJQAgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 20:36:42 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:5385 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S263136AbTJQAgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 20:36:41 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [RFC] frandom - fast random generator module
Date: Fri, 17 Oct 2003 00:34:41 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <bmndf1$a0k$1@abraham.cs.berkeley.edu>
References: <3F8E552B.3010507@users.sf.net> <20031016121825.D7000@schatzie.adilger.int> <3F8F26F0.6080002@pobox.com> <20031016174227.K7000@schatzie.adilger.int>
Reply-To: daw@cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1066350881 10260 128.32.153.211 (17 Oct 2003 00:34:41 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Fri, 17 Oct 2003 00:34:41 +0000 (UTC)
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger  wrote:
>For the current version of Lustre security is not a primary concern (our
>customers run Lustre in very secure network environments).  We started
>with get_random_bytes() but had to remove it because of the overhead.
>Note that the random numbers are produced and consumed local to a single
>node but are passed over the network to clients as an opaque handle,
>so cross-node collisions are not a concern.
>
>At some point in the future we may need to increase the security of such
>handles, but it would be nice to not increase the CPU usage as much as
>get_random_bytes() did.  Direct HW RNG would suit this perfectly.

I don't get it.  What do you mean by "increase the security"?
If your security relies on unpredictability, then with a non-cryptographic
PRNG, you have no security.  What am I missing?

I'm just not seeing how frandom is going to make your life any better
here.  In almost every security system I've ever looked at, either you
need a full-strength crypto PRNG, or else a simple counter is enough.

>Note that the security of these handles isn't really that critical to
>the overall security model when implemented (which will be kerberos based
>like AFS and DCE), but it would be nice from a warm-n-fuzzy point of view
>to have something better than "last handle + N" which is what we have now.

I am always suspicious of warm-n-fuzzy arguments, when it comes to
security.  Either it is security-critical, or it isn't.  And, if you
don't know whether or not it is security-critical, look out!

If the most compelling argument we can come up with for putting
frandom in the kernel is warm-n-fuzzies...  well, I think we can all
draw some conclusions from that.
