Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263114AbTJPRtg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 13:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbTJPRtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 13:49:36 -0400
Received: from mailhost.NMT.EDU ([129.138.4.52]:23712 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id S263114AbTJPRtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 13:49:32 -0400
Date: Thu, 16 Oct 2003 11:49:27 -0600
From: Val Henson <val@nmt.edu>
To: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031016174927.GB25836@speare5-1-14>
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031016172930.GA5653@work.bitmover.com>
User-Agent: Mutt/1.4.1i
X-Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 10:29:30AM -0700, Larry McVoy wrote:
> On Wed, Oct 15, 2003 at 11:13:27AM -0400, Jeff Garzik wrote:
> > Josh and others should take a look at Plan9's venti file storage method 
> > -- archival storage is a series of unordered blocks, all of which are 
> > indexed by the sha1 hash of their contents.  This magically coalesces 
> > all duplicate blocks by its very nature, including the loooooong runs of 
> > zeroes that you'll find in many filesystems.  I bet savings on "all 
> > bytes in this block are zero" are worth a bunch right there.
> 
> The only problem with this is that you can get false positives.  Val Hensen
> recently wrote a paper about this.  It's really unlikely that you get false
> positives but it can happen and it has happened in the field.  

To be fair, I talked to someone who claims that Venti now checks for
hash collisions on writes, but that's not what the original paper
describes and I haven't confirmed it.

The compare-by-hash paper is only 6 pages long, at least take the time
to read it before you start using compare-by-hash:

http://www.usenix.org/events/hotos03/tech/henson.html

Abstract:

 "Recent research has produced a new and perhaps dangerous technique
  for uniquely identifying blocks that I will call
  compare-by-hash. Using this technique, we decide whether two blocks
  are identical to each other by comparing their hash values, using a
  collision-resistant hash such as SHA-1. If the hash values match,
  we assume the blocks are identical without further ado. Users of
  compare-by-hash argue that this assumption is warranted because the
  chance of a hash collision between any two randomly generated blocks
  is estimated to be many orders of magnitude smaller than the chance
  of many kinds of hardware errors. Further analysis shows that this
  approach is not as risk-free as it seems at first glance."

-VAL (not subscribed to l-k ATM)
