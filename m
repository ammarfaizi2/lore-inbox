Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269855AbUJGWU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269855AbUJGWU7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269858AbUJGWTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:19:14 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:39097 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S269854AbUJGWRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:17:24 -0400
Message-ID: <000401c4acc3$d634c800$161b14ac@boromir>
From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
To: "Chris Friesen" <cfriesen@nortelnetworks.com>
Cc: <hzhong@cisco.com>, "'Jean-Sebastien Trottier'" <jst1@email.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'David S. Miller'" <davem@redhat.com>
References: <00e501c4ac9a$556797d0$b83147ab@amer.cisco.com> <41658C03.6000503@nortelnetworks.com> <015f01c4acbe$cf70dae0$161b14ac@boromir> <4165B9DD.7010603@nortelnetworks.com>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Date: Fri, 8 Oct 2004 00:17:37 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Chris Friesen" <cfriesen@nortelnetworks.com>
> Martijn Sipkema wrote:
> > From: "Chris Friesen" <cfriesen@nortelnetworks.com>
> 
> >>Since we wouldn't be posix compliant anyway in the nonblocking case, we may as 
> >>well return EAGAIN--it's the most appropriate.
> > 
> > 
> > No, I don't think so, since POSIX says to return EAGAIN when:
> > 
> >   The socket's file descriptor is marked O_NONBLOCK and no data is waiting to
> >   be received; or MSG_OOB is set and no out-of-band data is available and either
> >   the socket's file descriptor is marked O_NONBLOCK or the socket does not
> >   support blocking to await out-of-band data
> 
> We are discussing the case where the socket is nonblocking and the udp checksum 
> is corrupt, right?  (Because in the blocking case select() would verify the 
> checksum.)
> 
> In this case, select() returns with the socket readable, we call recvmsg() and 
> discover the message is corrupt.  At this point we throw away the corrupt 
> message, so we now have no data waiting to be received.  We return EAGAIN, and 
> userspace goes merrily on its way, handling anything else in its loop, then 
> going back to select().
> 
> Seems perfectly suitable.

Oh, I thought it was about the case where select() does not check the data and
a blocking socket is used and I would think EIO better in that case. But shouldn't
a nonblocking socket return EIO also, since the blocking socket would not in
fact block?

--ms

