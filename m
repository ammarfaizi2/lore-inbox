Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbTHYVGQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 17:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbTHYVGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 17:06:15 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:53461 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262249AbTHYVGN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 17:06:13 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] Fix ide unregister vs. driver model
Date: Mon, 25 Aug 2003 23:06:14 +0200
User-Agent: KMail/1.5
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0308251358020.1157-100000@cherise>
In-Reply-To: <Pine.LNX.4.44.0308251358020.1157-100000@cherise>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308252306.14131.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, thanks.

On Monday 25 of August 2003 22:59, Patrick Mochel wrote:
> > > We have no race with the patch, that is we have no race when we wait
> > > for the semaphore after calling unregister(). We have a race if we
> > > don't as unregister() will drop a reference, but we may have pending
> > > ones from sysfs still... so if we don't wait for release() to be
> > > called, we may overwrite a struct device currently beeing used by
> > > sysfs.
> >
> > Nope, I don't think struct device can be used by sysfs after execution
> > of device_unregister() (I've checked driver model and sysfs code).
>
> It can, if the sysfs file for the device was held open while, at the same
> time, the device was unregistered. You cannot, however, obtain new
> references to the device.

