Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbTILAWn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 20:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbTILAWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 20:22:43 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:48090 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261664AbTILAWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 20:22:18 -0400
To: Matthias Andree <ma@dt.e-technik.uni-dortmund.de>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: Status of fsync() wrt mail servers
In-Reply-To: <20030911172509.GB18399@matchmail.com> (Mike Fedyk's message of
 "Thu, 11 Sep 2003 10:25:09 -0700")
References: <20030910002953.C14172@unbeatenpath.net>
	<20030910105102.GA535@rahul.net>
	<1063192474.18154.355.camel@tiny.suse.com>
	<20030910114103.GA26767@rahul.net>
	<1063197048.18155.357.camel@tiny.suse.com>
	<20030910101821.A15923@unbeatenpath.net>
	<20030910213244.GD1461@matchmail.com>
	<20030910173343.A16677@unbeatenpath.net>
	<20030910234927.GE1461@matchmail.com>
	<m3ekynbj3e.fsf@merlin.emma.line.org>
	<20030911172509.GB18399@matchmail.com>
From: Matthias Andree <ma@dt.e-technik.uni-dortmund.de>
Date: Fri, 12 Sep 2003 02:22:15 +0200
Message-ID: <m3brtqrh3c.fsf@merlin.emma.line.org>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> writes:

>> I recently helped one qmail user debug this; the symptom was that the
>> first mail in a burst of mails took 2 seconds to queue, subsequent mails
>> were queued much quicker (70 ms). He was using ext3fs, and had one huge
>> / (root) file system and so the "synch the whole file system" behaviour
>> made his qmail-queue synch *all* his dirty blocks to disk...
>
> Can you be sure the MTA wasn't calling sync() just to be sure (Many MTAs are
> funny in that they think the spool is on a seperate disk and
> filesystem).

For qmail and Postfix I can be. sync(8) isn't remotely useful, because
it's allowed to return before completion.

> fsync() shouldn't be flushing anything not relating to the file it was
> called on (that includes directory entries related to the file also
> IMHO).

It "should", but current implementations on Linux do exactly that: flush
everything. Maybe you've got better luck with BSD softupdates, but
that's going to munch disk I/O big time next time you reboot after a
crash: fsck needed. It runs niced in the background so the machine boots
up, but the box won't satisfy higher I/O demands. Looks like a "ex
duobus malis" game.

> Also, if the MTA wasn't running as root, it shouldn't be able to make sync()
> affect the entire system.

I'd like to see your plans that prevent DoS by local users...

One machine's light load is another one's DoS attack.

> Is there anything that says that sync() can't just flush the user's
> buffers unless you're running as root or with some CAP_ capability?

Does the kernel track "whose dirty buffer is this" (uid_t) at all?

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
