Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130149AbRAPNtY>; Tue, 16 Jan 2001 08:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129485AbRAPNtO>; Tue, 16 Jan 2001 08:49:14 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:24851 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S129735AbRAPNtF>; Tue, 16 Jan 2001 08:49:05 -0500
Date: Tue, 16 Jan 2001 14:48:49 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
Message-ID: <20010116144849.B19949@pcep-jamie.cern.ch>
In-Reply-To: <20010116114018.A28720@convergence.de> <Pine.LNX.4.30.0101161338270.947-100000@elte.hu> <20010116134737.A29366@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010116134737.A29366@convergence.de>; from leitner@convergence.de on Tue, Jan 16, 2001 at 01:47:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix von Leitner wrote:
> I cheated.  I was only talking about open().
> close() is of course more expensive then.
> 
> Other than that: where does the requirement come from?
> Can't we just use a free list where we prepend closed fds and always use
> the first one on open()?  That would even increase spatial locality and
> be good for the CPU caches.

You would need to use a new open() flag: O_ANYFD.
The requirement comes from this like this:

  close (0);
  close (1);
  close (2);
  open ("/dev/console", O_RDWR);
  dup ();
  dup ();

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
