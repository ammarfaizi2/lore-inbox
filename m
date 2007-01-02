Return-Path: <linux-kernel-owner+w=401wt.eu-S965019AbXABXPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbXABXPF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 18:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbXABXPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 18:15:05 -0500
Received: from pat.uio.no ([129.240.10.15]:38826 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965019AbXABXPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 18:15:01 -0500
Subject: Re: Finding hardlinks
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Arjan van de Ven <arjan@infradead.org>, Benny Halevy <bhalevy@panasas.com>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
In-Reply-To: <Pine.LNX.4.64.0612300154510.19928@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
	 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>
	 <20061221185850.GA16807@delft.aura.cs.cmu.edu>
	 <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
	 <1166869106.3281.587.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
	 <4593890C.8030207@panasas.com>
	 <1167300352.3281.4183.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0612281909200.2960@artax.karlin.mff.cuni.cz>
	 <1167388475.6106.51.camel@lade.trondhjem.org>
	 <Pine.LNX.4.64.0612300154510.19928@artax.karlin.mff.cuni.cz>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 00:14:28 +0100
Message-Id: <1167779668.6090.95.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.6, required=12.0, autolearn=ham, BAYES_00=-2.599,UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: 584C1768E0E076EAA777DDF21A46B22719B86EAF
X-UiO-SPAM-Test: 83.109.147.16 spam_score -75 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-30 at 02:04 +0100, Mikulas Patocka wrote:
> 
> On Fri, 29 Dec 2006, Trond Myklebust wrote:
> 
> > On Thu, 2006-12-28 at 19:14 +0100, Mikulas Patocka wrote:
> >> Why don't you rip off the support for colliding inode number from the
> >> kernel at all (i.e. remove iget5_locked)?
> >>
> >> It's reasonable to have either no support for colliding ino_t or full
> >> support for that (including syscalls that userspace can use to work with
> >> such filesystem) --- but I don't see any point in having half-way support
> >> in kernel as is right now.
> >
> > What would ino_t have to do with inode numbers? It is only used as a
> > hash table lookup. The inode number is set in the ->getattr() callback.
> 
> The question is: why does the kernel contain iget5 function that looks up 
> according to callback, if the filesystem cannot have more than 64-bit 
> inode identifier?

Huh? The filesystem can have as large a damned identifier as it likes.
NFSv4 uses 128-byte filehandles, for instance.

POSIX filesystems are another matter. They can only have 64-bit
identifiers thanks to the requirement that inode numbers be 64-bit
unique and permanently stored, however Linux caters for a whole
truckload of filesystems which will never fit that label: look at all
those users of iunique(), for one...

Trond

