Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbSIWSx4>; Mon, 23 Sep 2002 14:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261378AbSIWSxM>; Mon, 23 Sep 2002 14:53:12 -0400
Received: from ccc-static.netway.com ([216.177.12.130]:34067 "HELO ccc.com")
	by vger.kernel.org with SMTP id <S261420AbSIWSqk>;
	Mon, 23 Sep 2002 14:46:40 -0400
To: Shailabh Nagar <nagar@watson.ibm.com>
cc: Stephen Hemminger <shemminger@osdl.org>,
       Benjamin LaHaise <bcrl@redhat.com>, Andrew Morton <akpm@digeo.com>,
       Alexander Viro <viro@math.psu.edu>, linux-aio <linux-aio@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
From: "Clement T. Cole" <clemc@alumni.cmu.edu>
Subject: Re: [RFC] adding aio_readv/writev 
Really-From: Clement T. Cole
Organization: President/Owner, Cole Computer Consulting
In-reply-to: Your message of "Mon, 23 Sep 2002 10:30:05 EDT."
             <3D8F256D.1070107@watson.ibm.com> 
Reply-To: clemc@alumni.cmu.edu
Date: Mon, 23 Sep 2002 14:53:40 -0400
Message-Id: <20020923184838Z261420-8740+46@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Comments, reasons for not doing async readv/writev directly welcome.

How about the case for it...  See Pages 404-406 [Section 12.7] of
Richard Steven's ``Advanced Programming in the Unix Environment''
[aka APUE].  Richard measures almost a factor of 2 difference
in system time between using vectored I/O and not using it on
a Sun and on a x86.

>>- there exists at least one major application class (databases)
>>  that uses vectored I/O heavily and benefits from async I/O.
>>  Hence async vectored I/O is also likely to be useful. Can anyone
>>  else with experience on other OS's comment on this ?

			....  a number of other comments/arguments from other
			....  responces removed to get the meat of the discussion.

Becareful out there.....

Large commercial applications such as Oracle DB, IBM's DB2 or
Netscape Enterprise server for that matter - are very modular in
their interface to OS because they have to be and have been, ported
and tuned to run on a number of different OS's and HW architectures.
When I see some one say something about ``Oracle'' doing X or Y -
I get a little worried.

Which version, which port etc...  e.g. Oracle's DB running on VMS
has a different I/O system interface that is different from any of
it's Unix implementations...... oh yes - was the clustered or
not... did it have the X package etc...

The point is that the UNIX implementations of Oracle DB vary
widely.....  This is also true of every >>major<< application package
I have worked/consulted seen some of the insides (SAP, Informix,
Netscape,  etc...).

Solaris and Tru64 [and I would expect AIX, HP-UX
etc... but I only know these two personally] each offer
a highly parallel I/O, asynchronous (but proprietary) interface.
Oracle's Sun group (or the old DEC group) exploit the >>private<<
interfaces -- to make the code work better - they do.

That may or may not be what you have seen on some ``simple Un*x''
port - which is a starting point for them - that's not the code
they ship on the high end revenue systems.

Oracle/IBM/Netscape etc... do this cause the want to grab customers
from their competetors (DB2, Informix, etc.)... they invest in
using the best interfaces available.... if they are available
AND if they can help them sell more copies of their product.


So... let's get back to the basic issue....

We know that vectored/scatter gather I/O can help a number of real
applications ... Richard demonstrated that.  We have some examples
[like DB2] that have use vectored I/O successfully.  We also
know asynchronous I/O has been demonstrated to be useful and
know that some commerical folks have used that.  

I'm gather from some of the comments, adding async/vectored
will make an already complex subsystem, even more so [i.e. not
a resounding endorsement for sure this is easy].

So the question is can async vectored I/O be implemented 
to have a positive gain, such as it did within the traditonal one.
If the complexity is too high and it does not help much...then
maybe this is a Chimera to leave alone.   But.... if it can be
done with some level of elegance... well.... the past history is
that the commerical folks have used those features.

I know this this sounds a little bit like:
	``if you build it - they will come.'' 

But I would say it's more to this point:
	 ``if you build it and this new feature shows some real value
	   AND the application can exploit it ...  in time, they will
	   because if they don't their competetors will.''

Clem Cole
