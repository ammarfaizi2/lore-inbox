Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266203AbTAPKTo>; Thu, 16 Jan 2003 05:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266295AbTAPKTn>; Thu, 16 Jan 2003 05:19:43 -0500
Received: from 5-116.ctame701-1.telepar.net.br ([200.193.163.116]:35535 "EHLO
	5-116.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S266203AbTAPKTm>; Thu, 16 Jan 2003 05:19:42 -0500
Date: Thu, 16 Jan 2003 08:28:11 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Alex <akhripin@MIT.EDU>
cc: linux-kernel@vger.kernel.org
Subject: Re: Dynamic memory stack?
In-Reply-To: <20030116010454.GB3288@dodecahedron.mit.edu>
Message-ID: <Pine.LNX.4.50L.0301160825330.6044-100000@imladris.surriel.com>
References: <20030116010454.GB3288@dodecahedron.mit.edu>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2003, Alex wrote:

> bar(){
> .
> foo=kmallc
> .
> kfree(foo)

> This sort of thing is best handled on the stack,

The kernel stack is 8 kB per process.

> A way to deal with this is to create a per-cpu kmalloc'ed dynamically
> extended stack from which memory can be allocated.

That only works if this kernel thread doesn't schedule.

If you schedule, you'd end up with multiple processes
wanting to use the same pool, or with a process moving
from one pool to the other (without the ability to
take its data with it).

> Furthermore, with the help of macros, memory leaks due to mid-function
> returns and such can be completely avoided.

I'm doubtful, but if you think you know a way to pull
it off I'm curious to see it ...

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
