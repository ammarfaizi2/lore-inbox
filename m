Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbRBUWis>; Wed, 21 Feb 2001 17:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbRBUWii>; Wed, 21 Feb 2001 17:38:38 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:51720 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129170AbRBUWi2>; Wed, 21 Feb 2001 17:38:28 -0500
Message-ID: <3A94435D.59A4D729@transmeta.com>
Date: Wed, 21 Feb 2001 14:38:21 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Martin Mares <mj@suse.cz>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <20010221220835.A8781@atrey.karlin.mff.cuni.cz> <XFMail.20010221132959.davidel@xmailserver.org> <20010221223238.A17903@atrey.karlin.mff.cuni.cz> <971ejs$139$1@cesium.transmeta.com> <20010221233204.A26671@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares wrote:
> 
> Hello!
> 
> > Not true.  The rehashing is O(n) and it has to be performed O(log n)
> > times during insertion.  Therefore, insertion is O(log n).
> 
> Rehashing is O(n), but the "n" is the _current_ number of items, not the
> maximum one after all the insertions.
> 
> Let's assume you start with a single-entry hash table. You rehash for the
> first time after inserting the first item (giving hash table of size 2),
> then after the second item (=> size 4), then after the fourth item (=> size 8)
> and so on. I.e., when you insert n items, the total cost of rehashing summed
> over all the insertions is at most 1 + 2 + 4 + 8 + 16 + ... + 2^k (where
> k=floor(log2(n))) <= 2^k+1 = O(n). That is O(1) operations per item inserted.
> 

You're right.  However, for each hash table operation to be O(1) the size
of the hash table must be >> n.

I suggested at one point to use B-trees with a hash value as the key. 
B-trees are extremely efficient when used on a small constant-size key.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
