Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbVFJDzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbVFJDzH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 23:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbVFJDzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 23:55:07 -0400
Received: from magic.adaptec.com ([216.52.22.17]:38366 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S262453AbVFJDyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 23:54:33 -0400
Date: Fri, 10 Jun 2005 09:36:09 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
To: "Richard B. Johnson" <linux-os@analogic.com>
cc: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>,
       Peter Staubach <staubach@redhat.com>, <linux-kernel@vger.kernel.org>,
       <linux-arm-kernel@lists.arm.linux.org.uk>
Subject: Re: Zeroed pages returned for heap
In-Reply-To: <Pine.LNX.4.53.0506090605190.8306@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0506100931490.19027-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Jun 2005 03:54:03.0174 (UTC) FILETIME=[0A9CCC60:01C56D70]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2005, Richard B. Johnson wrote:

> On Wed, 8 Jun 2005, Nagendra Singh Tomar wrote:
> 
> The user code can't assume anything about any memory allocated
> by malloc(). The first time a buffer is allocated, it may be
> zero-filled because of the zeroed pages allocated by the kernel
> when the new break address is set. After that, all bets are off
> because once you free a buffer and allocate another one, it
> will probably contain data from malloc()'s previous allocation.
> 
> Even the very first time malloc() returns a pointer, doesn't
> guarantee that the memory will all be cleared. This is because
> many malloc()s use just-obtained memory (via brk) to do some
> house-keeping which may result in some "strange" numbers in
> the memory at some places.
> 
> It is extremely bad coding practice to assume a buffer is
> zero filled when writing user-mode code. That's why we have
> calloc().

My original question was for glibc (as an application) assuming that 
memory it gets from brk()/MAP_ANON is zero filled, and _not_ for an 
application calling malloc() assuming that. glibc does assume that brk() 
memory is zero filled thats why the glibc calloc() implementation does 
_not_ zero it again in user space (Ulrich conformed this). This is what 
was disturbing to me as I  was trying to disable zero-filling for brk() 
pages and to my unpleasant  surprise few applications like gcc/awk were 
breaking. 

Thanx,
Tomar

-- You have moved the mouse. Windows must be restarted for the 
   changes to take effect.

