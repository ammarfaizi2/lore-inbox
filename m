Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbUAFMAj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 07:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbUAFMAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 07:00:38 -0500
Received: from math.ut.ee ([193.40.5.125]:37011 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261956AbUAFMAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 07:00:31 -0500
Date: Tue, 6 Jan 2004 14:00:20 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Tom Rini <trini@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: PPC & 2.6.0-test3: wrong mem size & hang on ifconfig
In-Reply-To: <20031224212022.GN4023@stop.crashing.org>
Message-ID: <Pine.GSO.4.44.0401061353370.28417-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >  			if (getprop(dev_handle, "reg", mem_info,
> > > -						sizeof(mem_info) != 8))
> > > +						sizeof(mem_info) != 8)) {

> 	if ((n = getprop(dev_handle, "reg", mem_info, sizeof(mem_info))
> 	!= 8) {

I tried it (applied it by hand and fixed parens) and it did not print n
and found the right RAM size with todays BK (2.4.24-pre3 by Makefile). I
was confused but did read the patch 3 times. Now I see it - one closing
parenthesis was in the wrong place. Seems you have fixed it in 2.4 tree
already since it's ok in BK.

So 2.4 is OK again on my Motorola Powerstack II Pro4000 (prep, no
residual, OF present). Thanks! dmesg now tells
Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
Total memory = 64MB; using 128kB for hash table (at c0240000)

2.6 probably needs the same fix (current 2.6 is not OK).

Additionally, 2.6 still has the problem with hard hang (no sysrq) when I
do ifconfig eth0 up (21140 driven by tulip or de4x5). I have heard other
people have the same problem - 21140 and 3com on powerstack and some
NIC with tulip driver on another arch (alpha?).

-- 
Meelis Roos (mroos@linux.ee)

