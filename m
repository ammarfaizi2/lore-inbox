Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264092AbTEOPnH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 11:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264093AbTEOPnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 11:43:07 -0400
Received: from hermes.ctd.anl.gov ([130.202.113.27]:26864 "EHLO
	hermes.ctd.anl.gov") by vger.kernel.org with ESMTP id S264092AbTEOPnB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 11:43:01 -0400
Message-ID: <3EC3B861.87C4FD@anl.gov>
Date: Thu, 15 May 2003 10:55:13 -0500
From: "Douglas E. Engert" <deengert@anl.gov>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Garance A Drosihn <drosih@rpi.edu>
CC: Linus Torvalds <torvalds@transmeta.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [OpenAFS-devel] Re: [PATCH] PAG support, try #2
References: <Pine.LNX.4.44.0305141749490.28007-100000@home.transmeta.com> <p0521061cbae93d4b61b2@[128.113.24.47]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Transfer-Encoding: 7bit
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Garance A Drosihn wrote:

> 
> There is ZERO connection between login ids and PAG numbers.  It
> is entirely for tracking "sessions".  If I am on one machine and
> ssh into another one, the session on the remote machine will be
> one PAG.  If I ssh into the exact same userid a second time, it
> will get a second PAG.  There is absolutely no reason for the
> second session to have the slightest idea of what PAG the first
> session is using.  It's like saying "the second session has to
> know the pid of the first process of the first session".  This
> is just a false idea of what the PAG is tracking.
> 
>

I disagree. From the user's perspective, what they might call a session
does not require a process to be keep active. It does not have to
depend on a connection to be kept active either. They may want to 
stage credentials, then come back later with a new connection then use
these credentials.  They might wish to use multiple TCP connections
to the same machine, and have them be considered a session.   

The point is how can this be done, and can the OS assist in this at all.
Is the PAG the way to identify this, or is the PAG a kernel only concept
which is associated with active processes and sub processes. 

Traditionally, the session was defined by the process started for the user
and its sub processes when a network connection or key board login was
started.     

Also traditionally with some systems, the user could stage credentials,
i.e. the Kerberos ticket cache in /tmp owned by the user, so subsequent
connections by the same user could use the previous ticket cache, and 
the user could continue his session. 

With AFS the token was in the kernel, and not stored where the user
could come back and use it later, thus requiring the acquisition of 
a new token at each connection. But the AFS token was not a lot of 
overhead to acquire. 

But DCE/DFS got more complicated, as there might be more tickets, 
one for each file server, and there were the PTGTs as well with group
info. They tied the name of the credential file to the PAG number used
by the kernel, thus they did not have this capability either,
unless the files where copied, or you could join the existing DFS 
PAG if it was still active in the kernel. 

SSL session caching is a good example. After the initial session was 
established, the web server can hold on to the SSL session info, so 
that if the  same user connects again with a separate SSL session, but 
can use the same session key, the certificate verification process does 
not need to be done again. Thus avoiding a lot of overhead. How can you do 
something similar be done in a more general fashion by the OS. 


> 
> --
> Garance Alistair Drosehn            =   gad@gilead.netel.rpi.edu
> Senior Systems Programmer           or  gad@freebsd.org
> Rensselaer Polytechnic Institute    or  drosih@rpi.edu
> _______________________________________________
> OpenAFS-devel mailing list
> OpenAFS-devel@openafs.org
> https://lists.openafs.org/mailman/listinfo/openafs-devel

-- 

 Douglas E. Engert  <DEEngert@anl.gov>
 Argonne National Laboratory
 9700 South Cass Avenue
 Argonne, Illinois  60439 
 (630) 252-5444
