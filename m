Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWDSTVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWDSTVF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWDSTVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:21:05 -0400
Received: from alpha.polcom.net ([83.143.162.52]:38084 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S1751058AbWDSTVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:21:04 -0400
Date: Wed, 19 Apr 2006 21:20:56 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
In-Reply-To: <Pine.LNX.4.64.0604191111170.3701@g5.osdl.org>
Message-ID: <Pine.LNX.4.63.0604192101050.31989@alpha.polcom.net>
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org>
 <20060419200001.fe2385f4.diegocg@gmail.com> <Pine.LNX.4.64.0604191111170.3701@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2006, Linus Torvalds wrote:
> On Wed, 19 Apr 2006, Diego Calleja wrote:
>>
>> Could someone give a long high-level description of what splice() and tee()
>> are?
>
> The _really_ high-level concept is that there is now a notion of a "random
> kernel buffer" that is exposed to user space.

Suppose I am implementing hi performance HTTP (not caching) proxy that 
reads (part of?) HTTP header from A, decides where to send request from 
it, connects to the right host (B), sends (part of) HTTP header it already 
received and then wants to:

- make all further bytes from A be copied to B without using user space 
but no more than n bytes (n = request size it knows from header) or to the 
end of data (disconnect or something like that),

- make all bytes from B copied to A without using user space but no more 
than m bytes (m = response size from response header),

- stop both operations as soon as they copy enough data (assuming both 
sides are still connected) and then use sockets normally - to implement 
for example multiple requests per connection (keepalive).

Could it be done with splice() or tee() or some other kernel 
"accelerator"? Or should it be done in userspace by plain read and write?

And what if n or m is not known in advance but for example end of request 
is represented by <CR><LF><CR><LF> or something like that (common in some 
older protocols)?


Thanks in advance,

Grzegorz Kulewski

