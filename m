Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbUBREKJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUBREIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:08:34 -0500
Received: from dp.samba.org ([66.70.73.150]:58282 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263310AbUBREIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:08:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16434.58656.381712.241116@samba.org>
Date: Wed, 18 Feb 2004 15:08:00 +1100
To: hpa@zytor.com
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <c0uj52$3mg$1@terminus.zytor.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hpa,

> So you're hosed if anyone uses characters outside the UCS-2 character
> set...

I've heard they are re-defining all those 16 bit numbers to be UCS-16
instead of UCS-2 for exactly that reason. This is rather similar to
the move in the Unix community to start using UTF-8.

Note that I am not at all proposing that we use UCS-2 in the Linux
kernel (except in places where you have to, like the NTFS
filesystem). I am proposing that the filesystems be able to offer a
case-insenstive hash function to the dcache, and I would expect that
this function would be based on UTF-8. 

The function might operate internally by converting UTF-8 to UCS-2, or
it might use a sparse mapping table. It would almost certainly have a
fast-path that looked first to see if there are any bytes with the top
bit set, and if there are none then it can do a really easy 7 bit
table based hash which would make this really fast for most users.

The point is that the kernel proper (the VFS and dcache in particular)
won't have to care how this hash works. They're just consumers of it. 

> There is a "standard" table, which is published by the Unicode
> consortium. 

The table used in windows is not exactly the same as the one on
unicode.org. Which is "correct" I will leave up to the pedants to
discuss, as all that Samba cares about is that it uses the same table
as w2k.

> However, the "standard" table isn't what you want in certain
> locales, e.g. Turkish.

I'd really like someone to confirm this for me by volunteering to run
a tool I provide on a Turkish NTFS filesystem or sending me a
compressed empty Turkish NTFS volume (please ask first by email - I
only need one of these). Up to now I have only ever seen the one 128k
table used across all windows locales. If this table really *is*
different in some locales then I need to know.

Cheers, Tridge
