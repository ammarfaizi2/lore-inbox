Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268963AbRG0VIl>; Fri, 27 Jul 2001 17:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268974AbRG0VIZ>; Fri, 27 Jul 2001 17:08:25 -0400
Received: from weta.f00f.org ([203.167.249.89]:1670 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S268972AbRG0VIE>;
	Fri, 27 Jul 2001 17:08:04 -0400
Date: Sat, 28 Jul 2001 09:08:36 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Michal Jaegermann <michal@harddata.com>, linux-kernel@vger.kernel.org
Subject: Re: Strange remount behaviour with ext3-2.4-0.9.4
Message-ID: <20010728090836.B1625@weta.f00f.org>
In-Reply-To: <E15QEVd-0006UJ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15QEVd-0006UJ-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 27, 2001 at 09:46:57PM +0100, Alan Cox wrote:

    2.	The software suspend case is horrible. Right now mixing a
    	journalling fs and swsuspend tends to cause disk corruption because
    	journalling fs's write to disk when told to mount read only

this is hard to fix... the fs needs to replay things to make things
consistent, and in many cases doing an 'in-memory' replay isn't an
option (ie. remember which stuff needs to replayed and read from the
journal instead of disk when required to do so)

    4.	Snapshots. Making read only snapshots can be very useful, and there
    	you want the replay of the log to be into the page cache but not
    	written back to physical media until its marked read-write

R/O snapshots are best done in the fs if possible, al la
WAFL. Something like that for resierfs or TUX2 would rule so much (you
more-or-less need need a tree-based fs and reference counting for all
the magic bits).  In fact, doing it as the fs layer means you could
have r/w snapshots with COW semantics.



  --cw
