Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTE3Evz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 00:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTE3Evz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 00:51:55 -0400
Received: from cs.rice.edu ([128.42.1.30]:14790 "EHLO cs.rice.edu")
	by vger.kernel.org with ESMTP id S263275AbTE3Evx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 00:51:53 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
References: <oydbrxlbi2o.fsf@bert.cs.rice.edu>
	<1054267067.2713.3.camel@rth.ninka.net>
From: Scott A Crosby <scrosby@cs.rice.edu>
Organization: Rice University
Date: 30 May 2003 00:04:24 -0500
In-Reply-To: <1054267067.2713.3.camel@rth.ninka.net>
Message-ID: <oyd3cixc9ev.fsf@bert.cs.rice.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 May 2003 20:57:47 -0700, "David S. Miller" <davem@redhat.com> writes:

> On Thu, 2003-05-29 at 13:42, Scott A Crosby wrote:
> > I highly advise using a universal hashing library, either our own or
> > someone elses. As is historically seen, it is very easy to make silly
> > mistakes when attempting to implement your own 'secure' algorithm.
> 
> Why are you recommending this when after 2 days of going back
> and forth in emails with me you came to the conclusion that for
> performance critical paths such as the hashes in the kernel the Jenkins
> hash was an acceptable choice?

That was a boilerplate paragraph in all the other vulnerability
reports I shipped out today. Perhaps I should have stripped out out or
replaced it.

> It is unacceptably costly to use a universal hash,

Yup the Jenkin's is about 5 times faster than our CW construction on
SPARC, and thus likely at least as much faster on a wide variety of
other CPU's. I do not know if the dcache hash is performance critical,
nor do I know if there exists other more efficient universal hash
functions.

In any case, the attacks I describe are strong in relative terms, but
rather weak in terems of actual impact, so fixing it may not matter
much.

> Some embedded folks will have your head on a platter if we end up using
> a universal hash function for the DCACHE solely based upon your advice.
> :-)

Have you seen the current dcache function?

/* Linux dcache */
#define HASH_3(hi,ho,c)  ho=(hi + (c << 4) + (c >> 4)) * 11


Scott
