Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965256AbVHPOiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965256AbVHPOiS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 10:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965257AbVHPOiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 10:38:18 -0400
Received: from matou.sibbald.ch ([194.158.240.20]:60720 "EHLO
	matou.sibbald.com") by vger.kernel.org with ESMTP id S965256AbVHPOiR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 10:38:17 -0400
From: Kern Sibbald <kern@sibbald.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PROBLEM: blocking read on socket repeatedly returns EAGAIN
Date: Tue, 16 Aug 2005 16:38:14 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200508161519.39719.kern@sibbald.com> <1124200991.17555.33.camel@localhost.localdomain>
In-Reply-To: <1124200991.17555.33.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508161638.15129.kern@sibbald.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 August 2005 16:03, Alan Cox wrote:
> On Maw, 2005-08-16 at 15:19 +0200, Kern Sibbald wrote:
> > have written, nor does it write() anything.  When my read() is issued, I
> > expect it to block, but it immediately returns with -1 and errno set to
> > EAGAIN.  If the read() is re-issued, a CPU intensive loop results as long
> > as the other end does not read() the data written to the socket.  This is
> > a multi-threaded program, but the other threads are all blocked on
> > something.
>
> You are describing behaviour as expected with nonblocking set. That
> suggests to me that something or someone set or inherited the nonblock
> flag on that socket. Is the strange behaviour specific to the latest
> kernel ?

Well, it looks like I have egg on my face; it is not a kernel problem.

Return value from fcntl(F_GETFL) in decimal, hex, octal:
rufus-fd: bnet.c:84 fcntl=2050 0x802 04002

Someone is setting nonblocking on my socket ! -- perhaps some thread library?  
Anyway, it is definitely not me, and this is a thread of the main program so 
I don't see inheritance as the problem. I'll track it down and send the bug 
report to the appropriate place.

Thanks for the fast response and sorry for the inconvenience.

Kern
