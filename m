Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267314AbUJGPil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267314AbUJGPil (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 11:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267397AbUJGPil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 11:38:41 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:58548 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S267314AbUJGPih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 11:38:37 -0400
Message-ID: <004901c4ac8c$2a14ed70$161b14ac@boromir>
From: "Martijn Sipkema" <martijn@entmoot.nl>
To: "Adam Heath" <doogie@debian.org>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>  <20041006080104.76f862e6.davem@davemloft.net>  <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com>  <20041006082145.7b765385.davem@davemloft.net>  <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com>  <Pine.LNX.4.61.0410070212340.5739@hibernia.jakma.org>  <4164EBF1.3000802@nortelnetworks.com>  <Pine.LNX.4.61.0410071244150.304@hibernia.jakma.org>  <001601c4ac72$19932760$161b14ac@boromir>  <Pine.LNX.4.61.0410071346040.304@hibernia.jakma.org>  <001c01c4ac76$fb9fd190$161b14ac@boromir> <1097156929.31753.47.camel@localhost.localdomain> <Pine.LNX.4.58.0410071017300.1194@gradall.private.brainfood.com>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Date: Thu, 7 Oct 2004 17:39:06 +0100
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

From: "Adam Heath" <doogie@debian.org>
> On Thu, 7 Oct 2004, Alan Cox wrote:
> 
> > On Iau, 2004-10-07 at 15:07, Martijn Sipkema wrote:
> > > > Much can change between the select() and recvmsg - things outside of
> > > > kernel control too, and it's long been known.
> > >
> > > There is no change; the current implementation just checks the validity of
> > > the data in the recvmsg() call and not during select().
> >
> > The accept one is documented by Stevens and well known. In the UDP case
> > currently we could get precise behaviour - by halving performance of UDP
> > applications like video streaming. We probably don't want to  because we
> > can respond intelligently to OOM situations by freeing the queue if we
> > don't enforce such a silly rule.
> 
> Also, pkts could be dropped even for TCP sockets.  TCP will cause the pkt to
> be retransmitted, but while that is occuring, the read that was prompted by
> the select will still block.
> 
> So, any app that does not use O_NONBLOCK is broken, if they assume that a
> successful select will indicate a nonblocking read/recvmsg.

Aaargh... I'm going to shut up about this now, because this is clearly going
nowhere, but you are saying that any application that expects behaviour as
defined in POSIX is broken, and that bothers me..


--ms

