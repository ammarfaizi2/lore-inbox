Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbTHYUyD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 16:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTHYUyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 16:54:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:49307 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262325AbTHYUyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 16:54:00 -0400
Date: Mon, 25 Aug 2003 13:59:11 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix ide unregister vs. driver model
In-Reply-To: <200308251317.37333.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.44.0308251358020.1157-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > We have no race with the patch, that is we have no race when we wait
> > for the semaphore after calling unregister(). We have a race if we
> > don't as unregister() will drop a reference, but we may have pending
> > ones from sysfs still... so if we don't wait for release() to be
> > called, we may overwrite a struct device currently beeing used by
> > sysfs.
> 
> Nope, I don't think struct device can be used by sysfs after execution
> of device_unregister() (I've checked driver model and sysfs code).

It can, if the sysfs file for the device was held open while, at the same
time, the device was unregistered. You cannot, however, obtain new
references to the device.


	Pat

