Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263809AbTDUKfr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 06:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbTDUKfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 06:35:47 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:25216 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263809AbTDUKfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 06:35:46 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304211050.h3LAoYTM000490@81-2-122-30.bradfords.org.uk>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Mon, 21 Apr 2003 11:50:34 +0100 (BST)
Cc: john@grabjohn.com (John Bradford), vda@port.imtp.ilyichevsk.odessa.ua,
       adilger@clusterfs.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030421122544.5ae6bd6f.skraw@ithnet.com> from "Stephan von Krawczynski" at Apr 21, 2003 12:25:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I say:
> we already have the needed information inside every fs, why not use it?
> No space wasted, no double information.

Bad block remapping in software would be useful only on relatively
obscure devices which don't already do it.  I consider it to be
counter productive, and a bad thing to do on devices that already do
it themselves.

Therefore, it is an ideal candidate for being done in a separate
layer.

Your argument seems to be that if a write error is encountered, the
simplest thing to do is to try another block, and mark the first one
as unusable.

On devices which have a fixed physical area for each logical block,
and where no write caching was done, your approach might be the best
one.

However, modern operating systems often cache a lot of data to write
out when the disk is idle.  The filesystem will typically allocate
this data to various blocks immediately.  A write failiure 30 seconds
later would mean that the filesystem then has to change that
allocation from the bad block to a new block.  It's possible that
there might not even be a new block available by that time.  On disks
which do their own bad block management, if one block re-allocation
failed, because there is no space left, it's quite possible that all
future re-allocations will fail as well.

On devices which never report back bad blocks to the operating system,
the space for the bad block table is wasted.

John.
