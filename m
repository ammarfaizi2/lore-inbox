Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131289AbRDNInk>; Sat, 14 Apr 2001 04:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131275AbRDNInV>; Sat, 14 Apr 2001 04:43:21 -0400
Received: from mo.optusnet.com.au ([203.10.68.101]:53678 "EHLO mo.mpx.com.au")
	by vger.kernel.org with ESMTP id <S131289AbRDNInI>;
	Sat, 14 Apr 2001 04:43:08 -0400
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: riel@conectiva.com.br, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: PATCH(?): linux-2.4.4-pre2: fork should run child first
In-Reply-To: <200104140758.AAA06084@adam.yggdrasil.com>
From: "Michael O'Reilly" <public@dgmo.org>
Date: 14 Apr 2001 18:42:28 +1000
In-Reply-To: "Adam J. Richter"'s message of "Sat, 14 Apr 2001 00:58:29 -0700"
Message-ID: <m1eluvna8b.fsf@mo.optusnet.com.au>
X-Mailer: Gnus v5.7/Emacs 20.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> writes:
> Rik van Riel <riel@conectiva.com.br> writes, regarding the idea
> of having do_fork() give all of the parent's remaining time slice to
> the newly created child:
> 
> >It could upset programs which use threads to handle
> >relatively IO poor things (like, waiting on disk IO in a
> >thread, like glibc does to fake async file IO).
> 
> 	Good point.

Is it really? If a program is using thread to handle IO things,
then:

a) It's not going to create a thread for every IO! So I think
the argument is suprious anyway.

b) You _still_ want the child to run first. The child
will start the I/O and block, then switching back
to the parent. This maximises the I/O thruput without
costing you any CPU. (Reasoning: The child running
2nd will increase the latency which automatically
reduces the number of ops/second you can get).

Michael.
