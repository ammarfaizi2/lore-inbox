Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbTDUTud (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 15:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbTDUTud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 15:50:33 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29191 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261942AbTDUTub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 15:50:31 -0400
Date: Mon, 21 Apr 2003 13:02:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Christoph Hellwig <hch@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       "David S. Miller" <davem@redhat.com>, <Andries.Brouwer@cwi.nl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new system call mknod64
In-Reply-To: <20030421193510.GQ10374@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0304211259120.17221-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Apr 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> stat() family, ustat(2), quota syscall, ioctls that pass device numbers,
> /dev/raw, RAID, probably process accounting.
> 
> FWIW, I believe that you are overestimating the amount of internal code
> that cares about device numbers.

I don't think so. I agree that it's not very many places, and in fact the 
reason we currently do _not_ do dev_t replacement at system call boundary 
is that it looks to be so rare that it's easier to always use the user 
representation, and then always do the explicit MINOR/MAJOR in the places 
that use dev_t.

I don't really care which way it is done (ie system call boundary or in 
usage), and I'm happy with either - as long as it always _does_ get done, 
and nobody ever uses the user representation that can have aliases for 
anything important.

(My preference, quite frankly, is to always have major/minor be explicit, 
and never deal with "dev_t" at all. Especially with a 64-bit dev_t it is 
actually often _faster_ and _simpler_ to just carry major/minor around 
explicitly because then gcc won't ever have to worry it's small deficient 
brain about "unsigned long long".)

		Linus

