Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbQLBD4b>; Fri, 1 Dec 2000 22:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129379AbQLBD4V>; Fri, 1 Dec 2000 22:56:21 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:7685 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129370AbQLBD4O>; Fri, 1 Dec 2000 22:56:14 -0500
Date: Fri, 1 Dec 2000 21:22:22 -0600
To: Jamie Manley <jamie@homebrewcomputing.com>
Cc: John Levon <moz@compsoc.man.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre24 and drm/agpgart static?
Message-ID: <20001201212222.D25464@wire.cadcamlab.org>
In-Reply-To: <20001129203752.A15218@homebrewcomputing.com> <Pine.LNX.4.21.0012011450270.1317-100000@mrworry.compsoc.man.ac.uk> <20001201175153.B11780@homebrewcomputing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001201175153.B11780@homebrewcomputing.com>; from jamie@homebrewcomputing.com on Fri, Dec 01, 2000 at 05:51:53PM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Jamie Manley]
> Yes, modversions was enabled.  Should that be affecting the build of
> the kernel proper?

The bug you ran into is that MODVERSIONS messes up the
'get_module_symbol' function, which is a sort of "optional dependency"
mechanism used by a few modules such as DRI (in this case: DRI needs to
be able to use the facilities of agpgart, but should also work
*without* agpgart present, since many systems have PCI video cards).

MODVERSIONS is ugly and gross for any number of reasons, but the
get_module_symbol problem is quite localized -- AGP/DRI, MTD and maybe
one or two other subsystems.  In any case it has been replaced by a
much better inter-module registration system in 2.4.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
