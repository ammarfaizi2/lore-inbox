Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbTFOPD3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 11:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbTFOPD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 11:03:29 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:21767 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262290AbTFOPD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 11:03:28 -0400
Subject: Re: New struct sock_common breaks parisc 64 bit compiles with a
	misalignment
From: James Bottomley <James.Bottomley@steeleye.com>
To: "David S. Miller" <davem@redhat.com>
Cc: acme@conectiva.com.br, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030615.073503.112613460.davem@redhat.com>
References: <1055221067.11728.14.camel@mulgrave>
	<1055657946.6481.6.camel@rth.ninka.net>
	<1055687753.10803.28.camel@mulgrave> 
	<20030615.073503.112613460.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 15 Jun 2003 10:17:10 -0500
Message-Id: <1055690231.10803.54.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-15 at 09:35, David S. Miller wrote:
> Welcome to the real world, unaligned accesses are perfectly
> legal in the networking stack.

I didn't say we couldn't do unaligned accesses, I said we have to do
them by marking the structure as potentially misaligned so the compiler
generates instructions that won't trap.

It's slightly more expensive to access the structure this way (the
compiler usually does eight byte loads instead of a double word load,
but it's still far cheaper than having an unaligned access trap).

> They are in fact guarenteed to occur when certain protocols
> are encapsulated in others.
> 
> Please add an unaligned trap handler for parisc64, thanks.

It's not necessary and would, indeed, be detrimental to operation since
we'd generate alignment traps on almost every encapsulated protocol (at
several hundred instructions per trap).  If we do this, our network
performance will tank.

As of 2.5.70, the networking layer seems to comply perfectly with the
parisc requirements (at least we don't have any misaligned access trap
panics from it), so most of the structures are correctly marked, anyway.

James


