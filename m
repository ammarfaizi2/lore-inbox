Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265624AbSJRS5W>; Fri, 18 Oct 2002 14:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265622AbSJRS4d>; Fri, 18 Oct 2002 14:56:33 -0400
Received: from mtao-m02.ehs.aol.com ([64.12.52.8]:30684 "EHLO
	mtao-m02.ehs.aol.com") by vger.kernel.org with ESMTP
	id <S265623AbSJRS4T>; Fri, 18 Oct 2002 14:56:19 -0400
Date: Fri, 18 Oct 2002 12:02:10 -0700
From: John Gardiner Myers <jgmyers@netscape.com>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
In-reply-to: <Pine.LNX.4.44.0210171121390.1631-100000@blue1.dev.mcafeelabs.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Dan Kegel <dank@kegel.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Message-id: <3DB05AB2.3010907@netscape.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2b)
 Gecko/20021016
References: <Pine.LNX.4.44.0210171121390.1631-100000@blue1.dev.mcafeelabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:

>Look, I'm usually very polite but you're really wasting my time. You
>should know that an instruction at line N is usually executed before an
>instruction at line N+1. Now this IS your code :
>
>[N-1] for (;;) {
>[N  ]     fd = event_wait(...);
>[N+1]     while (do_io(fd) != EAGAIN);
>[N+2} }
>
>I will leave you as an exercise to understand what happens when you call
>the first event_wait(...); and there is still data to be read/write on the
>file descriptor.
>
Your claim was that even if the API will drop an event at registration 
time, my code scheme would not work.  Thus, we can take "the API will 
drop an event at registration time" as postulated.  That being 
postulated, if there is still data to be read/written on the file 
descriptor then the first event_wait will return immediately.

In fact, given that postulate and the appropriate axioms about the 
behavior of event_wait() and do_io(), one can prove that my code scheme 
is equivalent to yours.  The logical conclusion from that and your claim 
would be that you don't understand how edge triggered APIs have to be used.

>The reason you're asking /dev/epoll to drop an event at
>fd insertion time shows very clearly that you're going to use the API is
>the WRONG way and that you do not understand how such APIs works.
>
The wrong way as defined by what?  Having /dev/epoll drop appropriate 
events at registration time permits a useful simplification/optimization 
and makes the system significantly less prone to subtle progamming errors.

I do understand how such APIs work, to the extent that I am pointing out 
a flaw in their current models.

>And the fact that there're users currently using the rt-sig and epoll APIs means
>that either those guys are genius or you're missing something.
>  
>
Nonsense.  People are able to use flawed APIs all of the time.


