Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbRBUWci>; Wed, 21 Feb 2001 17:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129281AbRBUWc2>; Wed, 21 Feb 2001 17:32:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:32012 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S130247AbRBUWcR>; Wed, 21 Feb 2001 17:32:17 -0500
Date: Wed, 21 Feb 2001 23:32:04 +0100
From: Martin Mares <mj@suse.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
Message-ID: <20010221233204.A26671@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010221220835.A8781@atrey.karlin.mff.cuni.cz> <XFMail.20010221132959.davidel@xmailserver.org> <20010221223238.A17903@atrey.karlin.mff.cuni.cz> <971ejs$139$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <971ejs$139$1@cesium.transmeta.com>; from hpa@zytor.com on Wed, Feb 21, 2001 at 02:14:20PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Not true.  The rehashing is O(n) and it has to be performed O(log n)
> times during insertion.  Therefore, insertion is O(log n).

Rehashing is O(n), but the "n" is the _current_ number of items, not the
maximum one after all the insertions.

Let's assume you start with a single-entry hash table. You rehash for the
first time after inserting the first item (giving hash table of size 2),
then after the second item (=> size 4), then after the fourth item (=> size 8)
and so on. I.e., when you insert n items, the total cost of rehashing summed
over all the insertions is at most 1 + 2 + 4 + 8 + 16 + ... + 2^k (where
k=floor(log2(n))) <= 2^k+1 = O(n). That is O(1) operations per item inserted.

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
MIPS: Meaningless Indicator of Processor Speed.
