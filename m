Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTKLPH0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 10:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbTKLPH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 10:07:26 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:56334 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262153AbTKLPHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 10:07:24 -0500
Date: Wed, 12 Nov 2003 18:06:42 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "David S. Miller" <davem@redhat.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, torvalds@osdl.org,
       dancraig@internode.on.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-bk16 ALi M5229 kernel boot error
Message-ID: <20031112180642.A1064@jurassic.park.msu.ru>
References: <1201.192.168.0.5.1068605203.squirrel@stingray.homelinux.org> <Pine.LNX.4.44.0311111901490.1694-100000@home.osdl.org> <20031112043133.GD24159@parcelfarce.linux.theplanet.co.uk> <20031111225845.53d23a3a.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031111225845.53d23a3a.davem@redhat.com>; from davem@redhat.com on Tue, Nov 11, 2003 at 10:58:45PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11, 2003 at 10:58:45PM -0800, David S. Miller wrote:
> On Wed, 12 Nov 2003 04:31:34 +0000
> viro@parcelfarce.linux.theplanet.co.uk wrote:
> > Wrong fix, AFAICS.  Original condition is bogus, no arguments here.
> > However, the point is
> > 	"tweak our southbridge only if northbridge is known to be OK with that"
> > and not
> > 	"tweak southbridge only if it's ours"
> > 
> > IOW, proper check is || of those two.
> 
> I agree with Al's analysis, and this is the kind of logic needed on
> sparc64 boxes as well.

I'm not sure there was any logic at all, given extremely misleading
comments in the original code. That "south-bridge's enable bit" stands
for "enable input pins for 80-conductor cable detection" according
to my (rather sparse) docs, and I don't understand why the hell it has
anything to do with a northbridge.
Someone with a more complete ALi documentation ought to verify that...

> Indeed, blindly deref'ing 'isa_dev' here was pretty bogus :)

Perhaps the source of this bug was the fact that M5229 controllers
are always part of the southbridge chip and therefore respective
"isa_dev" must exist. However, PCI IDs are re-writable on newer
ALi chips, which was probably the case.

Ivan.
