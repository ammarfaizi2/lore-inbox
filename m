Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319100AbSHMU6y>; Tue, 13 Aug 2002 16:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319101AbSHMU6y>; Tue, 13 Aug 2002 16:58:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47630 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319100AbSHMU6x>;
	Tue, 13 Aug 2002 16:58:53 -0400
Message-ID: <3D597365.AF376528@zip.com.au>
Date: Tue, 13 Aug 2002 14:00:21 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT support in ext3?
References: <200208131548.36267.roy@karlsbakk.net> <20020813172705.GG9642@clusterfs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Aug 13, 2002  15:48 +0200, Roy Sigurd Karlsbakk wrote:
> > playing around with O_DIRECT, I really _can't_ make it work on ext3?
> >
> > why is this?
> 
> Because O_DIRECT needs a specific o_direct I/O method that has not yet
> been written for ext3.  I believe only ext2 and reiserfs support it
> right now.  I will eventually need to add support for this, but it is
> not yet high on my list of priorities.  Maybe someone else will beat
> me to it.

Yes, we need to get it up and running for 2.5.  It should be relatively
straightforward.  It'll need an ext3_get_blocks_for_o_direct() which
does a journal_start/stop if create=1.

And maybe some fancy footwork around invalidating existing pagecache in
ext3_file_write(), but the current code looks to be OK actually.

It shouldn't be a big deal; mainly testing.
