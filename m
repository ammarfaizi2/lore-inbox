Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVFMKiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVFMKiY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 06:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVFMKiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 06:38:23 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:51269 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261461AbVFMKiT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 06:38:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=T5Sl5eKRHAQ558AbqVs9YhQy3rkO8hczKXhuVS0vdIhFZ/DNGzpbTaQMJJJElNFlf9sPF4Z6u8GzdI9ptbnlt8dkbpWykwwpdLk40eF3D29kZEV+wAizXhzqwirKGrxODS6+rb5XnIyMx7N+Po/npcyEgEFdf1KMDQt39cMrQWE=
Message-ID: <f192987705061303383f77c10c@mail.gmail.com>
Date: Mon, 13 Jun 2005 14:38:16 +0400
From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Reply-To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: A Great Idea (tm) about reimplementing NLS.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I have a Great Idea about improving NLS in the linux kernel and I want
somebody with kernel experience consider if it's good or not, just not
to waste time on writing code that will be rejected.

First of all, why do I think the current NLS implementation isn't good enough.

Let's look at a situation. I'm using utf-8 as my default system
charset, and my friend Vasiliy Pupkin, who uses koi8-r, wants to plug
his flash drive (ext3) into my computer. It should work, except all
non-us-ascii filenames will be totally unreadable. The problem is even
bigger if I have an other friend's hard drive with reiserfs and cp1251
encoded filenames on it. The problem is not only with Russian language
for which we have at least 3 common encodings. Everyone who uses
non-us-ascii letters can face the same problem, since there are at
least 2 encodings for theyr language - utf-8 and an other one used
before utf.

Some would suggest not to use non-ascii file names at all, some would
say that I should temporary change my locale, some could even offer me
a perl script they wrote when faced the same problem. All these
solutions are inconvenient and conflict with fundamental VFS concepts.

Instead of adding NLS support to filesystems who don't have it yet, I
think there should be a global NLS layer, to convert file names from
any to any encoding, independent of file system and transparently to
the user.

So what do you think? Is it all nonsense or maybe I should try to implement it?

Please CC me, I'm not subscribed.
