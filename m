Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTDTRKN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 13:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbTDTRKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 13:10:12 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:36480 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263637AbTDTRKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 13:10:11 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304201725.h3KHP5lU000751@81-2-122-30.bradfords.org.uk>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
To: 76306.1226@compuserve.com (Chuck Ebbert)
Date: Sun, 20 Apr 2003 18:25:05 +0100 (BST)
Cc: arjanv@redhat.com (arjanv@redhat.com),
       linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <200304201306_MC3-1-3537-115@compuserve.com> from "Chuck Ebbert" at Apr 20, 2003 01:03:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> You will if it writes and fails to read back. The disk can't invent a
> >> sector that is gone. 
> >
> > but linux can if you use an raid1 mirror... maybe we should teach the md
> > layer to write back the data from the other disk on a "bad sector"
> > error.
> 
> 
>   I have some ugly code that forces all reads from a mirror set to
> a specific copy, set via a global sysctl.  This lets you do things
> like make a backup from disk 0, then verify against disk 1 and take
> action if something is wrong.

That's interesting.  Have you thought of making it read from _both_
disks and check that the data matches, before passing it back?

RAID1 mirrors guard against drive failiure, but if a drive returns bad
data, but doesn't report an error, that will usually go unnoticed.

By reading from both disks, and checking that the data was the same,
we could guard against broken firmware.

Of course, this would reduce performane quite a bit, but it might have
some uses.

John.
