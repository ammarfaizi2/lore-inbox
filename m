Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270122AbRHGHd4>; Tue, 7 Aug 2001 03:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270123AbRHGHdq>; Tue, 7 Aug 2001 03:33:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45060 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S270122AbRHGHdh>;
	Tue, 7 Aug 2001 03:33:37 -0400
Date: Tue, 7 Aug 2001 09:33:20 +0200
From: Jens Axboe <axboe@suse.de>
To: Brent Baccala <baccala@freesoft.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
Subject: Re: Problem with usb-storage using HP 8200 external CD-ROM burner
Message-ID: <20010807093320.I6192@suse.de>
In-Reply-To: <3B68FB0C.5BC83115@freesoft.org> <20010806014626.K24225@one-eyed-alien.net> <3B6EF4DA.8899E1D3@freesoft.org> <20010806201746.C6080@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010806201746.C6080@one-eyed-alien.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06 2001, Matthew Dharm wrote:
> >       774         spin_lock_irqsave(&io_request_lock, flags);
> >       775         rtn = SCpnt->host->hostt->eh_abort_handler(SCpnt);
> >       776         spin_unlock_irqrestore(&io_request_lock, flags);
> > 
> > seems like a real shotgun approach.  Get rid of the spinlock stuff, and
> > make sure that the abort handlers lock io_request_lock themselves if
> > they need it.  Of course, this would require changes to all the scsi
> > drivers.
> 
> Hrm... perhaps I could just unlock that spinlock and then re-lock it before
> returning.  Anyone have a clue if this would work?

That would work -- stuff like the above is already scheduled for removal
for 2.5. Locking will be moved from the mid layer to the drivers
themselves.

-- 
Jens Axboe

