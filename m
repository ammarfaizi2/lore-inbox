Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281671AbRKQBYQ>; Fri, 16 Nov 2001 20:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281672AbRKQBYG>; Fri, 16 Nov 2001 20:24:06 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:44299 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281671AbRKQBX6>; Fri, 16 Nov 2001 20:23:58 -0500
Message-ID: <3BF5BB95.77B96DAF@zip.com.au>
Date: Fri, 16 Nov 2001 17:21:25 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andre Hedrick <andre@linux-ide.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: death by ATA
In-Reply-To: <3BF41608.DF8C7068@zip.com.au>,
		<3BF41608.DF8C7068@zip.com.au> <20011116234558.D11826@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Thu, Nov 15 2001, Andrew Morton wrote:
> > What does "end-request: buffer-list destroyed" mean?
> 
> It means that the request was not sane anymore, or specifically that
> clustered number of sectors was set to lower value than current number
> of sectors (which isn't valid, of course). The buffer-list destroyed
> comment tells you that this corruption is most likely due to the
> buffer_head list on the request having been corrupted -- which in turn
> probably means that someone seriously screwed this request.
> 
> hda8: bad access: block=5296, count=-2
> end_request: I/O error, dev 03:08 (hda), sector 5296
> hda8: bad access: block=5298, count=-4
> end_request: I/O error, dev 03:08 (hda), sector 5298
> hda8: bad access: block=5300, count=-6
> end_request: I/O error, dev 03:08 (hda), sector 5300
> 
> This errors would seem to backup that theory :-)

'k, thanks.

> Is this an SMP board? Also, is

Uniprocessor VIA C3, running 2.4.15-pre4. The controller is a
VT8231.  Running at UDMA100.

> end_request: buffer-list destroyed
> 
> the very first error message?

Yes, it is.

It is reproducible after around three few hours.  Exactly the
same.

-
