Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154682-9022>; Sun, 22 Nov 1998 20:40:58 -0500
Received: from noc.nyx.net ([206.124.29.3]:2190 "EHLO noc.nyx.net" ident: "mail") by vger.rutgers.edu with ESMTP id <155231-9022>; Sun, 22 Nov 1998 19:19:05 -0500
Date: Sun, 22 Nov 1998 18:34:08 -0700 (MST)
From: Colin Plumb <colin@nyx.net>
Message-Id: <199811230134.SAA24922@nyx10.nyx.net>
X-Nyx-Envelope-Data: Date=Sun Nov 22 18:34:08 1998, Sender=colin, Recipient=linux-kernel@vger.rutgers.edu, Valsender=colin@localhost
To: linux-kernel@vger.rutgers.edu
Subject: Re: Timeout overflow in select()
Sender: owner-linux-kernel@vger.rutgers.edu

Marc Slemko <marcs@znep.com> uncovered:

> it is correct to place an upper limit on the timeout.
> From the single unix spec
> (http://www.opengroup.org/publications/catalog/t912.htm):
> Implementations may place limitations on the maximum timeout interval
> supported. On all implementations, the maximum timeout interval
> supported will be at least 31 days. If the timeout argument specifies
> a timeout interval greater than the implementation-dependent maximum
> value, the maximum value will be used as the actual timeout value.
> Implementations may also place limitations on the granularity of
> timeout intervals. If the requested timeout interval requires a
> finer granularity than the implementation supports, the actual
> timeout interval will be rounded up to the next supported value.

Note that this can impose an upper limit on HZ.
In particular, 2^32 jiffies is 31 days at 1603.5 Hz.
If you need an extra bit, 2^31 jiffies is 31 days at 801.8 Hz.

Thus, a 31-bit jiffies limit is not compatible with HZ=1024.

(I distinctly recall looking at the POSIX spec and seeing in the
definition of clock() that it must not wrap before 24 hours, which, if
clock_t is a 32-bit type, implies a maximum CLOCKS_PER_SEC of 49710.
Thus, the common CLOCKS_PER_SEC=1000000 violates this badly, as it
wraps in 1:11:34.967296.  Unfortunately, I don't have a copy of POSIX.1
handy to check my memory.)
-- 
	-Colin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
