Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbTFIW16 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 18:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbTFIW16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 18:27:58 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:59031 "EHLO
	alpha.stev.org") by vger.kernel.org with ESMTP id S262223AbTFIW14
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 18:27:56 -0400
Date: Tue, 10 Jun 2003 00:45:15 +0100 (BST)
From: James Stevenson <james@stev.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
cc: David Schwartz <davids@webmaster.com>, <linux-kernel@vger.kernel.org>
Subject: Re: select for UNIX sockets?
In-Reply-To: <m3znkr41bd.fsf@defiant.pm.waw.pl>
Message-ID: <Pine.LNX.4.44.0306100040060.1718-100000@jlap.stev.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Jun 2003, Krzysztof Halasa wrote:
> "David Schwartz" <davids@webmaster.com> writes:
> 
> > 	It really doesn't matter. UDP applications have to control the transmit
> > pacing at application level. There is absolutely no way for the kernel to
> > know whether the path to the recipient is congested or not.
> 
> Because what? The kernel knows everything it has to know - i.e. complete
> state of socket queue in question.

yes it does when you call select

take a probgram thats sharing the same cosket between 2 processes
or a multithreaded program sharing any socket from the time
that select is called and read / write is called the data
or buffer form the socket could have been completly filled or completly 
emptyed.
 
> But if select() on sockets is illegal, should we make it return -Esth
> instead of success. Certainly, we should get rid of invalid kernel code,
> right?

nobody said it was illegla but in certin situations it
might as well count as a nop;
 
> > 	The kernel can't tell you when to send because that depends upon
> > factors
> > that are remote.
> 
> Such as?

if you are on a udp socket say you have host a host b and host c
host a and host b are on the same network host c is on another networked
connected by 512kbit link (faster / slower) and you are calling select on
host a. host b blast a silly amount of data to host c
host a does the same. What happen ? who wins ?

> > 	Yes, it would be nice of the kernel helped more. But the application
> > has to
> > deal with remote packet loss as well.
> 
> Could you please show me a place in the kernel which could cause such
> a loss on local datagram sockets?
> 

Same as a multithreaded program select could say its ok to write when you
write data it could be a completly different story


