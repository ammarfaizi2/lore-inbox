Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316591AbSE3LYj>; Thu, 30 May 2002 07:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316589AbSE3LYi>; Thu, 30 May 2002 07:24:38 -0400
Received: from asplinux.ru ([195.133.213.194]:44810 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id <S316591AbSE3LYh>;
	Thu, 30 May 2002 07:24:37 -0400
From: Denis Lunev <den@asplinux.ru>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="W/UJq3YPYn"
Content-Transfer-Encoding: 7bit
Message-ID: <15606.3088.552163.828139@artemis.asplinux.ru>
Date: Thu, 30 May 2002 15:25:04 +0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: inode highmem imbalance fix [Re: Bug with shared memory.]
In-Reply-To: <20020524073341.GJ21164@dualathlon.random>
X-Mailer: VM 6.96 under 21.4 (patch 4) "Artificial Intelligence" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W/UJq3YPYn
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

Hello!

The patch itself cures my problems, but after a small fix concerning
uninitialized variable resulting in OOPS.

Regards,
	Denis V. Lunev


--W/UJq3YPYn
Content-Type: text
Content-Description: diff-andrea-inodes2
Content-Disposition: inline;
	filename="diff-andrea-inodes2"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4L2ZzL2lub2RlLmMub2xkCVdlZCBNYXkgMjkgMjA6MTY6MTcgMjAwMgorKysg
bGludXgvZnMvaW5vZGUuYwlXZWQgTWF5IDI5IDIwOjE3OjA4IDIwMDIKQEAgLTY2OSw2ICs2
NjksNyBAQAogCXN0cnVjdCBpbm9kZSAqIGlub2RlOwogCiAJY291bnQgPSBwYXNzID0gMDsK
KwllbnRyeSA9ICZpbm9kZV91bnVzZWQ7CiAKIAlzcGluX2xvY2soJmlub2RlX2xvY2spOwog
CXdoaWxlIChnb2FsICYmIHBhc3MrKyA8IDIpIHsK
--W/UJq3YPYn
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit



Andrea Arcangeli writes:
 > On Mon, May 20, 2002 at 06:30:40AM +0200, Andrea Arcangeli wrote:
 > > As next thing I'll go ahead on the inode/highmem imbalance repored by
 > > Alexey in the weekend.  Then the only pending thing before next -aa is
 > 
 > Here it is, you should apply it together with vm-35 that you need too
 > for the bh/highmem balance (or on top of 2.4.19pre8aa3). I tested it
 > slightly on uml and it didn't broke so far, so be careful because it's not
 > very well tested yet. On the lines of what Alexey suggested originally,
 > if goal isn't reached, in a second pass we shrink the cache too, but
 > only if the cache is the only reason for the "pinning" beahiour of the
 > inode. If for example there are dirty blocks of metadata or of data
 > belonging to the inode we wakeup_bdflush instead and we never shrink the
 > cache in such case. If the inode itself is dirty as well we let the two
 > passes fail so we will schedule the work for keventd. This logic should
 > ensure we never fall into shrinking the cache for no good reason and
 > that we free the cache only for the inodes that we actually go ahead and
 > free. (basically only dirty pages set with SetPageDirty aren't trapped
 > by the logic before calling the invalidate, like ramfs, but that's
 > expected of course, those pages cannot be damaged by the non destructive
 > invalidate anyways)
 > 
 > Comments?

--W/UJq3YPYn--
