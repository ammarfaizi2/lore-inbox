Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135927AbRDZVLH>; Thu, 26 Apr 2001 17:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135926AbRDZVKs>; Thu, 26 Apr 2001 17:10:48 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:49413 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135925AbRDZVKp>; Thu, 26 Apr 2001 17:10:45 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Can multiple device drivers *share* a PCI bridge?
Date: 26 Apr 2001 14:10:14 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9ca2rm$2sc$1@cesium.transmeta.com>
In-Reply-To: <AF6E1CA59D6AD1119C3A00A0C9893C9A04F57136@cninexchsrv01.crane.navy.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <AF6E1CA59D6AD1119C3A00A0C9893C9A04F57136@cninexchsrv01.crane.navy.mil>
By author:    Friedrich Steven E CONT CNIN <friedrich_s@crane.navy.mil>
In newsgroup: linux.dev.kernel
>
> I have 5 IP modules (Industry Pak I/O) that plug onto an IP carrier.  The
> carrier has a bridge that gets found via vendor ID/device ID, but the *sub*
> devices don't show up as distinct pci devices.  I'm using the *new*
> approach, i.e., defining a pci_device_id struct that has been initialized
> with vendirID/deviceID pairs I'm supporting.
> 
> When my module loads, the kernel calls my probe routine.  If my probe
> routine returns 0, then this pci device is essentially locked to my device
> driver.  How can I share that pci device with multiple drivers?  My current
> thoughts are to simply make a *unified* driver that supports the various IP
> modules.  That unified driver is not a general solution, but it would be ok
> for this project.  I'm curious about how to develop a general solution to
> this problem.  I believe any user of these IP modules would want to be able
> to mix-n-match IP modules at will, merely adding device drivers, not having
> a unified driver.
> 

A properly designed device should have a separate PCI function (with
its own VID/DID) for each of the subdevices.  That's what the PCI
functions are all about.  Your device is doing something nonstandard,
so you need a shim device to handle its nonstandard decoding.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
