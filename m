Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265806AbRGODgY>; Sat, 14 Jul 2001 23:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265802AbRGODgO>; Sat, 14 Jul 2001 23:36:14 -0400
Received: from weta.f00f.org ([203.167.249.89]:39299 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S265771AbRGODgF>;
	Sat, 14 Jul 2001 23:36:05 -0400
Date: Sun, 15 Jul 2001 15:36:07 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <andrewm@uow.edu.au>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ben LaHaise <bcrl@redhat.com>,
        Ragnar Kjxrstad <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
Subject: Re: [PATCH] 64 bit scsi read/write
Message-ID: <20010715153607.A7624@weta.f00f.org>
In-Reply-To: <E15LL3Y-0000yJ-00@the-village.bc.nu> <20010715025001.B6722@weta.f00f.org> <0107142211300W.00409@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0107142211300W.00409@starship>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2001 at 10:11:30PM +0200, Daniel Phillips wrote:

    Atomic commit.  The superblock, which references the updated
    version of the filesystem, carries a sequence number and a
    checksum.  It is written to one of two alternating locations.  On
    restart, both locations are read and the highest numbered
    superblock with a correct checksum is chosen as the new filesystem
    root.

Yes... and which ever part of the superblock contains the sequence
number must be written atomically.

The point is, you _NEED_ to be sure that data written before the
superblock (or indeed anywhere further up the tree, you can make
changes in theory which don't require super-block updates) are written
firmly to the platters before any thing which refers to it is updated.

Alan was saying with IDE you cannot reliably do this, I assume you can
with SCSI was my point.



  --cw
