Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262958AbVBFAHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbVBFAHb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 19:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272675AbVBFAHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 19:07:31 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:63072 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262958AbVBFAHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 19:07:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=VQhephHw6+OABSWHg6pVYmYu3e2es6TOsdJVxUMftkC8E5NIE9q+EgpvdEogr4v+u8nWP2alZqDeHGWaMeZhjkg+/NyPpy4jsI+FPOi7pxwlN5AMWmtbBB8AydigocuXftfICuYnf2Dw9cuRIoGaSK5UIeqdLuQY1XPjas0nr9c=
Message-ID: <9e47339105020516072b33a9c6@mail.gmail.com>
Date: Sat, 5 Feb 2005 19:07:17 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: Legacy IO spaces (was Re: [RFC] Reliable video POSTing on resume)
Cc: Pavel Machek <pavel@ucw.cz>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>
In-Reply-To: <200502041534.03004.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050122134205.GA9354@wsc-gmbh.de>
	 <200502041010.13220.jbarnes@engr.sgi.com>
	 <9e4733910502041459500ae8d3@mail.gmail.com>
	 <200502041534.03004.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After thinking about this for a while I believe the solution is for
bridges that implement a legacy space to export legacy_io/mem in
sysfs. So in the ia64 world, all bridges would export these attributes
since each bridge creates a unique legacy space.

In the x86 and I believe the ppc world, only host bridges create
legacy spaces and should have the legacy_io/mem attributes. All child
bridges should not export them.

This may be best handled by implementing bridge drivers. In my case I
need these:

Host needs to export a legacy io/mem space
8086:2578 - Host bridge: Intel Corp. 82875P/E7210 Memory Controller Hub

Child bridges do not export legacy space but implement VGA routing
8086:2579 - PCI bridge: Intel Corp. 82875P Processor to AGP Controller
8086:244e - PCI bridge: Intel Corp. 82801 PCI Bridge

I also have this..
8086:24d0 - ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Interface Bridge
But this is implementing the devices in the legacy space, it's the
host bridge that is creating the space.

Some questions...
1) Does the IA64 have child bridges that don't implement legacy space?
If so then they need to support VGA routing. What about Cardbus?
2) Does an IA64 bridge supporting different legacy spaces alter the
VGA io request to remove the offset and then send it out onto the bus?
3) How does all of this work with Opteron and Hypertransport?


-- 
Jon Smirl
jonsmirl@gmail.com
