Return-Path: <linux-kernel-owner+w=401wt.eu-S932216AbXADAor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbXADAor (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 19:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbXADAoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 19:44:46 -0500
Received: from pat.uio.no ([129.240.10.15]:34080 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932211AbXADAop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 19:44:45 -0500
Subject: Re: [nfsv4] RE: Finding hardlinks
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Benny Halevy <bhalevy@panasas.com>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, nfsv4@ietf.org,
       linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@poochiereds.net>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <459BA30A.4020809@panasas.com>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
	 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>
	 <20061221185850.GA16807@delft.aura.cs.cmu.edu>
	 <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
	 <1166869106.3281.587.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
	 <4593890C.8030207@panasas.com> <4593C524.8070209@poochiereds.net>
	 <4593DEF8.5020609@panasas.com>
	 <Pine.LNX.4.64.0612281916230.2960@artax.karlin.mff.cuni.cz>
	 <E472128B1EB43941B4E7FB268020C89B149CEC@riverside.int.panasas.com>
	 <1167388129.6106.45.camel@lade.trondhjem.org>
	 <E472128B1EB43941B4E7FB268020C89B149CF1@riverside.int.panasas.com>
	 <1167780097.6090.104.camel@lade.trondhjem.org>
	 <459BA30A.4020809@panasas.com>
Content-Type: text/plain
Date: Thu, 04 Jan 2007 01:43:42 +0100
Message-Id: <1167871422.6046.42.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=unavailable, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: 917FB3580A7359DD564FB49E26A67F6646CC8529
X-UiO-SPAM-Test: 83.109.147.16 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-03 at 14:35 +0200, Benny Halevy wrote:
> Believe it or not, but server companies like Panasas try to follow the standard
> when designing and implementing their products while relying on client vendors
> to do the same.

I personally have never given a rats arse about "standards" if they make
no sense to me. If the server is capable of knowing about hard links,
then why does it need all this extra crap in the filehandle that just
obfuscates the hard link info?

The bottom line is that nothing in our implementation will result in
such a server performing sub-optimally w.r.t. the client. The only
result is that we will conform to close-to-open semantics instead of
strict POSIX caching semantics when two processes have opened the same
file via different hard links.

> I sincerely expect you or anybody else for this matter to try to provide
> feedback and object to the protocol specification in case they disagree
> with it (or think it's ambiguous or self contradicting) rather than ignoring
> it and implementing something else. I think we're shooting ourselves in the
> foot when doing so and it is in our common interest to strive to reach a
> realistic standard we can all comply with and interoperate with each other.

This has nothing to do with the protocol itself: it has only to do with
caching semantics. As far as caching goes, the only guarantees that NFS
clients give are the close-to-open semantics, and this should indeed be
respected by the implementation in question.

Trond

