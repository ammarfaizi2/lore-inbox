Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289256AbSAGQSu>; Mon, 7 Jan 2002 11:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289249AbSAGQSm>; Mon, 7 Jan 2002 11:18:42 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:26913 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S289248AbSAGQSa>; Mon, 7 Jan 2002 11:18:30 -0500
Date: Mon, 7 Jan 2002 16:20:37 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Benjamin LaHaise <bcrl@redhat.com>, Gerrit Huizenga <gerrit@us.ibm.com>,
        "M. Edward Borasky" <znmeb@aracnet.com>,
        Harald Holzer <harald.holzer@eunet.at>, linux-kernel@vger.kernel.org
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
In-Reply-To: <E16NFxv-0005e4-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0201071600230.1147-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002, Alan Cox wrote:
> 
> You don't neccessarily need PSE. Migrating to an option to support > 4K
> _virtual_ page size is more flexible for x86, although it would need 
> glibc getpagesize() fixing I think, and might mean a few apps wouldnt
> run in that configuration.

Larger kernel PAGE_SIZE can work, still presenting 4KB page size to user
space for compat.  The interesting part is holding anon pages together,
not fragmenting to use PAGE_SIZE for each MMUPAGE_SIZE of user space.

I have patches against 2.4.6 and 2.4.7 which did that; but didn't keep
them up to date because there's a fair effort going through drivers
deciding which PAGE_s need to be MMUPAGE_s.  I intend to resurrect
that work against 2.5 later on (or sooner if there's interest).

Hugh

