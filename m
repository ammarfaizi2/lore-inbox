Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263553AbTCUH6Z>; Fri, 21 Mar 2003 02:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263555AbTCUH6Z>; Fri, 21 Mar 2003 02:58:25 -0500
Received: from mailproxy.de.uu.net ([192.76.144.34]:17113 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S263553AbTCUH6X>; Fri, 21 Mar 2003 02:58:23 -0500
Message-ID: <7A5D4FEED80CD61192F2001083FC1CF906513A@CHARLY>
From: "Filipau, Ihar" <ifilipau@sussdd.de>
To: "'Kevin Curtis'" <kevin.curtis@farsite.co.uk>,
       "'bert hubert'" <ahu@ds9a.nl>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: read() & close()
Date: Fri, 21 Mar 2003 09:07:38 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Thanks for replies.

  Mea culpa. Partially ;-)

  1. first problem - sockets. I will check shutdown() - but 
    I am doing shutdown(). This is listen() socket.
    Or I was caught with SO_LINGER again... I will check 
    this again.

  2. buggy driver from second party company has no wake_up 
    in release code. In turn I have copied part of /generic/
    code from this driver - so I had same troubles.
    I have just checked the (reference for me) pipe/fifo 
    implementations - they do wake_up in release.

  Thanks for the help.

P.S.  Actually I have managed to press my management and they 
 agreed on shift to single-threaded design. So I hope this 
 will be not a problem any more at all.


> 
> 
> Hi,
> 	I have come across this problem when implementing a 
> sockets interface to our X.25 card.  On the thread that wants 
> to close the socket, it must first issue a shutdown().  This 
> will unblock the read() or poll(). And then you can do the close().  
> 
> 
> Kevin
> 
> -----Original Message-----
> From: bert hubert [mailto:ahu@ds9a.nl]
> Sent: 20 March 2003 15:08
> To: Filipau, Ihar
> Cc: 'linux-kernel@vger.kernel.org'
> Subject: Re: read() & close()
> 
> 
> On Thu, Mar 20, 2003 at 03:14:52PM +0100, Filipau, Ihar wrote:
> 
> >     I have/had a simple issue with multi-threaded programs:
> > 
> >     one thread is doing blocking read(fd) or poll({fd}) on 
> >     file/socket.
> 
> You can't do poll on a file, it won't tell you anything 
> useful, so I assume you mean a socket.
> 
> >     another thread is doing close(fd).
> > 
> >     I expected first thread will unblock with some kind 
> >     of error - but nope! It is blocked!
> 
> Can you show code with this problem?
> 
> Regards,
> 
> bert
> 
> -- 
> http://www.PowerDNS.com      Open source, database driven DNS 
> Software 
> http://lartc.org           Linux Advanced Routing & Traffic 
> Control HOWTO
> http://netherlabs.nl                         Consulting
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
