Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbUEAWUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUEAWUw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 18:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbUEAWUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 18:20:52 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:41099 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262425AbUEAWUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 18:20:49 -0400
Date: Sat, 1 May 2004 15:20:40 -0700
From: Chris Wedgwood <cw@f00f.org>
To: koke@amedias.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: strange delays on console logouts (tty != 1)
Message-ID: <20040501222040.GA10780@taniwha.stupidest.org>
References: <20040430195351.GA1837@amedias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040430195351.GA1837@amedias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 09:53:51PM +0200, Jorge Bernal wrote:

> On tty's != 1 it takes a long time (~20-30 secs) from logout to next
> login but on tty1 it takes a normal time.

Can you check your logs and see if getty is complaining about the tty
being already in use?

or perhaps try something like (not actually tested in this form):

   for i in `seq 1 1000` ; do \
       echo before > /dev/tty7 ; \
       strace -ttogetty-trace.$i getty 38400 tty7 linux ; \
       echo after > /dev/tty7 ; \
   done

switch to tty7 (or whatever you use, make sure nothing else like is
using it --- that means comment out of inittab) and then see if you
see delays between the 'before' and the actually logic prompt --- or
as I see in some cases the getty exist without printing anything.

If this is the case for you then I'll have a quick poke at why getty
things the tty is in use (which is what is apparently causing it
here).

Please let me know what getty (version, etc) you are using and what
distro and other relevant things as it might be a bug specific to some
distro's and not others as few people have reported this.



Thanks,

  --cw
