Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129425AbRBFXZl>; Tue, 6 Feb 2001 18:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129168AbRBFXZa>; Tue, 6 Feb 2001 18:25:30 -0500
Received: from zeus.kernel.org ([209.10.41.242]:28362 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129425AbRBFXZT>;
	Tue, 6 Feb 2001 18:25:19 -0500
Date: Tue, 6 Feb 2001 23:21:19 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Anders Eriksson <aer-list@mailandnews.com>,
        linux-kernel@vger.kernel.org
Subject: Re: sync & asyck i/o
Message-ID: <20010206232119.K1167@redhat.com>
In-Reply-To: <20010206181808.I1167@redhat.com> <Pine.LNX.4.10.10102061122530.2273-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.10.10102061122530.2273-100000@master.linux-ide.org>; from andre@linux-ide.org on Tue, Feb 06, 2001 at 11:25:00AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 06, 2001 at 11:25:00AM -0800, Andre Hedrick wrote:
> On Tue, 6 Feb 2001, Stephen C. Tweedie wrote:

> > No, we simply omit to instruct them to enable write-back caching.
> > Linux assumes that the WCE (write cache enable) bit in a disk's
> > caching mode page is zero.
> 
> You can not be so blind to omit the command.

Linux has traditionally ignored the issue.  Don't ask me to defend it
--- the last advice I got from anybody who knew SCSI well was that
SCSI disks were defaulting to WCE-disabled.  

Note that disabling SCSI WCE doesn't disable the cache, it just
enforces synchronous completion.  With tagged command queuing,
writeback caching doesn't necessarily mean a huge performance
increase.  But if WCE is being enabled by default on modern SCSI
drives, then that's something which the scsi stack really does need to
fix --- the upper block layers will most definitely break if we have
WCE enabled and we don't set force-unit-access on the scsi commands.

The ll_rw_block interface is perfectly clear: it expects the data to
be written to persistent storage once the buffer_head end_io is
called.  If that's not the case, somebody needs to fix the lower
layers.

Cheers, 
  Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
