Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbUKSXGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbUKSXGu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 18:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbUKSXFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 18:05:42 -0500
Received: from dp.samba.org ([66.70.73.150]:10127 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261649AbUKSXCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 18:02:30 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16798.31565.306237.930372@samba.org>
Date: Sat, 20 Nov 2004 10:01:33 +1100
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: performance of filesystem xattrs with Samba4
In-Reply-To: <419E1297.4080400@namesys.com>
References: <16797.41728.984065.479474@samba.org>
	<419E1297.4080400@namesys.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans,

I did some testing with reiser4 from 2.6.10-rc2-mm2. As far as I can
tell it doesn't seem to support the xattr calls (fsetxattr, fgetxattr
etc). Is that right, or did I miss a patch somewhere? The code seems
to set the xattr methods to NULL and has the prototypes #if'd out.

The result without xattr support was 52 MB/sec, which is a bit slower
than the reiser3 I tested in 2.6.10-rc2. For easy comparison, here are
the non-xattr results for the various filesystems I've tested:

tmpfs               69 MB/sec
ext2                68 MB/sec
ext3                67 MB/sec
xfs+2Kinode         63 MB/sec
xfs                 62 MB/sec
reiser              58 MB/sec
reiser4             52 MB/sec (on a -mm2 kernel)
jfs                 36 MB/sec

I used default options for mkreiser4, and default mount options. Can
you suggest some options to try or would you prefer to wait till I've
done the new dbench so you can try this more easily yourself? (you can
of course try installing Samba4 to test now, but its a fast moving
target and involves a lot more than just filesystem calls).

To make sure the problem wasn't some of the other patches in -mm2, I
reran the ext3 results on -mm2, and was surprised to find quite a
large improvement! ext3 got 73 MB/sec without xattr support. It oopsed
when I enabled xattr (I'm working with sct on fixing those oopses).

Once the oopses are fixed I'll rerun all the various filesystems with
-mm2 and see if it only improves ext3 or if it improves all of them.

Would anyone care to hazard a guess as to what aspect of -mm2 is
gaining us 10% in overall Samba4 performance?

Cheers, Tridge
