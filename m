Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbTJPVhl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 17:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbTJPVhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 17:37:41 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:41390 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263225AbTJPVhj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 17:37:39 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 16 Oct 2003 14:33:39 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Val Henson <val@nmt.edu>, Larry McVoy <lm@work.bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Transparent compression in the FS
In-Reply-To: <3F8F0766.30405@pobox.com>
Message-ID: <Pine.LNX.4.56.0310161422170.2217@bigblue.dev.mdolabs.com>
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl>
 <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random>
 <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14>
 <3F8F0766.30405@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Oct 2003, Jeff Garzik wrote:

> Val Henson wrote:
> > Abstract:
> >
> >  "Recent research has produced a new and perhaps dangerous technique
> >   for uniquely identifying blocks that I will call
> >   compare-by-hash. Using this technique, we decide whether two blocks
> >   are identical to each other by comparing their hash values, using a
> >   collision-resistant hash such as SHA-1. If the hash values match,
> >   we assume the blocks are identical without further ado. Users of
> >   compare-by-hash argue that this assumption is warranted because the
> >   chance of a hash collision between any two randomly generated blocks
> >   is estimated to be many orders of magnitude smaller than the chance
> >   of many kinds of hardware errors. Further analysis shows that this
> >   approach is not as risk-free as it seems at first glance."
>
>
> I'm curious if anyone has done any work on using multiple different
> checksums?  For example, the cost of checksumming a single block with
> multiple algorithms (sha1+md5+crc32 for a crazy example), and storing
> each checksum (instead of just one sha1 sum), may be faster than reading
> the block off of disk to compare it with the incoming block.  OTOH,
> there is still a mathematical possibility (however-more-remote) of a
> collission...

At that point it is better to extend the fingerprint size, since the SHA1
algorithm has a better distribution compared to md5 and crc32. Probability
estimates are pretty low though. If you consider a 2^32 blocks FS, that
with a 4Kb block size makes a 4 tera FS, the collision probability is in
the orders of 2^(-95) (with a 160 bit fingerprint). That's a pretty low
number. Yes, it is true that the input is not completely random, but a
good property of SHA1 is the one of spreading output result of very
similar input patterns.




- Davide

