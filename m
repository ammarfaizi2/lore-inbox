Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbTLEAeE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 19:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbTLEAeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 19:34:03 -0500
Received: from fep06-0.kolumbus.fi ([193.229.0.57]:27106 "EHLO
	fep06-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S263769AbTLEAeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 19:34:01 -0500
Date: Fri, 5 Dec 2003 00:33:09 +0200 (MET DST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
X-X-Sender: szaka@ua178d119.elisa.omakaista.fi
To: Rob Landley <rob@landley.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
In-Reply-To: <200312041802.52067.rob@landley.net>
Message-ID: <Pine.LNX.4.58.0312050024390.2330@ua178d119.elisa.omakaista.fi>
References: <200312041432.23907.rob@landley.net>
 <Pine.LNX.4.58.0312042300550.2330@ua178d119.elisa.omakaista.fi>
 <200312041802.52067.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Dec 2003, Rob Landley wrote:
> > Depends what you do, what fs you use. Using XFS XFS_IOC_GETBMAPX you might
> > get a huge improvement, see e.g. some numbers,
> >
> > 	http://marc.theaimsgroup.com/?l=reiserfs&m=105827549109079&w=2
> >
> > The problem is, 0 general purpose (like cp, tar, cat, etc) util supports
> > it, you have to code your app accordingly.
> 
> Okay, I'll bite.  How would one go about adding hole support to cat? :)

As I wrote above, for XFS use XFS_IOC_GETBMAPX and read only the blocks in
use from the disk and dump a preallocated buffer filled with zeros for the
holes.

For other filesytems you should use FIBMAP but it's so inefficient,
limited, etc that probably it's not worth doing because in general you
would end up being slower.

	Szaka
