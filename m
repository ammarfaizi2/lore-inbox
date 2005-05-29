Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVE2SVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVE2SVo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 14:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVE2SVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 14:21:44 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:60979 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261386AbVE2SUp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 14:20:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qZH6xadKhtmWXrBlZDzNLP7Vf/i1NzmzY4sjRyUR+ou8/6usrHSGTfMRl0oopLcU5u/LpCj51XfwFlNGFB8jk268UCaZlL17MbG4VJATIvdBdFccD3PQcullgehQ9JPYIco9csSdj4yWKSsdRG0dbk+d01noAHqplII6xlzZe3M=
Message-ID: <84144f0205052911202863ecd5@mail.gmail.com>
Date: Sun, 29 May 2005 21:20:45 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PROBLEM] Machine Freezes while Running Crossover Office
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1117291619.9665.6.camel@localhost>
	 <Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sat, 28 May 2005, Pekka Enberg wrote:
> > I did a binary search and found out that 2.6.10-bk10 introduced this
> > bug. The kernel includes Linus' changes for pipes to use circular buffers.
> > A oprofile run shows that kernel is spending lots of time in poll_pipe. I
> > also have Alt-Sysrq-P traces that indicate to the same direction. I have
> > included vmstat, Alt-SysRq-P, and oprofile traces in this mail (see below
> > for section X.).

On 5/29/05, Linus Torvalds <torvalds@osdl.org> wrote:
> Can you try to see if you can get an "strace" snippet of X (or the window
> manager) when this happens, since it seems to reproducible by you..
> 
> Also, I actually find it very surprising that you see X doing anything
> _at_all_ with a pipe, since all the X connections should be just normal
> sockets. There are no pipes involved anywhere afaik.
> 
> Your description sounds exactly like X is busy processing some slow
> operation (or possibly the window manager, but I think virtual console
> switches happen without the WM being involved). The most common such slow
> operation is a new font being generated, but I don't see why that would
> have anything to do with pipes either...

Looking at output of lsof, I can see that Crossover is using pipes. I
am not very familiar with wine internals but there seems to be two
processes, wine_preloader and wine, that talk to each other through
pipes. Unfortunately, stracing either one of the processes masks the
problem. That is, I cannot reproduce the hang while doing strace.

                                 Pekka
