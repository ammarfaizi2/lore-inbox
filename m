Return-Path: <linux-kernel-owner+w=401wt.eu-S1030324AbXALUwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbXALUwK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 15:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbXALUwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 15:52:10 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:20768 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030324AbXALUwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 15:52:09 -0500
Message-ID: <45A7F4F2.2080903@tls.msk.ru>
Date: Fri, 12 Jan 2007 23:52:02 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: Chris Mason <chris.mason@oracle.com>, Linus Torvalds <torvalds@osdl.org>,
       dean gaudet <dean@arctic.org>, Viktor <vvp01@inbox.ru>,
       Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru> <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org> <Pine.LNX.4.64.0701112351520.18431@twinlark.arctic.org> <Pine.LNX.4.64.0701120955440.3594@woody.osdl.org> <20070112202316.GA28400@think.oraclecorp.com> <45A7F396.4080600@tls.msk.ru>
In-Reply-To: <45A7F396.4080600@tls.msk.ru>
X-Enigmail-Version: 0.94.1.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
[]
> After all the explanations, I still don't see anything wrong with the
> interface itself.  O_DIRECT isn't "different semantics" - we're still
> writing and reading some data.  Yes, O_DIRECT and non-O_DIRECT usages
> somewhat contradicts with each other, but there are other ways to make
> the two happy, instead of introducing alot of stupid, complex, and racy
> code all over.

By the way.  I just ran - for fun - a read test of a raid array.

Reading blocks of size 512kbytes, starting at random places on a 400Gb
array, doing 64threads.

 O_DIRECT: 336.73 MB/sec.
!O_DIRECT: 146.00 MB/sec.

Quite a... difference here.

Using posix_fadvice() does not improve it.

/mjt
