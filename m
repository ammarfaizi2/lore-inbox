Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131678AbRA3BGt>; Mon, 29 Jan 2001 20:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131666AbRA3BGm>; Mon, 29 Jan 2001 20:06:42 -0500
Received: from cs.columbia.edu ([128.59.16.20]:39314 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S131678AbRA3BGg>;
	Mon, 29 Jan 2001 20:06:36 -0500
Date: Mon, 29 Jan 2001 17:06:31 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: jamal <hadi@cyberus.ca>
cc: Andrew Morton <andrewm@uow.edu.au>, lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <Pine.GSO.4.30.0101270747210.24088-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.30.0101291621120.31713-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jan 2001, jamal wrote:

> > starfire:
> > 2.4.1-pre10+zerocopy, using sendfile():		 9.6% CPU
> > 2.4.1-pre10+zerocopy, using read()/write():	18.3%-29.6% CPU		* why so much variance?
> >
>
> What are your throughput numbers?

11.5kBps, quite consistently.

BTW, Andrew's new tool (with 8k reads/writes) has shown the load in the
read/write case to be essentially the lower margin of the intervals I got
in the first mail.

> Could you also, please, test using:
>
> http://www.cyberus.ca/~hadi/ttcp-sf.tar.gz
>
> post both sender and receiver data. Repeat each test about
> 5 times.

I've tried it, but I'm not really sure what I can report. ttcp's
measurements are clearly misleading, so I used Andrew's cyclesoak instead.
The numbers are (with 2.4.1-pre10+zerocopy):

[starfire, hw csum & sg enabled]
sending with sendfile:		10.0-10.2%
sending with send/write:	13.5-13.7%
receiving:			20.0-20.2%

[starfire, hw csum & sg disabled]
sending with sendfile:		18.1-18.3%
sending with send/write:	13.9-14.1%
receiving:			24.3-24.5%

[eepro100, i82559, no hw fancies]
sending with sendfile:		16.2-16.4%
sending with send/write:	12.0-12.2%
receiving:			21.5-21.7%

Same tests, this time with 2.4.1-pre10 vanilla:

[starfire]
sending with sendfile:		18.1-18.3%
sending with send/write:	12.5-12.7%
receiving:			23.0-23.1%

[eepro100, i82559]
sending with sendfile:		16.7-16.9%
sending with send/write:	12.0-12.2%
receiving:			20.8-20.9%


Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
