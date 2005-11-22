Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbVKVP1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbVKVP1u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 10:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbVKVP1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 10:27:50 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:26023 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S964961AbVKVP1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 10:27:49 -0500
Date: Tue, 22 Nov 2005 10:25:31 -0500
To: "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Alfred Brons <alfredbrons@yahoo.com>, pocm@sat.inesc-id.pt,
       linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Message-ID: <20051122152531.GU12760@delft.aura.cs.cmu.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Christoph Hellwig <hch@infradead.org>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	Alfred Brons <alfredbrons@yahoo.com>, pocm@sat.inesc-id.pt,
	linux-kernel@vger.kernel.org
References: <11b141710511210144h666d2edfi@mail.gmail.com> <20051121095915.83230.qmail@web36406.mail.mud.yahoo.com> <20051121101959.GB13927@wohnheim.fh-wedel.de> <20051122075148.GB20476@infradead.org> <20051122145047.GB29179@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122145047.GB29179@thunk.org>
User-Agent: Mutt/1.5.9i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 09:50:47AM -0500, Theodore Ts'o wrote:
> I will note though that there are people who are asking for 64-bit
> inode numbers on 32-bit platforms, since 2**32 inodes are not enough
> for certain distributed/clustered filesystems.  And this is something
> we don't yet support today, and probably will need to think about much
> sooner than 128-bit filesystems....

As far as the kernel is concerned this hasn't been a problem in a while
(2.4.early). The iget4 operation that was introduced by reiserfs (now
iget5) pretty much makes it possible for a filesystem to use anything to
identify it's inodes. The 32-bit inode numbers are simply used as a hash
index.

The only thing that tends to break are userspace archiving tools like
tar, which assume that 2 objects with the same 32-bit st_ino value are
identical. I think that by now several actually double check that the
inode linkcount is larger than 1.

Jan
