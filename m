Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261217AbRE2RfX>; Tue, 29 May 2001 13:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261289AbRE2RfN>; Tue, 29 May 2001 13:35:13 -0400
Received: from marine.sonic.net ([208.201.224.37]:4372 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S261217AbRE2RfB>;
	Tue, 29 May 2001 13:35:01 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Tue, 29 May 2001 10:34:47 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: select() - Linux vs. BSD
Message-ID: <20010529103446.B24802@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NDBBKBJHGFJMEMHPOPEGKEIICHAA.jcwren@jcwren.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2001 at 11:55:24AM -0400, John Chris Wren wrote:
> select will not be altered.  In Linux, which claims BSD compliancy for this
> in the man page (but does not state either way what will happen to the
> bits), zeros the users bit masks when a timeout occurs.  I have written a

Where in the man page does it state this?  I just read it and couldn't find
any such statement.

I do, however, find the following:

       exceptfds will be watched for exceptions.   On  exit,  the
       sets  are  modified in place to indicate which descriptors
       actually changed status.


If there is a time out, it makes sense that no descriptors changed state,
and so everything would be zeroed out.

And actually, the example seems to support this:

           if (retval)
               printf("Data is available now.\n");
               /* FD_ISSET(0, &rfds) will be true. */

The comment seems to indicate that if retval is 0, then FD_ISSET will be
false.

mrc
-- 
       Mike Castle       Life is like a clock:  You can work constantly
  dalgoda@ix.netcom.com  and be right all the time, or not work at all
www.netcom.com/~dalgoda/ and be right at least twice a day.  -- mrc
    We are all of us living in the shadow of Manhattan.  -- Watchmen
