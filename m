Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265259AbTLMSQk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 13:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265265AbTLMSQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 13:16:40 -0500
Received: from pixy-gw.netlab.is.tsukuba.ac.jp ([130.158.83.98]:8977 "HELO
	pixy.netlab.is.tsukuba.ac.jp") by vger.kernel.org with SMTP
	id S265259AbTLMSQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 13:16:38 -0500
To: hirofumi@mail.parknet.co.jp
Cc: linux-kernel@vger.kernel.org
Subject: Re: FAT fs sanity check patch
In-Reply-To: <87d6b6ujl0.fsf@devron.myhome.or.jp>
References: <20031203072219F.yokota@netlab.is.tsukuba.ac.jp>
	<87d6b6ujl0.fsf@devron.myhome.or.jp>
X-Mailer: Mew version 1.94.2 on Emacs 19.34 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20031214031630A.yokota@netlab.is.tsukuba.ac.jp>
Date: Sun, 14 Dec 2003 03:16:30 +0900
From: Yokota Hiroshi <yokota@netlab.is.tsukuba.ac.jp>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: FAT fs sanity check patch
Date: Wed, 03 Dec 2003 22:17:15 +0900

> > Because some MS windows based FAT filesystem disk formatter generetes
> > wrong super bloacks.

> BTW, did this happen in MS windows of which version?

 I tested on Windows 95 and Windows Me.
But I think it can happen on all version of MS-Windows.

###

I found why MS-Windows uses wrong numbers.

Usually, MO-disk uses "super floppy" format. And all "super floppy" format
disk contains wrong numbers. But "plain (Fixed disk)" format disk contains
correct number.


In "super floppy" format, boot sector's media number is 0xf0 (== 1.44MB 2HD
IBM-PC floppy format).
And FAT entry's media number is 0xf8 (== Fixed disk).

Media number can takes 0xf0-0xff.
Other media number values are used for other format disks.
For example, 1.2MB 2HC NEC-PC9801 floppy format uses 0xf9.


Usually, these two values must be same. But "super floppy" format
disk uses different value.

Why this format uses different value?
I think MS-Windows changes disk cache's caching strategy based on
boot sector's media ID value.

Because any removeable media can eject any time, so disk cache
(espeially write cache) is not usable for removeable disks.

MO disk can treat as Fixed disk, except disk caching strategy.
Because MO disk is removeable.

Anyway, this bad hack is not useful for Linux. Linux uses
mount/unmount command to flush disk cache.

I think the name of "super floppy" comes from this wrong number in
boot sector.

---
YOKOTA Hiroshi
