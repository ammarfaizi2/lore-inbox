Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVCRTRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVCRTRU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 14:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVCRTRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 14:17:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:8331 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261863AbVCRTRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 14:17:03 -0500
Date: Fri, 18 Mar 2005 11:16:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Robin Holt <holt@sgi.com>
Cc: peterc@gelato.unsw.edu.au, holt@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: vm_dirty_ratio seems a bit large.
Message-Id: <20050318111639.24b007f7.akpm@osdl.org>
In-Reply-To: <20050318123112.GA28473@lnx-holt.americas.sgi.com>
References: <20050317205213.GC17353@lnx-holt.americas.sgi.com>
	<20050317133148.1122e9c4.akpm@osdl.org>
	<16954.1107.911531.142306@wombat.chubb.wattle.id.au>
	<20050318123112.GA28473@lnx-holt.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt <holt@sgi.com> wrote:
>
> > No, you could just extend them to understand fixed point.  Keep
>  > printing integers as integers, print non-integers with one (or two:
>  > will we ever need 0.01% increments?) decimal places.
> 
>  Right now, it is possible to build our largest Altix configuration with
>  64TB of memory (unfortunatetly, we can't get any customers to pay that
>  large of bill ;).  We are currently shipping a few 4TB systems and hope
>  to be selling 20TB systems by the end of the year (at least engineering
>  hopes to).
> 
>  Given that, two decimal places are really not enough.  We probably need
>  at least 3.
> 
>  Is there any reason to not do 3 places?  Is this the right direction to
>  head or does anybody know of problems this would cause?

It's a rather unorthodox fix, but not illogical.  I guess it depends upon
how much sysctl infrastructure it adds.  Probably quite a lot.

Another approach would be to just say the ratio now has a range 0 .. 
999,999 and then, if it happens to be less than 100, treat that as a
percentage for back-compatibility reasons.  Although that's a bit kludgy
and perhaps a completely new /proc entry would be better.

