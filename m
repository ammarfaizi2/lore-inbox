Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbTDSQkL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 12:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbTDSQkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 12:40:11 -0400
Received: from mail.ithnet.com ([217.64.64.8]:58639 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263413AbTDSQkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 12:40:10 -0400
Date: Sat, 19 Apr 2003 18:52:01 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Message-Id: <20030419185201.55cbaf43.skraw@ithnet.com>
In-Reply-To: <200304191622.h3JGMI9L000263@81-2-122-30.bradfords.org.uk>
References: <20030419180421.0f59e75b.skraw@ithnet.com>
	<200304191622.h3JGMI9L000263@81-2-122-30.bradfords.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Apr 2003 17:22:18 +0100 (BST)
John Bradford <john@grabjohn.com> wrote:

> > I wonder whether it would be a good idea to give the linux-fs
> > (namely my preferred reiser and ext2 :-) some fault-tolerance.
> 
> Fault tollerance should be done at a lower level than the filesystem.

I know it _should_ to live in a nice and easy world. Unfortunately real life is
different. The simple question is: you have tons of low-level drivers for all
kinds of storage media, but you have comparably few filesystems. To me this
sound like the preferred place for this type of behaviour can be fs, because
all drivers inherit the feature if it lives in fs.

> Linux filesystems are used on many different devices, not just hard
> disks.  Different devices can fail in different ways - a disk might
> have a lot of bad sectors in a block, a tape[1] might have a single
> track which becomes unreadble, and solid state devices might have get
> a few random bits flipped all over them, if a charged particle passes
> through them.
> 
> The filesystem doesn't know or care what device it is stored on, and
> therefore shouldn't try to predict likely failiures.

It should not predict failures, it should possibly only say: "ok, driver told
me the block I just wanted to write has an error, so lets try a different one
and mark this block in my personal bad-block list as unusable. This does not
sound all-too complex. There is a free-block-list anyway...

> A RAID-0 array and regular backups are the best way to protect your
> data.

RAID-1 obviously ;-)

> [1] Although it is uncommon to use a tape as a block device, you never
> know.  It's certainly possible, (not necessarily with Linux).

>From the fs point of view it makes no difference living on disk or tape or a
tesa-strip.

Regards,
Stephan


