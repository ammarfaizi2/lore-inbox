Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWHKHzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWHKHzX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 03:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWHKHzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 03:55:23 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:22727 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750759AbWHKHzW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 03:55:22 -0400
Message-ID: <44DC3726.1070303@aitel.hist.no>
Date: Fri, 11 Aug 2006 09:52:06 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Edgar Toernig <froese@gmx.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chase Venters <chase.venters@clientec.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org, viro@zeniv.linux.org.uk, tytso@mit.edu,
       tigran@veritas.com
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>	<20060805122936.GC5417@ucw.cz>	<20060807101745.61f21826.froese@gmx.de>	<84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com>	<20060807224144.3bb64ac4.froese@gmx.de>	<Pine.LNX.4.64.0608071720510.29055@turbotaz.ourhouse>	<1155039338.5729.21.camel@localhost.localdomain>	<20060809104159.1f1737d3.froese@gmx.de>	<1155119999.5729.141.camel@localhost.localdomain> <20060809200010.2404895a.froese@gmx.de>
In-Reply-To: <20060809200010.2404895a.froese@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edgar Toernig wrote:
[...]
> I wasn't aware of that (and I would definitely prefer a different behaviour).
>
> But anyway, correct me if I'm wrong, revoke (V2) not simply removes the
> pages from the mmaped area as truncating does (the vma stays);  revoke
> seems to completely remove the vma which is clearly a security bug.
> Future mappings may silently get mapped into the area of the revoked
> file without the app noticing it.  It may then hand out data of the new
> file still thinking it's sending the old one.
>   
One could remap to /dev/null - the file would then be free to be
umounted, but the app could get confused. Or map inaccessible
pages, so the app segfault on the next access.

Helge Hafting
