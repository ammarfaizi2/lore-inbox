Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVA3Hvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVA3Hvb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 02:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVA3Hvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 02:51:31 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:3045 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261654AbVA3Hv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 02:51:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ikMuSzdWuLp8AKBp9+Wy/x2vWtFT06NfsD55U8enfRLRtGSL75dVibiw/g83OfQ/Oex+/ognM547lzIdmnGz/ydmBFeXrw53oXaPm9L45dZ08szNpSeHDTfGYsLvfcO5g/FQdEM+HW6YI7Vj4bNMdoiwXLDI3vAPceU9AIVDJPY=
Message-ID: <9e473391050129235148bd0100@mail.gmail.com>
Date: Sun, 30 Jan 2005 02:51:26 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: Fwd: Patch to control VGA bus routing and active VGA device.
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Matthew Wilcox <matthew@wil.cx>, Jesse Barnes <jbarnes@sgi.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050125042459.GA32697@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339105011719436a9e5038@mail.gmail.com>
	 <41ED3BD2.1090105@pobox.com>
	 <9e473391050122083822a7f81c@mail.gmail.com>
	 <200501240847.51208.jbarnes@sgi.com>
	 <20050124175131.GM31455@parcelfarce.linux.theplanet.co.uk>
	 <9e473391050124111767a9c6b7@mail.gmail.com>
	 <41F54FC1.6080207@pobox.com>
	 <20050124195523.B5541@flint.arm.linux.org.uk>
	 <20050125042459.GA32697@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005 20:24:59 -0800, Greg KH <greg@kroah.com> wrote:
> And yes, I agree that this needs to be done, I've been talking with a
> few other people who are interested in it.  I think the lock-rework code
> needs to be finished before it can happen properly, so that we can do
> the "unbind from one driver and give it to another one" type logic
> properly.

Unbind/give does not address what VGA control needs. VGA control needs
to track hotplug remove events so that it can route the display to
another VGA card if the active display is pulled. As far as I can tell
there is no way to monitor hotplug remove events, that's why I had to
add a callout in pci_destroy_dev().

VGA control also can't just install a device driver since that will
prevent the real DRM/FB device drivers from installing. It looks to me
like VGA control is more of a strange property of the PCI bus
architecture than a device driver.

Another strategy would be to create the concept of a PCI class driver
which a normal device driver would inherit from instead of replacing
it. But is there a need for another PCI class driver other than VGA?


-- 
Jon Smirl
jonsmirl@gmail.com
