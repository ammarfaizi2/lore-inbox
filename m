Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965198AbVJEOq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbVJEOq6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 10:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965193AbVJEOqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 10:46:38 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:30132 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S965185AbVJEOqC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 10:46:02 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=emMYxNH2DVFfp/J3Zrcvw/HO8wRf3v775lstcEG6Lrsv7Tl8p0t0dF/9HwOYk5934
	ycUIdfVPybhuRayheOywg==
Date: Wed, 05 Oct 2005 07:45:46 -0700
From: David Brownell <david-b@pacbell.net>
To: vwool@ru.mvista.com, ambx1@neo.rr.com
Subject: Re: [PATCH/RFC 1/2] simple SPI framework
Cc: stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       pavel@ucw.cz, linux-kernel@vger.kernel.org, dpervushin@gmail.com,
       basicmark@yahoo.com
References: <20051004180241.0EAA5EE8D1@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
 <4343898D.1060904@ru.mvista.com> <20051005093011.GC14734@neo.rr.com>
In-Reply-To: <20051005093011.GC14734@neo.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20051005144546.A701EEB3BE@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >+ * NOTE:  the suspend() method for an spi_master controller driver
> > >+ * should verify that all its child devices are marked as suspended;
> > >+ * suspend requests delivered through sysfs power/state files don't
> > >+ * enforce such constraints.
>
> But we should, right?  It seems like a child device should never be in a
> higher suspend state than its parents.  The rule doesn't have to hold with
> driver-initiated runtime power management, but when the user requests a
> suspend via power/state, it's reasonable to assume every child should
> be suspended first.

Adam ... that's a glitch in the (lack of) Runtime PM support.  I tend
to agree that the kernel should enforce that, but it's an issue that
EVERY device has right now, not just SPI devices.  (And it only affects
users of /sys/devices/.../power/state files, not /sys/power/state, so
the impact is low.)

Plus as has recently been brought up on the PM list, I suspect that the
"pm core" should just ignore all notions of state and leave that up to
driver code that's actually in a position to do something sane with the
relevant sorts of hardare and/or driver state.

That is, the PM core basically can't know ANYTHING real about how the
hardware acts.  Heck, it doesn't even understand that a PCI device in
state PCI_D2 can go to PCI_D3hot without needing to be resumed first.

- Dave
