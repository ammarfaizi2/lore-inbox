Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129881AbRAFBxo>; Fri, 5 Jan 2001 20:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131035AbRAFBxe>; Fri, 5 Jan 2001 20:53:34 -0500
Received: from quattro.sventech.com ([205.252.248.110]:43015 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S129881AbRAFBxY>; Fri, 5 Jan 2001 20:53:24 -0500
Date: Fri, 5 Jan 2001 20:53:23 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: antirez <antirez@invece.org>
Cc: "Dunlap, Randy" <randy.dunlap@intel.com>, Greg KH <greg@wirex.com>,
        Heitzso <xxh1@cdc.gov>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: USB broken in 2.4.0
Message-ID: <20010105205322.F8324@sventech.com>
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDEBE@orsmsx31.jf.intel.com> <20010106045050.C1748@prosa.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <20010106045050.C1748@prosa.it>; from antirez on Sat, Jan 06, 2001 at 04:50:50AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2001, antirez <antirez@invece.org> wrote:
> On Fri, Jan 05, 2001 at 04:48:00PM -0800, Dunlap, Randy wrote:
> > This rings a small bell with me.
> > There was a change by Dan Streetman IIRC to limit
> > usbdevfs bulk transfers to PAGE_SIZE (4 KB for x86,
> > or 0x1000).  Anything larger than that returns
> > an error (-EINVAL).
> 
> Yes, devio.c, proc_bulk():
> 
>         if (len1 > PAGE_SIZE)
>                 return -EINVAL;
> 
> Actually it is the max transfer size I can reach.
> I guess that to limit the page size can be an impementation
> advantage but it may slow-down a bit some userspace driver.
> I feel that even if the linux way is to implement the USB
> drivers in kernel space a full-featured USB user space access
> should be allowed.

This is the responsibility of the user space access. Using 4k reads
versus 8k reads won't increase performance (noticably), or will it
function any more correctly.

The next version of libusb will split up reads correctly so applications
using the library don't need to worry about this.

JE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
