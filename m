Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315162AbSFXTD3>; Mon, 24 Jun 2002 15:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314938AbSFXTD2>; Mon, 24 Jun 2002 15:03:28 -0400
Received: from waste.org ([209.173.204.2]:42969 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S314885AbSFXTD1>;
	Mon, 24 Jun 2002 15:03:27 -0400
Date: Mon, 24 Jun 2002 14:03:06 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "'Roman Zippel'" <zippel@linux-m68k.org>,
       "'David Brownell'" <david-b@pacbell.net>,
       "'Nick Bellinger'" <nickb@attheoffice.org>,
       <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: RE: driverfs is not for everything! (was:  [PATCH] /proc/scsi/map 
 )
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7F56@orsmsx111.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0206241358070.9420-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2002, Grover, Andrew wrote:

> > From: Roman Zippel [mailto:zippel@linux-m68k.org]
> > On Mon, 24 Jun 2002, Grover, Andrew wrote:
> > > If a device can be accessed by multiple machines
> > concurrently, it should not
> > > be in driverfs.
> >
> > I don't think it's that easy. If the computer wakes up again,
> > devices have
> > to be reinitialised in the right order, e.g. iSCSI needs a
> > working network
> > stack and devices.
>
> Would the iSCSI device be a child of the network device? That would ensure
> that the NIC was fully restarted before the iSCSI device.

If by network device you mean NIC, the answer is no. Think redundant
routing. This problem already exists in the SCSI realm (multipathed
arrays) and there's I remember reading there's some multipath stuff in
place, but I doubt driverfs has really thought about it.

The multipath problem means our tree is really a DAG. Which may or may not
be a problem.

> > Another problem is how to properly shutdown the
> > machine. Scripts now "know" that nfs requires the network,
> > but how does
> > the script find out, that /dev/sdb2 is an iSCSI device, so that it can
> > properly unmount the device, before the network is shutdown?
>
> Would a bottom-up traversal of the device tree do things properly?

If we think in terms of DAGs instead of trees, yes.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

