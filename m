Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbRBUWr3>; Wed, 21 Feb 2001 17:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129181AbRBUWrS>; Wed, 21 Feb 2001 17:47:18 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:20233 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129170AbRBUWrL>; Wed, 21 Feb 2001 17:47:11 -0500
Message-ID: <3A944565.79E39CE3@transmeta.com>
Date: Wed, 21 Feb 2001 14:47:01 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <Pine.LNX.4.10.10102211740550.1933-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:
> 
> > You're right.  However, for each hash table operation to be O(1) the size
> > of the hash table must be >> n.
> 
> there's at least one kind of HT where the table starts small
> and gets bigger, but at trivial cost (memcpy).  while those
> memcpy's are O(n) each time, it's a little misleading to treat
> them as costing the same as O(n) rehashing.
> 

memcpy() isn't exactly trivial, especially not when we're talking about
disk storage.  Note, too, that we're talking about storage in a
filesystem, and random access a large, growable linear space (i.e. a
file) in a filesystem is O(log n) because of necessary inode indirection.

That's yet another reason I like the idea of using B-trees over hash
values: B-trees are O(log n), but do not need the file inode indirection
to do the job, so what you end up with is very nice and fast.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
