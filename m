Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264549AbUAFPiV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 10:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264553AbUAFPhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 10:37:47 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:37594 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S264549AbUAFPhj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 10:37:39 -0500
Date: Tue, 6 Jan 2004 08:37:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPC & 2.6.0-test3: wrong mem size & hang on ifconfig
Message-ID: <20040106153737.GJ2415@stop.crashing.org>
References: <20031224212022.GN4023@stop.crashing.org> <Pine.GSO.4.44.0401061353370.28417-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0401061353370.28417-100000@math.ut.ee>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 02:00:20PM +0200, Meelis Roos wrote:

> > > >  			if (getprop(dev_handle, "reg", mem_info,
> > > > -						sizeof(mem_info) != 8))
> > > > +						sizeof(mem_info) != 8)) {
> 
> > 	if ((n = getprop(dev_handle, "reg", mem_info, sizeof(mem_info))
> > 	!= 8) {
> 
> I tried it (applied it by hand and fixed parens) and it did not print n
> and found the right RAM size with todays BK (2.4.24-pre3 by Makefile). I
> was confused but did read the patch 3 times. Now I see it - one closing
> parenthesis was in the wrong place. Seems you have fixed it in 2.4 tree
> already since it's ok in BK.
> 
> So 2.4 is OK again on my Motorola Powerstack II Pro4000 (prep, no
> residual, OF present). Thanks! dmesg now tells
> Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
> Total memory = 64MB; using 128kB for hash table (at c0240000)
> 
> 2.6 probably needs the same fix (current 2.6 is not OK).

I hope to get this fixed in 2.6.2 (2.6 lacks the add OF back to PReP
bits, and the patch is kinda big).

> Additionally, 2.6 still has the problem with hard hang (no sysrq) when I
> do ifconfig eth0 up (21140 driven by tulip or de4x5). I have heard other
> people have the same problem - 21140 and 3com on powerstack and some
> NIC with tulip driver on another arch (alpha?).

I forget, have you tried KGDB?  I've got patches for it on PReP up at
http://stop.crashing.org:16080/~trini

-- 
Tom Rini
http://gate.crashing.org/~trini/
