Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136747AbREAWm1>; Tue, 1 May 2001 18:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136748AbREAWmH>; Tue, 1 May 2001 18:42:07 -0400
Received: from pop.gmx.net ([194.221.183.20]:16669 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S136744AbREAWl6>;
	Tue, 1 May 2001 18:41:58 -0400
Date: Wed, 2 May 2001 00:41:52 +0200
From: Daniel Elstner <daniel.elstner@gmx.net>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs+lndir problem [was: 2.4.4 SMP: spurious EOVERFLOW "Value too large for defined data type"]
Message-Id: <20010502004152.23a0751b.daniel@master.daniel.homenet>
In-Reply-To: <1026200000.988679027@tiny>
In-Reply-To: <20010430225557.3f28d1b0.daniel@master.daniel.homenet>
	<1026200000.988679027@tiny>
X-Mailer: Sylpheed version 0.4.64 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 30 Apr 2001 21:03:47 -0400 Chris Mason <mason@suse.com> wrote:

> > Apparently it's a reiserfs/symlink problem.
> > I tried doing the lndir on an ext2 partition, sources still
> > on reiserfs. And it worked just fine!
> 
> Neat, thanks for the extra details.  Does that mean you can consistently
> repeat on reiserfs now?  What happens when you do the lndir on reiserfs and
> diff the directories?

I just played around a bit with the following results:

sources on reiserfs, lndir on reiserfs -> make fails, diff ok
sources on reiserfs, lndir on ext2     -> make ok
sources on ext2, lndir on reiserfs     -> make fails, diff ok

Doing the diff against a second copy of the tree shows no errors, too.
Always the same behaviour: You have to run lndir at least twice to
get the error. If the link tree was already set up after a boot, the
error occurs only after rm + lndir + rm + lndir.

There's a strange way to get things working just like after a reboot.
After diff'ing the link tree with the 2nd copy (both on reiserfs),
make World won't fail - at least once.

I also tried in the link tree:
    find ! -type d -exec cat '{}' \; >/dev/null
And it seems to have the same effect as the diff.

> Any useful messages in /var/log/messages?

Nope, not any single message (except the usual ones).

The error on shutdown (when umounting /proc) appeared once again,
with the the same error message. Though I have no clue how that
could be related to reiserfs.

Two missed details: the reiserfs partion exists on a software
raid0 device. I configured glibc-2.2.3 with --enable-kernel=2.4.1.

Shall I try moving back to glibc-2.2.2 / configuring for lower kernel?

-- Daniel
