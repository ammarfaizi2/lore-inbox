Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWGAK1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWGAK1q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 06:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWGAK1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 06:27:46 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:20563 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1750881AbWGAK1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 06:27:45 -0400
Message-ID: <44A64E1B.2030501@tls.msk.ru>
Date: Sat, 01 Jul 2006 14:27:39 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Daniel Phillips <phillips@google.com>,
       Johann Lombardi <johann.lombardi@bull.net>, sho@tnes.nec.co.jp,
       cmm@us.ibm.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] ext3: enlarge blocksize and fix rec_len overflow
References: <20060628205238sho@rifu.tnes.nec.co.jp> <20060628155048.GG2893@chiva> <20060628202421.GL5318@schatzie.adilger.int> <44A417A3.80001@google.com> <20060629202700.GD5318@schatzie.adilger.int> <44A450BB.60105@google.com> <20060630093113.GA2702@chiva> <44A56B45.6050506@google.com> <20060701083950.GB5355@schatzie.adilger.int>
In-Reply-To: <20060701083950.GB5355@schatzie.adilger.int>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> On Jun 30, 2006  11:19 -0700, Daniel Phillips wrote:
>> OK, just to handle the 64K case, what is wrong with treating 0 as 64K?
> 
> Hmm, good question - it's impossible to have a valid rec_len of 0 bytes.
> There would need to be some special casing in the directory handling code.
> Also, it breaks some of the directory sanity checking, and since "0" is
> a common corruption pattern it isn't great to use.  We could instead use
> 0xfffc to mean 0x10000 since they are virtually the same value and the
> error checking is safe.  It isn't possible to have this as a valid value.

I understand the wishes to extend the filesystem capabilities which are
now becoming limited. I understand sometimes it's relatively easy to
"extend the width" of some on-disk fields this way.

But.

Isn't this sort of kludges (in a normally numeric field of a limited width,
introduce special normally-impossible values to mean different values) are
the ways to complicate things (code) and confuse various tools and people
for too much, making the whole thing just broken by design?

A line should be drawn somewhere.  When, after breaking (and thus "fixing")
some currently present limit, we change internal semantics in an ugly way,
maybe it's really better to change original design and introduce new,
somehow incompatible filesystem instead?

Please excuse me if this my comment is entirely beyong the point, because,
well.. to be fair, I don't quite understand what's the whole talk about,
I'm just reading the above (quoted) email out of context... ;)

/mjt
