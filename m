Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130820AbQLYT27>; Mon, 25 Dec 2000 14:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131115AbQLYT2s>; Mon, 25 Dec 2000 14:28:48 -0500
Received: from attila.bofh.it ([213.92.8.2]:51667 "HELO attila.bofh.it")
	by vger.kernel.org with SMTP id <S130820AbQLYT2f>;
	Mon, 25 Dec 2000 14:28:35 -0500
Date: Mon, 25 Dec 2000 19:44:06 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
Message-ID: <20001225194406.A1242@wonderland.linux.it>
In-Reply-To: <20001225005303.A205@wonderland.linux.it> <Pine.LNX.4.10.10012250049400.5242-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.10.10012250049400.5242-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Dec 25, 2000 at 01:19:50AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 25, Linus Torvalds <torvalds@transmeta.com> wrote:

 >Add a printk() to __remove_inode_page() that complains whenever it removes
 >a dirty page. 
 >
 >Oh, in order to not see this with swap pages (which _can_ be removed when
 >they are dirty, if all users of them are gone), add a PageClearDirty() to
 >"remove_from_swap_cache()" so that we don't get false positives..
 >
 >Do you get any messages? I don't think you will, but it should be tested.
I read you found the real cause so that may be bogus, but I have got two
messages while booting. The first showed up while doing the fsck of a 6
GB file systems and killed the process (fscks of smaller partitions
completed successfully), the second occured while initializing
/dev/random and left an unkillable dd process and a stuck boot process
(I gathered this info with sysrq).

Being -test12 unstable for me, if you don't need more data I'll go back
to -test9 until the next release.

 >That's probably the infinite loop in the tty task queue handling, should
 >be fixed in test13-pre3 or so.
Looks like I missed it, evil vger postmasters unsubscribed me again for
no apparent reason...

-- 
ciao,
Marco

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
