Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268617AbRG3WK1>; Mon, 30 Jul 2001 18:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268628AbRG3WKV>; Mon, 30 Jul 2001 18:10:21 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:63708 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268617AbRG3WKD>; Mon, 30 Jul 2001 18:10:03 -0400
Date: Mon, 30 Jul 2001 15:08:34 -0700 (PDT)
From: Sridhar Samudrala <samudrala@us.ibm.com>
To: jamal <hadi@cyberus.ca>
cc: diffserv-general@lists.sourceforge.net, kuznet@ms2.inr.ac.ru,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org, rusty@rustcorp.com.au, thiemo@sics.se,
        Sridhar Samudrala <samudrala@us.ibm.com>,
        Renu Tewari <tewarir@us.ibm.com>, dmfreim@us.ibm.com
Subject: Re: [Linux Diffserv] Re: [PATCH] Inbound Connection Control mechanism:
 Prioritized Accept Queue
In-Reply-To: <Pine.GSO.4.30.0107301515090.7013-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.21.0107301359350.23307-100000@w-sridhar2.des.sequent.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Our patch can be used along with SYN policing to prioritize incoming
connection requests on a socket. SYN policing can be used to limit 
the rate of a particular class, but it cannot be used to prioritize a 
set of classes.  Priorized Accept Queues(PAQ) provides a way to classify 
incoming connections on a socket into a set of upto 8 classes and uses 
the priority of a connection to insert them into the accept queue. By 
default a connection is added at the end of the accept queue.  With PAQ, 
the connection is inserted at the end of the corresponding class within 
the accept queue. This will improve the latency and throughput for higher
priority connections.

We found that there are 2 ways to do SYN policing in linux. The first 
method is using the ingress policer which may be more effective as it 
uses dual token bucket.  The second way is to use iptables. It is simpler 
to configure via iptables as the rate limit can be specified in 
connections/sec as opposed to bytes/sec with ingress.  This may not be 
much of an issue if all the SYN packets are of fixed size (can change with 
options). 

Our patch does not in any way replace the functionality provided with 
SYN policing. It tries to extend the inbound qos functionality by adding 
prioritization of incoming connections that are going to be accepted.

oss.software.ibm.com is running linux 2.2.19. I guess linux should by
default ignore ECN bits if it is not enabled. Do you think this ECN problem 
has something to do with the server or some router on the way the server?
 
Thanks
Sridhar

On Mon, 30 Jul 2001, jamal wrote:
> 
> 
> For startes, can you fix
> oss.software.ibm.com so it respects ECN?
> 
> In regards to policing SYNs i am not sure what additional
> value you provide to the mechanisms currently available under
> 2.4 ingress traffic policing; the simplest example we provided
> was on SYN policing albeit for DoS prevention.
> Since i refuse to turn off ECN, i cant access your web page
> You can use the skbmark to prioritize based on policies
> installed on the ingress and drop early ...
> 
> Incase you are using this scheme already you should stick to the
> ingress policer which uses a dual Token Bucket not what netfilter uses..
> 
> cheers,
> jamal
> 
> On Mon, 30 Jul 2001, Douglas M Freimuth wrote:
> 
> >
> >
> > On Fri, 27 Jul 2001,Sridhar wrote:
> >
> > >The documentation on HOWTO use this patch and the test results which show
> > an
> > >improvement in connection rate for higher priority classes can be found at
> > our
> > >project website.
> > >        http://oss.software.ibm.com/qos
> >
> >      For additional detail regarding the Prioritized Accept Queue (PAQ)
> > patch please read
> > "Kernel Mechanisms for Service Differentiation in Overloaded Web Servers"
> > originally published in
> > the 2001 Proceedings of the USENIX Annual Technical Conference
> > (USENIX Association, 2001), pp. 189-202. at the following USENIX site:
> >
> > http://www.usenix.org/publications/library/proceedings/usenix01/voigt.html
> >
> > For USENIX  nonmembers later this week will "reprint" this USENIX paper on
> > our project
> > website.
> >      http://oss.software.ibm.com/qos
> >
> > --Doug
> > =================================================================
> > Doug Freimuth
> >    IBM TJ Watson Research Center
> >    Office  914-784-6221
> >    dmfreim@us.ibm.com
> >
> >
> > _______________________________________________
> > Diffserv-general mailing list
> > Diffserv-general@lists.sourceforge.net
> > http://lists.sourceforge.net/lists/listinfo/diffserv-general
> >
> 

