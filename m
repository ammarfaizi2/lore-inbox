Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267330AbUJGK2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267330AbUJGK2q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 06:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267381AbUJGK2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 06:28:46 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:27568 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S267330AbUJGK2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 06:28:44 -0400
Message-ID: <000401c4ac60$db477df0$161b14ac@boromir>
From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
To: "Adam Heath" <doogie@debian.org>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <4164CB02.2030607@kegel.com> <20041007080414.GA28999@outpost.ds9a.nl> <Pine.LNX.4.58.0410070328010.1194@gradall.private.brainfood.com> <021b01c4ac59$cbe92ea0$161b14ac@boromir> <Pine.LNX.4.58.0410070506400.1194@gradall.private.brainfood.com>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Date: Thu, 7 Oct 2004 12:29:06 +0100
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
Sent: Thursday, October 07, 2004 11:07


> On Thu, 7 Oct 2004, Martijn Sipkema wrote:
> 
> > > > It does not matter - this behaviour should not be depended upon. There are
> > > > lots of other reasons why a packet might in fact not be available, kernels
> > > > are allowed to drop UDP packets at will.
> > >
> > > I've been lurking and reading this thread with great interest.  I had been
> > > leaning towards thinking the kernel was wrong, until I read this email.
> > >
> > > This is a very excellent point.
> >
> > No, it isn't. If the kernel drops a UDP packet, select() should not return
> > indicating available data.
> 
> The kernel can drop a packet after select() returns, and before read() is
> called.  That's the whole point of *U*DP.

I don't think that is the point of UDP and I don't think the kernel should
do that, but there are two options for handling this:

If recvmsg() blocks until valid data is available then so should select().
If recvmsg() returns an error on invalid data then select() would indicate the
socket() as ready without knowing if the data was valid.


--ms

