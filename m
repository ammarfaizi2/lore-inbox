Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbRBUWy6>; Wed, 21 Feb 2001 17:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130408AbRBUWyv>; Wed, 21 Feb 2001 17:54:51 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:46601 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129183AbRBUWyd>; Wed, 21 Feb 2001 17:54:33 -0500
Message-ID: <3A94470C.2E54EB58@transmeta.com>
Date: Wed, 21 Feb 2001 14:54:04 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Martin Mares <mj@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <20010221220835.A8781@atrey.karlin.mff.cuni.cz> <XFMail.20010221132959.davidel@xmailserver.org> <20010221223238.A17903@atrey.karlin.mff.cuni.cz> <971ejs$139$1@cesium.transmeta.com> <20010221233204.A26671@atrey.karlin.mff.cuni.cz> <3A94435D.59A4D729@transmeta.com> <20010221235008.A27924@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares wrote:
> 
> Hello!
> 
> > You're right.  However, for each hash table operation to be O(1) the size
> > of the hash table must be >> n.
> 
> If we are talking about average case complexity (which is the only possibility
> with fixed hash function and arbitrary input keys), it suffices to have
> hash table size >= c*n for some constant c which gives O(1/c) cost of
> all operations.
> 

True.  Note too, though, that on a filesystem (which we are, after all,
talking about), if you assume a large linear space you have to create a
file, which means you need to multiply the cost of all random-access
operations with O(log n).

> > I suggested at one point to use B-trees with a hash value as the key.
> > B-trees are extremely efficient when used on a small constant-size key.
> 
> Although from asymptotic complexity standpoint hashing is much better
> than B-trees, I'm not sure at all what will give the best performance for
> reasonable directory sizes. Maybe the B-trees are really the better
> alternative as they are updated dynamically and the costs of successive
> operations are similar as opposed to hashing which is occassionally very
> slow due to rehashing unless you try to rehash on-line, but I don't
> know any algorithm for on-line rehashing with both inserts and deletes
> which wouldn't be awfully complex and slow (speaking of multiplicative
> constants, of course -- it's still O(1) per operation, but "the big Oh
> is really big there").

Well, once you multiply with O(log n) for the file indirection (which
B-trees don't need, since they inherently handle blocking and thus can
use block pointers directly) then the asymptotic complexity is the same
as well, and I think the B-trees are the overall winner.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
