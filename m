Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267367AbUIASoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267367AbUIASoZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 14:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267408AbUIASoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 14:44:25 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:23937 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S267367AbUIASoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 14:44:23 -0400
Date: Wed, 1 Sep 2004 11:44:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPC & 2.6.0-test3: wrong mem size & hang on ifconfig
Message-ID: <20040901184420.GE19730@smtp.west.cox.net>
References: <20040106153737.GJ2415@stop.crashing.org> <Pine.GSO.4.44.0408191346130.15736-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0408191346130.15736-100000@math.ut.ee>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 01:48:45PM +0300, Meelis Roos wrote:
> > On Tue, Jan 06, 2004 at 02:00:20PM +0200, Meelis Roos wrote:
> >
> > > > > >  			if (getprop(dev_handle, "reg", mem_info,
> > > > > > -						sizeof(mem_info) != 8))
> > > > > > +						sizeof(mem_info) != 8)) {
> > >
> > > > 	if ((n = getprop(dev_handle, "reg", mem_info, sizeof(mem_info))
> > > > 	!= 8) {
> > >
> > > I tried it (applied it by hand and fixed parens) and it did not print n
> > > and found the right RAM size with todays BK (2.4.24-pre3 by Makefile). I
> > > was confused but did read the patch 3 times. Now I see it - one closing
> > > parenthesis was in the wrong place. Seems you have fixed it in 2.4 tree
> > > already since it's ok in BK.
> > >
> > > So 2.4 is OK again on my Motorola Powerstack II Pro4000 (prep, no
> > > residual, OF present). Thanks! dmesg now tells
> > > Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
> > > Total memory = 64MB; using 128kB for hash table (at c0240000)
> > >
> > > 2.6 probably needs the same fix (current 2.6 is not OK).
> >
> > I hope to get this fixed in 2.6.2 (2.6 lacks the add OF back to PReP
> > bits, and the patch is kinda big).
> 
> Well, now that my Powerstack II boots 2.6 again, I'm missing the
> additional memory - I now have 192M and it only detects 32M :)

Hmm.  Can you change arch/ppc/boot/simple/misc-prep.c so that it will
only try to look in residual data or OF ?  I'm guessing that
mpc10x_get_mem_size() is returning 32MB.

Or does this board not have an MPC105||MPC106 ?

-- 
Tom Rini
http://gate.crashing.org/~trini/
