Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312792AbSCVSbc>; Fri, 22 Mar 2002 13:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312790AbSCVSbP>; Fri, 22 Mar 2002 13:31:15 -0500
Received: from relay.softcomca.com ([168.144.1.70]:63237 "EHLO
	relay3.softcomca.com") by vger.kernel.org with ESMTP
	id <S312792AbSCVSbK> convert rfc822-to-8bit; Fri, 22 Mar 2002 13:31:10 -0500
X-Originating-IP: 4.20.162.6
X-URL: http://www.mail2web.com/
Subject: RE: Re: max number of threads on a system
From: "joeja@mindspring.com" <joeja@mindspring.com>
Date: Fri, 22 Mar 2002 13:36:04 -0500
To: "davidel@xmailserver.org" <davidel@xmailserver.org>,
        "davidsen@tmr.com" <davidsen@tmr.com>,
        "davids@webmaster.com" <davids@webmaster.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: joeja@mindspring.com
X-Priority: 3
X-MSMail-Priority: Normal
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Mailer: JMail 3.7.0 by Dimac (www.dimac.net)
Message-ID: <RELAY3vnamiODNFYHpZ00003e73@relay3.softcomca.com>
X-OriginalArrivalTime: 22 Mar 2002 18:31:11.0768 (UTC) FILETIME=[BDE8F180:01C1D1CF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > On Thu, 21 Mar 2002 20:05:39 -0500, joeja@mindspring.com wrote:
> > > >What limits the number of threads one can have on a Linux system?
> > >
> > > 	Common sense, one would hope.

I have none of that ;-).  No this is actually a test.  The only reason I'm even looking into pthreads is portability.  While this may be an excessive amount of threads if the box has he capacity then I'd want to take advantage of that for batch jobs. 

> > $ ulimit -u

unlimited

> /proc/sys/kernel/threads-max is the system limit. And "locks up" is odd
> unless the application is really poorly written to handle errors. Should
> time out and whine ;-)

This file shows 8192.  

>Around 250 was the old limit for max user processes ( non root ), if i
>remember well.

In 2.4.17 that seems to be what I'm hitting.  Actually it is 254.

How long before it times out?

thread number = 254  rc = 0

On thread 255 it does error out, however if I call exit then the program hangs.

This hangs:
if (rc > 0) { return -1;}

This hangs:
if (rc > 0) { exit(-1);}

This works:
if (rc > 0) { goto EXIT ;}

where exit is:

EXIT:
    calls pthread_join();

It would seem that the functionality and behavior of threads on Sun is different from that of Linux.   

Joe


--------------------------------------------------------------------
mail2web - Check your email from the web at
http://mail2web.com/ .

