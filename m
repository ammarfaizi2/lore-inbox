Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbULBQBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbULBQBW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 11:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbULBPyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 10:54:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:32916 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261652AbULBPua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 10:50:30 -0500
Date: Thu, 2 Dec 2004 07:50:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Schwab <schwab@suse.de>
cc: Jan Kasprzak <kas@fi.muni.cz>, Arnd Bergmann <arnd@arndb.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cosa.h ioctl numbers
In-Reply-To: <jellcgag2v.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.58.0412020740070.22796@ppc970.osdl.org>
References: <20041202124456.GF11992@fi.muni.cz> <200412021358.00844.arnd@arndb.de>
 <20041202131224.GI11992@fi.muni.cz> <jeu0r4ajl4.fsf@sykes.suse.de>
 <20041202141132.GO11992@fi.muni.cz> <jellcgag2v.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Dec 2004, Andreas Schwab wrote:
> 
> This has nothing to do with this, but everything to do with
> sizeof(sizeof(foo)) == sizeof(size_t).  And COSAIODOWNLD does not expect a
> pointer to a pointer but a pointer to struct cosa_download, which means
> that _IOW('C',0xf2,struct cosa_download *) would be completely wrong
> anyway.

We have similar "broken due to historical reasons" in other places. 
There's no good way to fix them up, and it doesn't really matter _what_ 
fake type you use, as long as it happens to be the same size as the 
original broken type on all architectures where it matters.

We've done different things in the past depending on exactly what the
numbers have been. Sometimes "size_t" (to keep pointers happy on both
32-bit and 64-bit architectures), sometimes "int" or "u32" (when somebody
had used an array _member_ instead of the array, or just had the size
explicitly haldcoded as an integer number, and then "size_t" just made it
"sizeof(int)" etc).

Sounds like it doesn't much matter in this case, any of the above would 
work.

		Linus
