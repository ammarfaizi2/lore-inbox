Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268133AbRHGPKJ>; Tue, 7 Aug 2001 11:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267615AbRHGPJ7>; Tue, 7 Aug 2001 11:09:59 -0400
Received: from 63-216-69-197.sdsl.cais.net ([63.216.69.197]:38409 "EHLO
	vyger.freesoft.org") by vger.kernel.org with ESMTP
	id <S268206AbRHGPJz>; Tue, 7 Aug 2001 11:09:55 -0400
Message-ID: <3B7004BA.7896CFF7@freesoft.org>
Date: Tue, 07 Aug 2001 11:09:46 -0400
From: Brent Baccala <baccala@freesoft.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
Subject: Re: Problem with usb-storage using HP 8200 external CD-ROM burner
In-Reply-To: <3B68FB0C.5BC83115@freesoft.org> <20010806014626.K24225@one-eyed-alien.net> <3B6EF4DA.8899E1D3@freesoft.org> <20010806201746.C6080@one-eyed-alien.net> <20010807093320.I6192@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Mon, Aug 06 2001, Matthew Dharm wrote:
> > >       774         spin_lock_irqsave(&io_request_lock, flags);
> > >       775         rtn = SCpnt->host->hostt->eh_abort_handler(SCpnt);
> > >       776         spin_unlock_irqrestore(&io_request_lock, flags);
> > >
> > > seems like a real shotgun approach.  Get rid of the spinlock stuff, and
> > > make sure that the abort handlers lock io_request_lock themselves if
> > > they need it.  Of course, this would require changes to all the scsi
> > > drivers.
> >
> > Hrm... perhaps I could just unlock that spinlock and then re-lock it before
> > returning.  Anyone have a clue if this would work?
> 
> That would work -- stuff like the above is already scheduled for removal
> for 2.5. Locking will be moved from the mid layer to the drivers
> themselves.

If that's the case (the locking will be moved in 2.5), then I'd suggest
using Matthew's idea of unlocking, then re-locking the spinlock, as a
temporary measure.

-- 
                                        -bwb

                                        Brent Baccala
                                        baccala@freesoft.org

==============================================================================
       For news from freesoft.org, subscribe to announce@freesoft.org:
   
mailto:announce-request@freesoft.org?subject=subscribe&body=subscribe
==============================================================================
