Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbULRSmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbULRSmh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 13:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbULRSmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 13:42:37 -0500
Received: from motgate.mot.com ([129.188.136.100]:425 "EHLO motgate.mot.com")
	by vger.kernel.org with ESMTP id S261217AbULRSmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 13:42:20 -0500
Date: Sat, 18 Dec 2004 12:42:16 -0600 (CST)
From: Kumar Gala <kumar.gala@freescale.com>
X-X-Sender: galak@sysperf.somerset.sps.mot.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Kumar Gala <kumar.gala@freescale.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make gcapatch work for all bk transports
In-Reply-To: <41C36150.6050108@pobox.com>
Message-ID: <Pine.GSO.4.44.0412181239400.2707-100000@sysperf.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

I didn't even think if your case.  How about extracting out the transport
from 'bk parent -p' as a middle ground.  I dont think this will help your
case.  If not, we can leave the script as is.

- kumar

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

diff -Nru a/Documentation/BK-usage/gcapatch b/Documentation/BK-usage/gcapatch
--- a/Documentation/BK-usage/gcapatch	2004-12-18 12:39:32 -06:00
+++ b/Documentation/BK-usage/gcapatch	2004-12-18 12:39:32 -06:00
@@ -5,4 +5,4 @@
 # Usage: gcapatch > foo.patch
 #

-bk export -tpatch -hdu -r`bk repogca bk://linux.bkbits.net/linux-2.5`,+
+bk export -tpatch -hdu -r$(bk repogca $(bk parent -p|cut -d: -f1)://linux.bkbits.net/linux-2.5),+

On Fri, 17 Dec 2004, Jeff Garzik wrote:

> Kumar Gala wrote:
> > Andrew,
> >
> > Makes the gcapatch script work for any bk transport (including http).
> >
> > Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
> >
> > --
> >
> > diff -Nru a/Documentation/BK-usage/gcapatch
> b/Documentation/BK-usage/gcapatch
> > --- a/Documentation/BK-usage/gcapatch	2004-12-17 13:42:32 -06:00
> > +++ b/Documentation/BK-usage/gcapatch	2004-12-17 13:42:32 -06:00
> > @@ -5,4 +5,4 @@
> >  # Usage: gcapatch > foo.patch
> >  #
> >
> > -bk export -tpatch -hdu -r`bk repogca
> bk://linux.bkbits.net/linux-2.5`,+
> > +bk export -tpatch -hdu -r$(bk repogca $(bk parent -p)),+
>
> It's an example script, meant to be modified to suit your local tastes.
>
> Your patch isn't useful for situations (such as mine :)) where you have
> more than one level of parent, but you want to generate a patch versus
> mainline (not the parent).
>
> 	Jeff
>
>

