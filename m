Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270969AbRHOAbD>; Tue, 14 Aug 2001 20:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270974AbRHOAay>; Tue, 14 Aug 2001 20:30:54 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:16359 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S270979AbRHOAag>;
	Tue, 14 Aug 2001 20:30:36 -0400
Message-ID: <3B79C38E.1301044E@sun.com>
Date: Tue, 14 Aug 2001 17:34:22 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] agreed upon poll change
In-Reply-To: <20010814.163804.66057702.davem@redhat.com>
		<3B79BA07.B57634FD@sun.com>
		<20010815021110.F4304@athlon.random> <20010814.171609.75760869.davem@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------961B3A286156E310CA2558A4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------961B3A286156E310CA2558A4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"David S. Miller" wrote:

> Right, and our equivalent is "NR_OPEN".
> 
> Ok, I think I see what you and Tim are trying to say.
> I'm thinking in a select() minded way which is why I didn't
> understand :-)

Whew! :)

> Yeah, the check can be removed, but anyone who cares about
> performance won't pass in huge arrays of -1 entries if only
> the low few pollfd entries are actually useful.

of course...patch attached, for anyone who cares - do we need to send it to
anyone else, or are you going to channel it in, Dave?

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------961B3A286156E310CA2558A4
Content-Type: text/plain; charset=us-ascii;
 name="poll-paranoid.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="poll-paranoid.diff"

Index: fs/select.c
===================================================================
RCS file: /home/cvs/linux-2.4/fs/select.c,v
retrieving revision 1.5
diff -u -r1.5 select.c
--- fs/select.c	2001/07/09 23:10:25	1.5
+++ fs/select.c	2001/08/15 00:28:13
@@ -419,9 +419,6 @@
 	if (nfds > NR_OPEN)
 		return -EINVAL;
 
-	if (nfds > current->files->max_fds)
-		nfds = current->files->max_fds;
-
 	if (timeout) {
 		/* Careful about overflow in the intermediate values */
 		if ((unsigned long) timeout < MAX_SCHEDULE_TIMEOUT / HZ)

--------------961B3A286156E310CA2558A4--

