Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319362AbSHQGC5>; Sat, 17 Aug 2002 02:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319363AbSHQGC5>; Sat, 17 Aug 2002 02:02:57 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:15090 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S319362AbSHQGC4>; Sat, 17 Aug 2002 02:02:56 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Sat, 17 Aug 2002 00:05:07 -0600
To: Oliver Xymoron <oxymoron@waste.org>
Cc: henrique <henrique@cyclades.com>, linux-kernel@vger.kernel.org
Subject: Re: Problem with random.c and PPC
Message-ID: <20020817060507.GM9642@clusterfs.com>
Mail-Followup-To: Oliver Xymoron <oxymoron@waste.org>,
	henrique <henrique@cyclades.com>, linux-kernel@vger.kernel.org
References: <80256C17.00376E92.00@notesmta.eur.3com.com> <20020816195254.GL5418@waste.org> <200208161751.35895.henrique@cyclades.com> <20020817004520.GN5418@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020817004520.GN5418@waste.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 16, 2002  19:45 -0500, Oliver Xymoron wrote:
> Realistically, the hashing done by /dev/urandom is probably strong
> enough for most purposes. It's as cryptographically strong as whatever
> block cipher you're likely to use with it. /dev/random goes one step
> further and tries to offer something that's theoretically
> unbreakable. Useful for generating things like large public keys, less
> useful for generating the session keys used by SSL and the
> like. They're easier to break by direct attack.

One of the problems, I believe, is that reading from /dev/urandom will
also deplete the entropy pool, just like reading from /dev/random.
The only difference is that when the entropy is gone /dev/random will
stop and /dev/urandom will continue to provide data.

If you are in there fixing things, it might make sense to have
/dev/urandom extract entropy from the random pool far less often than
/dev/random.  This way people who use /dev/urandom for a source of
less-strong randomness (e.g. TCP sequence numbers or whatever), will
not be shooting themselves in the foot for when they need a 2048-byte
PGP key, if they are low on entropy sources.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

