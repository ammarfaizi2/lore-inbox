Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbVIOAOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbVIOAOs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 20:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVIOAOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 20:14:48 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:21424 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S932495AbVIOAOs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 20:14:48 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=KgGplMsbN5LW1fG6Xipei+sNoQXagOC2m+Gr2L9AF/ziQcJ4zoXLCjNa5wJDzmMxQ
	GvyFc2DrlwvwJDpQHoq0g==
Date: Wed, 14 Sep 2005 17:14:29 -0700
From: David Brownell <david-b@pacbell.net>
To: vitalhome@rbcmail.ru, basicmark@yahoo.com
Subject: Re: [RFC][PATCH] SPI subsystem
Cc: linux-kernel@vger.kernel.org, dpervushin@ru.mvista.com
References: <20050910115434.32450.qmail@web30303.mail.mud.yahoo.com>
In-Reply-To: <20050910115434.32450.qmail@web30303.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050915001429.BC6E7EA55C@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >+static int spi_suspend(struct device * dev, u32 state)
> > >+{
> > >...
> > >+ list_for_each_entry(child, &dev->children, node) {

That should probably use device_for_each_child() if you're
going to do it that way ...


> > >+  if (child->driver && child->driver->suspend) {
> > >+   ret = child->driver->suspend(child, state, SUSPEND_DISABLE);
> > >+   if (ret == 0)
> > >+    ret = child->driver->suspend(child, state, SUSPEND_SAVE_STATE);
> > >+   if (ret == 0)
> > >+    ret = child->driver->suspend(child, state, SUSPEND_POWER_DOWN);
> > >+  }
> > >+ }
> > >  
> > >
> > Oh my God. It will be called 3 times for each child
> > entry, isn't it?!
>
> OK. This stuff is probably wrong. I used the platform
> subsystem as an example. I need to do more research
> into how much work the driver core does for you.

Most platform drivers I've seen just handle the power on/off
requests.  I think there's some historical reason that the
"reason" stuff exists ... but I suspect not many folk would
get unhappy if that were removed, and those calls got simplified.

- Dave

