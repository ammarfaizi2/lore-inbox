Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129790AbRAKPhl>; Thu, 11 Jan 2001 10:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129927AbRAKPhb>; Thu, 11 Jan 2001 10:37:31 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:16646 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S129790AbRAKPhU>; Thu, 11 Jan 2001 10:37:20 -0500
Date: Thu, 11 Jan 2001 16:37:03 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Daniel Phillips <phillips@innominate.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FS callback routines
Message-ID: <20010111163703.A3000@pcep-jamie.cern.ch>
In-Reply-To: <3A5A4958.CE11C79B@goingware.com> <3A5B0D0C.719E69F@innominate.de> <20010110115632.E30055@pcep-jamie.cern.ch> <3A5DC376.D9E5103F@innominate.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5DC376.D9E5103F@innominate.de>; from phillips@innominate.de on Thu, Jan 11, 2001 at 03:30:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
>         DN_OPEN       A file in the directory was opened
> 
> You open the top level directory and register for events.  When somebody
> opens a subdirectory of the top level directory, you receive
> notification and register for events on the subdirectory, and so on,
> down to the file that is actually modified.

If it worked, and I'm not sure the timing would be reliable enough, the
daemon would only have to have open every directory being accessed by
every program in the system.  Hmm.  Seems like overkill when you're only
interested in files that are being modified.

It would be much, much more reliable to do a walk over d_parent in
dnotify.c.  Your idea is a nice way to flag kernel dentries such that
you don't do d_parent walks unnecessarily.

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
