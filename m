Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279934AbRKXTjv>; Sat, 24 Nov 2001 14:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279617AbRKXTje>; Sat, 24 Nov 2001 14:39:34 -0500
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:62085 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S279418AbRKXTjP>; Sat, 24 Nov 2001 14:39:15 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Disk hardware caching, performance, and journalling
In-Reply-To: <3BFFE8A2.1010708@rueb.com> <3BFFF021.D963B467@zip.com.au>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 24 Nov 2001 20:39:12 +0100
In-Reply-To: <3BFFF021.D963B467@zip.com.au> (Andrew Morton's message of "Sat, 24 Nov 2001 11:08:17 -0800")
Message-ID: <tgoflsez6n.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:

> In theory, yes.  In my opinion, no.  For ext3, at least.  Caching
> isn't bad per-se.  It's reordering which can break the journalling
> constraints.  But given that the journal is, we hope, a strictly
> ascending and (we really hope) contiguous chunk of blocks, it's
> quite unlikely that the disk will decide to write them in an
> unexpected order.  This is especially true if the journal was
> created when the disk was relatively unfragmented.

When the journal resides on multiple disks or disks different from the
actual data (think LVM or RAID), all bets are off.  You need
synchronous write operations in these cases, I think.

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
