Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154005-8316>; Fri, 11 Sep 1998 16:16:51 -0400
Received: from send1c.yahoomail.com ([205.180.60.38]:40988 "HELO send1c.yahoomail.com" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with SMTP id <154524-8316>; Fri, 11 Sep 1998 15:57:21 -0400
Message-ID: <19980911224927.2503.rocketmail@send1c.yahoomail.com>
Date: Fri, 11 Sep 1998 15:49:27 -0700 (PDT)
From: "Ethan O'Connor" <zudark@yahoo.com>
Subject: Re: GPS Leap Second Scheduled!
To: R.E.Wolff@BitWizard.nl
Cc: linux-kernel@vger.rutgers.edu, chris@cybernet.co.nz
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-kernel@vger.rutgers.edu

Roger Wolff wrote:

>Chris Wedgwood wrote:
>> On Wed, Sep 09, 1998 at 02:13:42PM -0600, Colin Plumb wrote:
>> 
>> > - gettimeofday() never returns the same value twice (documented BSD
>> >   behaviour)
>> 
>> Ouch... gettimeofday(2) only presently has usec resolution. I suspect
>> we can make this report the same value twice on really high end boxes
>> (667MHz Alpha maybe, 400Mhz Sparcs?), if not now, in a year or so.
>> Even a P.ii 600 or so can probably manage it.

>This is defined behaviour. On processors where gettimeofday can be
>called more than once in a microsecond (SMP systems, and fast
>systems), the kernel is required to keep a last-time-returned, and
>increment it and return that if the value calculated is below the
>stored value.

>If you have the results from two gettimeofday calls, you can always
>subtract them and divide by the result without checking for zero.
>That's what the spec says.

>A kernel will get into trouble if you keep on calling gettimeofday
>more than a million times a second..... 


Modifying Chris's code to call gettimeofday() 4 times
the second time around and to print the usec values 
for the four successive calls yields the following on
this system (SunOS 5.6, Ultra-IIi/333Mhz):

athena% a.out
213426
213426
213426
213427
athena% a.out
499126
499126
499127
499127

and even:

athena% a.out
947875
947875
947875
947875

Etc... 

FWIW.

-Ethan O'Connor
_________________________________________________________
DO YOU YAHOO!?
Get your free @yahoo.com address at http://mail.yahoo.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html
