Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbTHYUuL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 16:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbTHYUuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 16:50:11 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:40913 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262175AbTHYUuH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 16:50:07 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Fix ide unregister vs. driver model
Date: Mon, 25 Aug 2003 22:50:27 +0200
User-Agent: KMail/1.5
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1061730317.31688.10.camel@gaston> <200308250023.39596.bzolnier@elka.pw.edu.pl> <1061793253.779.27.camel@gaston>
In-Reply-To: <1061793253.779.27.camel@gaston>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308251317.37333.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 of August 2003 08:34, Benjamin Herrenschmidt wrote:
> On Mon, 2003-08-25 at 00:23, Bartlomiej Zolnierkiewicz wrote:
> > On Sunday 24 of August 2003 15:05, Benjamin Herrenschmidt wrote:
> > > Hi Bart !
> >
> > Hi,
> >
> > > This patch seem to have been lost, so here it is again. It fixes
> > > an Ooops on unregistering hwifs due to the device model now having
> > > mandatory release() functions. It also close the possible race we
> > > had on release if the entry was in use (by or /sys typically) by
> > > using a semaphore waiting for the release() to be called after
> > > doing an unregister.
> >
> > I can't see the race - all references to struct device should be dropped
> > by driver model before finally calling ->release() function...
>
> We have no race with the patch, that is we have no race when we wait
> for the semaphore after calling unregister(). We have a race if we
> don't as unregister() will drop a reference, but we may have pending
> ones from sysfs still... so if we don't wait for release() to be
> called, we may overwrite a struct device currently beeing used by
> sysfs.

Nope, I don't think struct device can be used by sysfs after execution
of device_unregister() (I've checked driver model and sysfs code).

--bartlomiej

