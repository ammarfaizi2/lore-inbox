Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUBQIFx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 03:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUBQIFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 03:05:53 -0500
Received: from hera.kernel.org ([63.209.29.2]:28372 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S263166AbUBQIFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 03:05:51 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: UTF-8 and case-insensitivity
Date: Tue, 17 Feb 2004 08:05:24 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c0si04$nnt$1@terminus.zytor.com>
References: <16433.38038.881005.468116@samba.org> <c0sgnc$ngo$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: terminus.zytor.com 1077005124 24318 63.209.29.3 (17 Feb 2004 08:05:24 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 17 Feb 2004 08:05:24 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <c0sgnc$ngo$1@terminus.zytor.com>
By author:    hpa@zytor.com (H. Peter Anvin)
In newsgroup: linux.dev.kernel
> 
> Realistically, the only sane way to do this is to set our foot down
> and say: UTF-8 is *the* encoding.  A good step in that direction would
> be to set utf-8 to be the default NLS in the kernel, but as long as
> people keep the whole sick idea that we can continue to use
> locale-dependent encoding we're in for a world of hurt.
> 
> That's really the long and short of it.  Until people are willing to
> say "we support UTF-8, anything else and it's anyone's guess what
> happens" then nothing is going to happen.
> 

Oh yes, on top of that, if you want case insensitivity, then you also
need to start thinking about a whole lot of other things, including
what normalization form(s) you care about.  Keeping normalization (as
well as case-conversion) data for the entire Unicode space in the
kernel is a boatload of memory.

Then, you have to deal with your filesystem going sour on you when two
files suddenly alias, because there is a new revision of the mapping
tables.

Case seemed simple when we were dealing with the "let's teach them all
English" world, but even when you're dealing with languages like
German (ß) or Dutch (Ĳ) things get fuzzy... what's worse, in
Turkish the uppercase equivalent of "i" (U+0069) isn't "I" (U+0049),
it's "İ" (U+0130)!  There is no table which can tell you that, since
it's context-dependent.  Thus, you may now need to consider larger
equivalence classes, but is the other user expecting the same thing?
You can't just use the same base letter being equivalent everywhere,
or a Swedish user would beat the sh*t out of you for confusing the
words "vas" and "väs".  On the other hand, the Swedish user would be
perfectly happy having "ä" equivalent with "æ" and "ü" equivalent
with "y"!

Therein lies madness.

	-hpa



-- 
PGP public key available - finger hpa@zytor.com
Key fingerprint: 2047/2A960705 BA 03 D3 2C 14 A8 A8 BD  1E DF FE 69 EE 35 BD 74
"The earth is but one country, and mankind its citizens."  --  Bah�'u'll�h
Just Say No to Morden * The Shadows were defeated -- Babylon 5 is renewed!!
