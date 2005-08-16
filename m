Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965241AbVHPOMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965241AbVHPOMn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 10:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965244AbVHPOMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 10:12:42 -0400
Received: from matou.sibbald.ch ([194.158.240.20]:52015 "EHLO
	matou.sibbald.com") by vger.kernel.org with ESMTP id S965241AbVHPOMm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 10:12:42 -0400
From: Kern Sibbald <kern@sibbald.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PROBLEM: blocking read on socket repeatedly returns EAGAIN
Date: Tue, 16 Aug 2005 16:12:32 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200508161519.39719.kern@sibbald.com> <1124200991.17555.33.camel@localhost.localdomain>
In-Reply-To: <1124200991.17555.33.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508161612.32406.kern@sibbald.com>
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
> flag on that socket. 

I verified that I have not explicitly set nonblocking on the socket, so expect 
it to be default blocking. 

> Is the strange behaviour specific to the latest  kernel ?

This behavior, manifesting itself as a CPU loop, has been plaguing me for a 
number of months now.  It is not specific to the latest kernel since  it 
happened on FC3 and all kernels between.  Before FC3 I was on RHEL3 (2.4 
kernel) but am unsure if I saw the problem there, my best guess is that it is 
2.6 related, but I cannot guarantee that.

I have a workaround for the problem (sleep 200ms), but can repeat it and will 
be happy to provide more info as you request.  

The only thing I would correct in what I initially wrote is I believe that the 
other end of the socket did read some of the data I wrote before I did my 
read() expecting it to block.


Kern
