Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263714AbUEGUB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbUEGUB4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbUEGUB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:01:56 -0400
Received: from mail.skule.net ([216.235.14.165]:49127 "EHLO mail.skule.net")
	by vger.kernel.org with ESMTP id S263718AbUEGT6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 15:58:33 -0400
Date: Fri, 7 May 2004 13:48:26 -0400
From: Mark Frazer <mark@mjfrazer.org>
To: Timothy Miller <miller@techsource.com>
Cc: Pavel Machek <pavel@ucw.cz>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       vonbrand@inf.utfsm.cl, nickpiggin@yahoo.com.au, jgarzik@pobox.com,
       brettspamacct@fastclick.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040507174826.GG30384@mjfrazer.org>
References: <20040506130846.GA241@elf.ucw.cz> <Pine.LNX.4.44.0405071652280.15067-100000@localhost.localdomain> <20040507165700.GE18175@atrey.karlin.mff.cuni.cz> <409BC7A7.4060203@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409BC7A7.4060203@techsource.com>
X-Message-Flag: Outlook not so good.
Organization: Detectable, well, not really
X-Fry-1: And then when I feel so stuffed I can't eat any more, I just use
X-Fry-2: the restroom, and then I *can* eat more!
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller <miller@techsource.com> [04/05/07 13:26]:
> >>>Perhaps what we really want is "swap_back_in" script? That way you
> >>>could do "updatedb; swap_back_in" in cron and be happy.
> >>
> >>swapoff -a; swapon -a
> >
> >
> >Good point... it will not bring back executable pages, through.
> >
> >								Pavel
> 
> Wouldn't this also be a problem if you are using more memory than you 
> have physical RAM?

#!/bin/bash
swapused=$(( $(sed -n -e 's/ \+/-/g' -e '/^Swap:/p' /proc/meminfo | cut -d'-' -f2,4) ))
bufsused=$(( $(sed -n -e 's/ \+/+/g' -e '/^Mem:/p' /proc/meminfo | cut -d'+' -f6,7) ))

if [ $bufsused -gt $(( 11 * swapused / 10 )) ]
then	swapoff -a; swapon -a
fi

or something like that
-- 
How can I live my life if I can't tell good from evil? - Fry
