Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267745AbUIOWvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267745AbUIOWvu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 18:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267700AbUIOWtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:49:15 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:35807 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S267739AbUIOWs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:48:28 -0400
Date: Thu, 16 Sep 2004 00:46:43 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Greg KH <greg@kroah.com>
Cc: "Marco d'Itri" <md@Linux.IT>, "Giacomo A. Catenazzi" <cate@pixelized.ch>,
       linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
Message-ID: <20040915224643.GI15426@dualathlon.random>
References: <414757FD.5050209@pixelized.ch> <20040914213506.GA22637@kroah.com> <20040914214552.GA13879@wonderland.linux.it> <20040914215122.GA22782@kroah.com> <20040914224731.GF3365@dualathlon.random> <20040914230409.GA23474@kroah.com> <20040914232011.GG3365@dualathlon.random> <20040915161541.GD21971@kroah.com> <20040915192134.GA4197@dualathlon.random> <20040915222336.GD26591@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915222336.GD26591@kroah.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 03:23:36PM -0700, Greg KH wrote:
> generic modules.)  Which modprobe will you want to wait for?

all the ones triggered by the modprobe? It's really a matter of sync and
async. if the discovery can be synchronous, then waiting for it is
doable. It's like when you call find_pci_device, you will sure know that
you will get either a definitive answer when the function returns, this
is not the case for USB it seems.

For scsi as well after the timeout triggers you know no device is
supposed to showup (and that's why boot has to be so slow, of course we
really should wait only for the root device and to scan all hosts in
parallel, but that's quite orthogonal, the issue is to get a synchronous
answer after a definite number of operations). if we hit an async path,
then I agree it doesn't even worth to wait and we should wakeup
immediatly.

> In the meantime, the rest of us over here will be using the /etc/dev.d
> interface...

I did aruge just because you said some of us is running a spin-and-sleep
instead of the /etc/dev.d interface, which contraddicts your statement
that everyone is using /etc/dev.d, which make it quite obvious using the
dev.d is more tricky than the old way. I have scripts myself insmodding
a device and then doing some I/O on it in /etc/init.d/boot.local, mixed
with other stuff, which is quite simple and works right now.

But I do certainly agree about your point in the other email that
sync-discovery could become a thing of the past, even if so far usb and
pci hotplug has been the exception ;). So sounds like we may just go
complicated for everything.

