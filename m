Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131644AbRAKLuI>; Thu, 11 Jan 2001 06:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131678AbRAKLt6>; Thu, 11 Jan 2001 06:49:58 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:53435 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131644AbRAKLti>; Thu, 11 Jan 2001 06:49:38 -0500
Message-ID: <3A5D9F3A.FCC82709@uow.edu.au>
Date: Thu, 11 Jan 2001 22:55:38 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: David Hinds <dhinds@sonic.net>
CC: Miles Lane <miles@megapathdsl.net>,
        Aaron Eppert <eppertan@rose-hulman.edu>, dhinds@zen.stanford.edu,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 Patch for 3c575
In-Reply-To: <20010110204420.A7699@rose-hulman.edu> <3A5D20D6.6090906@megapathdsl.net>,
		<3A5D20D6.6090906@megapathdsl.net>; from Miles Lane on Wed, Jan 10, 2001 at 06:56:22PM -0800 <20010110201537.F12593@sonic.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Hinds wrote:
> 
> On Wed, Jan 10, 2001 at 06:56:22PM -0800, Miles Lane wrote:
> >
> > There's one other annoyance:
> >
> > The config files for pcmcia-cs expect the 3c575_cb driver,
> > so I either have to hack the configuration files or load
> > the 3c59x driver by hand.
> 
> Yes, I'm not sure how to best communicate the fact that 3c59x should
> be used to cardmgr.

mm..  An `alias 3c575_cb 3c59x' in modules.conf works, but
screws things up when you boot back into 2.2.  Alternative
is to go into the modules directory and symlink 3c575_cb->3c59x

The other problem is that in 2.4 cardmgr isn't told the
name of the interface which was bound to the newly-inserted NIC.
I don't know why more people aren't getting bitten by this
with pcmcia-cs+2.4.

I have a rude patch against the pcmcia-cs scripts at

	http://www.uow.edu.au/~andrewm/linux/3c59x-2.3-changelog.txt

which works around this.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
