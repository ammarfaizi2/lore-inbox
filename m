Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262525AbVBXVyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbVBXVyN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 16:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbVBXVxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 16:53:15 -0500
Received: from mx1.mail.ru ([194.67.23.121]:63573 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S262509AbVBXVwZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 16:52:25 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Ed L Cashin <ecashin@coraid.com>
Subject: Re: [PATCH] aoe: fix abuse of arrays and sparse warnings
Date: Fri, 25 Feb 2005 00:52:17 +0200
User-Agent: KMail/1.6.2
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org
References: <200502240318.23155.adobriyan@mail.ru> <87k6oxan3a.fsf@coraid.com>
In-Reply-To: <87k6oxan3a.fsf@coraid.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200502250052.17919.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 February 2005 19:23, Ed L Cashin wrote:

> Have you tested it?

Not yet.

> If you don't have any 
> ATA over Ethernet hardware, you can using the alpha vblade program for
> testing.

OK. Will try.

> I was trying to determine what sparse warnings you see, so I got
> sparse from bk://sparse.bkbits.net/sparse and ran it.  Your patch cuts
> down significantly on the complaints, but there are some that persist.
> Maybe you're using an older version of sparse?

No. Those three were deliberately left as is because they aren't local to
AOE.

> drivers/block/aoe/aoechr.c:236:24: warning: symbol 'aoe_fops' was not declared. Should it be static?

> drivers/block/aoe/aoecmd.c:27:17: warning: incorrect type in assignment (different base types)
> drivers/block/aoe/aoecmd.c:27:17:    expected unsigned short [unsigned] protocol
> drivers/block/aoe/aoecmd.c:27:17:    got restricted unsigned short [usertype] [force] <noident>

> drivers/block/aoe/aoenet.c:156:10: warning: incorrect type in initializer (different base types)
> drivers/block/aoe/aoenet.c:156:10:    expected unsigned short [unsigned] type
> drivers/block/aoe/aoenet.c:156:10:    got restricted unsigned short [usertype] [force] <noident>

> The "array abuse" is something that I'm not all that enthusiastic
> about changing,

I am.

> since it's mostly a style issue,

It isn't. 

	struct aoe_hdr {
		unsigned char tag[4];
	};
	struct aoe_hdr *h;
	u32 net_tag;

	net_tag = __cpu_to_be32(n);
	memcpy(h->tag, &net_tag, sizeof net_tag);

This code is plain ugly. When AOE was merged there were _plenty_ of examples
of LE and BE fields in structs. 

> and last time I 
> changed it the way your patch does, the original author of the patch
> changed it back.

Please, show him include/linux/ext2_fs.h::struct ext2_group_desc{} and
fs/ext2/super.c::ext2_check_descriptors(), for example.

> But you've figured out how to make sparse happy, and 
> for that I'm grateful!  :)

:)

	Alexey
