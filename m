Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVBFASn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVBFASn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 19:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272176AbVBFARn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 19:17:43 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:9898 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265842AbVBFARO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 19:17:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=EdONkM2fQEwX1OacpPEZS+jYh2Rs83Flwyc4LfFQCsVOD4Wv37OWCdPen2iJMtMq9nwZIjlM9uGRaKp2XPCPh0k/jHmOnrwCW40+82sbPKniH5kucgWY+xJDmzZae5IxVbeHUty2gRN5j6pFoqv9ayMndnZd7qXpEggTCb66rwE=
Message-ID: <9e4733910502051617e34855b@mail.gmail.com>
Date: Sat, 5 Feb 2005 19:17:14 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [ACPI] Re: Legacy IO spaces (was Re: [RFC] Reliable video POSTing on resume)
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Pavel Machek <pavel@ucw.cz>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>
In-Reply-To: <1107643352.30270.26.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050122134205.GA9354@wsc-gmbh.de>
	 <200502041010.13220.jbarnes@engr.sgi.com>
	 <9e4733910502041459500ae8d3@mail.gmail.com>
	 <200502041534.03004.jbarnes@engr.sgi.com>
	 <9e47339105020416486cf19738@mail.gmail.com>
	 <1107643352.30270.26.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Feb 2005 09:42:32 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>  I think it could be as simple as an additional sysfs entry
> "legacy_enabled" added to all "VGA" devices in the system at the PCI
> layer level. Toggling it triggers the "untoggling" of all others,
> including VGA forwarding on bridges, and enables the path to that
> device. For in-kernel users, a pci_* API would work.
> 
> The problem I see though is that it should all be synchronous &
> spinlocked since the vgacon could want to grab at interrupt time (unless
> it's locked by userland, in which case, vgacon should cache & trigger an
> update later).

This is my current code it adds a vga entry to all VGA devices in the system.
http://kerneltrap.org/mailarchive/1/message/15974/flat

Instead of toggle there are four states:
1) off
2) on - make sure everything else is off
3) turn off all VGA devices and remember the active one
4) restore the active one

States 3 and 4 and used for running the reset program. Set state 3 to
remember the active device and turn it off, reset the card which will
enable it's VGA, disable it, set state 4 to restore the saved device.

This thread is active too:
Reliable video POSTing on resume

Restart video after resume is the same problem as posting it in the first place.

-- 
Jon Smirl
jonsmirl@gmail.com
