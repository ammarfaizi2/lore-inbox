Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267563AbUJGVqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267563AbUJGVqD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268086AbUJGVoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:44:30 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:4537 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S267563AbUJGVmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:42:20 -0400
Message-ID: <015f01c4acbe$cf70dae0$161b14ac@boromir>
From: "Martijn Sipkema" <martijn@entmoot.nl>
To: "Chris Friesen" <cfriesen@nortelnetworks.com>, <hzhong@cisco.com>
Cc: "'Jean-Sebastien Trottier'" <jst1@email.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'David S. Miller'" <davem@redhat.com>
References: <00e501c4ac9a$556797d0$b83147ab@amer.cisco.com> <41658C03.6000503@nortelnetworks.com>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Date: Thu, 7 Oct 2004 23:41:37 +0100
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
> Hua Zhong wrote:
> 
> > It was my original proposal. The only question is to return which error
> > code. We cannot return EAGAIN as Posix explicitly disallows it. Is EIO good?
> > Or some other new error code?
> 
> Since we wouldn't be posix compliant anyway in the nonblocking case, we may as 
> well return EAGAIN--it's the most appropriate.

No, I don't think so, since POSIX says to return EAGAIN when:

  The socket's file descriptor is marked O_NONBLOCK and no data is waiting to
  be received; or MSG_OOB is set and no out-of-band data is available and either
  the socket's file descriptor is marked O_NONBLOCK or the socket does not
  support blocking to await out-of-band data

So, I think returning EIO is probably better; I think that would be POSIX
compliant.


--ms

