Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130168AbQLBUPr>; Sat, 2 Dec 2000 15:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130196AbQLBUPh>; Sat, 2 Dec 2000 15:15:37 -0500
Received: from adsl-151-196-234-4.baltmd.adsl.bellatlantic.net ([151.196.234.4]:62043
	"EHLO vaio.greennet") by vger.kernel.org with ESMTP
	id <S130168AbQLBUPb>; Sat, 2 Dec 2000 15:15:31 -0500
Date: Sat, 2 Dec 2000 14:48:10 -0500 (EST)
From: Donald Becker <becker@scyld.com>
To: Chris Wedgwood <cw@f00f.org>
cc: Francois Romieu <romieu@cogenit.fr>, Russell King <rmk@arm.linux.org.uk>,
        Ivan Passos <lists@cyclades.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [RFC] Configuring synchronous interfaces in Linux
In-Reply-To: <20001203075958.A1121@metastasis.f00f.org>
Message-ID: <Pine.LNX.4.10.10012021412560.16980-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2000, Chris Wedgwood wrote:

> On Sat, Dec 02, 2000 at 11:09:35AM -0500, Donald Becker wrote:
> 
>     Hey, I'll make it easy.  Find an approach that fully handles only the Tulip
>     and 3c59x drivers, and that is consistent.
> 
> Actually, I starteed work on adding this to the 3c59x code last
> night; I am now a little dispondent though as it wasn't as simple as
> I first thought it might be.
> 
> I am now wondering whether it make sense to break 3c59x into smaller
> peices which hander fewer cards each; there soom to be many things
> the driver knows about which probably don't relate to my needs.

It's certainly possible to break the driver up, but it will be even more of
a problem to maintain.  Some of the complicated media selection code applies
to several generations.  Splitting the driver to have a copy for each
generation means a lot of duplicated code, which quickly leads to version
skew.

The story usually goes like this:

Someone wants to experiment with a driver.  It's always exciting to tweak
the code for the latest and greatest.  But the driver has all of this
complicated stuff for other, usually older, card/kernel versions.  So the
hacker tosses out the code, "simplifying" the driver.  They then release the
"new and improved driver".

They have no CVS tree to maintain, no old driver or hardware versions to
keep track of.  No one has been using the driver for years, and thus there
is no one screaming when their production machine stop working.  All of the
people with problems are just referred to the guy who did the original
driver, who is still expected to be there when things break.  They don't
realize they have just removed all of the excitement and motivation for they
guy who is doing all of the time consuming maintenance and testing work.

I don't mean to pick on 3Com, but the driver they released is a good
example.  It supported only a tiny set of card types that 3Com was currently
selling, and only with the current kernel.  It didn't support the previous
card types, the OEMed versions, or the older kernels.  The assumption was
that my driver would exist to support those hard cases, but by handling the
easy 90% that 3Com would get most of the credit.

Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
