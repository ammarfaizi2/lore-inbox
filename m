Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTKLG6y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 01:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbTKLG6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 01:58:54 -0500
Received: from rth.ninka.net ([216.101.162.244]:7561 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261879AbTKLG6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 01:58:53 -0500
Date: Tue, 11 Nov 2003 22:58:45 -0800
From: "David S. Miller" <davem@redhat.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: torvalds@osdl.org, dancraig@internode.on.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-bk16 ALi M5229 kernel boot error
Message-Id: <20031111225845.53d23a3a.davem@redhat.com>
In-Reply-To: <20031112043133.GD24159@parcelfarce.linux.theplanet.co.uk>
References: <1201.192.168.0.5.1068605203.squirrel@stingray.homelinux.org>
	<Pine.LNX.4.44.0311111901490.1694-100000@home.osdl.org>
	<20031112043133.GD24159@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Nov 2003 04:31:34 +0000
viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Tue, Nov 11, 2003 at 07:04:17PM -0800, Linus Torvalds wrote:
>  
> > Does this patch fix it?
> > -	if (north && north->vendor != PCI_VENDOR_ID_AL) {
> > +	if (!isa_dev) {
> 
> Wrong fix, AFAICS.  Original condition is bogus, no arguments here.
> However, the point is
> 	"tweak our southbridge only if northbridge is known to be OK with that"
> and not
> 	"tweak southbridge only if it's ours"
> 
> IOW, proper check is || of those two.

I agree with Al's analysis, and this is the kind of logic needed on
sparc64 boxes as well.

Indeed, blindly deref'ing 'isa_dev' here was pretty bogus :)
