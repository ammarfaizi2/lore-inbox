Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269879AbUJGWqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269879AbUJGWqX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269856AbUJGWVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:21:15 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:44473 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S269854AbUJGWUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:20:42 -0400
Message-ID: <000901c4acc4$26404450$161b14ac@boromir>
From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
To: "David S. Miller" <davem@davemloft.net>,
       "Chris Friesen" <cfriesen@nortelnetworks.com>
Cc: <hzhong@cisco.com>, <jst1@email.com>, <linux-kernel@vger.kernel.org>,
       <alan@lxorguk.ukuu.org.uk>, <davem@redhat.com>
References: <00e501c4ac9a$556797d0$b83147ab@amer.cisco.com><41658C03.6000503@nortelnetworks.com><015f01c4acbe$cf70dae0$161b14ac@boromir><4165B9DD.7010603@nortelnetworks.com> <20041007150035.6e9f0e09.davem@davemloft.net>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Date: Fri, 8 Oct 2004 00:19:52 +0100
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

From: "David S. Miller" <davem@davemloft.net>
> On Thu, 07 Oct 2004 15:49:17 -0600
> Chris Friesen <cfriesen@nortelnetworks.com> wrote:
> 
> > In this case, select() returns with the socket readable, we call recvmsg() and 
> > discover the message is corrupt.  At this point we throw away the corrupt 
> > message, so we now have no data waiting to be received.  We return EAGAIN, and 
> > userspace goes merrily on its way, handling anything else in its loop, then 
> > going back to select().
> 
> Incorrect.  When the user specifies blocking on the file descriptor
> we must give it what it asked for.  -EAGAIN on a blocking file descriptor
> is always a bug, in all situations, that's what this code used to do and we
> fixed it because it's a bug.

So why not return EIO instead? It would be even better to have select()
validate the data, but I think returning EIO is better than blocking and most
likely POSIX compliant.


--ms

