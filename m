Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154428-8316>; Thu, 10 Sep 1998 08:50:20 -0400
Received: from PACIFIC-CARRIER-ANNEX.MIT.EDU ([18.69.0.28]:3391 "HELO MIT.EDU" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with SMTP id <154498-8316>; Thu, 10 Sep 1998 08:27:41 -0400
Date: Thu, 10 Sep 1998 11:05:38 -0400
Message-Id: <199809101505.LAA24441@dcl.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: hpa@transmeta.com
Cc: linux-kernel@vger.rutgers.edu
In-Reply-To: H. Peter Anvin's message of 10 Sep 1998 01:37:05 GMT, <6t7ag1$trf$1@palladium.transmeta.com>
Subject: Re: GPS Leap Second Scheduled!
Address: 1 Amherst St., Cambridge, MA 02139
Phone: (617) 253-8091
Sender: owner-linux-kernel@vger.rutgers.edu

   From: hpa@transmeta.com (H. Peter Anvin)
   Date: 	10 Sep 1998 01:37:05 GMT
   Right.  I think the right solution is one I suggested on c.o.l.d.s
   recently:

   - time_t being a 64-bit signed integer linked to UTC
   - struct timespec (and struct timeval, presumably) having an extra
     field added:

	   64-bit seconds field (same as time_t) linked to UTC
	   32-bit nanosecond field (microsecond for timeval) linked to TAI
	   32-bit integral TAI-UTC difference

This works, although it would require making a glibc interface change.
But if the ELF symbol versioning works out, perhaps this won't be as big
of an issue.

However, in order to in sync with POSIX.1's definition of how time_t relates to
UTC time, I'd suggest that we make the progression go as follows:

... making the progress go as follows:

	tv_sec		tv_delta	UTC
	   T-1		N		23:59:59
	   T		N		23:59:60
	   T		N+1		00:00:00
	   T+1		N+1		00:00:01

(that is, repeat tv_sec == T instead of tv_sec == T-1).

						- Ted

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html
