Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbRBUWui>; Wed, 21 Feb 2001 17:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbRBUWu3>; Wed, 21 Feb 2001 17:50:29 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:781 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129181AbRBUWuK>; Wed, 21 Feb 2001 17:50:10 -0500
Date: Wed, 21 Feb 2001 23:50:08 +0100
From: Martin Mares <mj@suse.cz>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
Message-ID: <20010221235008.A27924@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010221220835.A8781@atrey.karlin.mff.cuni.cz> <XFMail.20010221132959.davidel@xmailserver.org> <20010221223238.A17903@atrey.karlin.mff.cuni.cz> <971ejs$139$1@cesium.transmeta.com> <20010221233204.A26671@atrey.karlin.mff.cuni.cz> <3A94435D.59A4D729@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A94435D.59A4D729@transmeta.com>; from hpa@transmeta.com on Wed, Feb 21, 2001 at 02:38:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> You're right.  However, for each hash table operation to be O(1) the size
> of the hash table must be >> n.

If we are talking about average case complexity (which is the only possibility
with fixed hash function and arbitrary input keys), it suffices to have
hash table size >= c*n for some constant c which gives O(1/c) cost of
all operations.
 
> I suggested at one point to use B-trees with a hash value as the key. 
> B-trees are extremely efficient when used on a small constant-size key.

Although from asymptotic complexity standpoint hashing is much better
than B-trees, I'm not sure at all what will give the best performance for
reasonable directory sizes. Maybe the B-trees are really the better
alternative as they are updated dynamically and the costs of successive
operations are similar as opposed to hashing which is occassionally very
slow due to rehashing unless you try to rehash on-line, but I don't
know any algorithm for on-line rehashing with both inserts and deletes
which wouldn't be awfully complex and slow (speaking of multiplicative
constants, of course -- it's still O(1) per operation, but "the big Oh
is really big there").

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
"#define QUESTION ((bb) || !(bb))"  -- Shakespeare
