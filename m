Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVATAl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVATAl4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 19:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbVATAlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 19:41:55 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:45816 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262004AbVATAlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 19:41:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=m6pzO37QffEclp6GkFf7+wl4pKOjFQjxvtX3sLyS0lWKYMlg4S7pnGmBjiS2EJGn6+441l7ZI2t9mjajiLwb5eZYPnnwCnrqjliDkuyqt7YcAGiuLesTIOuZadNPSny8f8uiRHeUgg/KsKktSZ6YMYHOHnP5ZvHVoplxzL3cjIM=
Message-ID: <29495f1d05011916414a82da64@mail.gmail.com>
Date: Wed, 19 Jan 2005 16:41:32 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFT] skge: new syskonnect gigabit ethernet driver
Cc: Stephen Hemminger <shemminger@osdl.org>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <41EEF49F.5090504@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050119135217.38fe5f05@dxpl.pdx.osdl.net>
	 <41EEF49F.5090504@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2005 19:00:31 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> Stephen Hemminger wrote:
> > This is the second public release of my new rewrite of the SysKonnect Gigabit
> > Ethernet driver.  This 0.3 version fixes bugs with link up/down and ethtool
> > phys_id support.  It adds ethtool support for interrupt coalescing and pause
> > parameters. Performance is good, I am able to get 941 Mbit/sec receiving
> > (TCP using iperf). But obviously, the driver is still experimental.
> >
> > This driver doesn't support Yukon2 (yet), and there is report of problem
> > with D-Link card (Yukon-EC).
> >
> > The patch should work on 2.6.8 or later, I am testing with 2.6.11-rc1.
> > Also available as download from http://developer.osdl.org/shemminge/skge

<snip>

> > +static int skge_phys_id(struct net_device *dev, u32 data)
> > +{
> > +     struct skge_port *skge = netdev_priv(dev);
> > +
> > +     if(!data || data > (u32)(MAX_SCHEDULE_TIMEOUT / HZ))
> > +             data = (u32)(MAX_SCHEDULE_TIMEOUT / HZ);
> > +
> > +     /* start blinking */
> > +     skge->blink_on = 1;
> > +     mod_timer(&skge->led_blink, jiffies);
> > +
> > +     set_current_state(TASK_INTERRUPTIBLE);
> > +     schedule_timeout(data * HZ);
> > +     del_timer_sync(&skge->led_blink);

Please consider using msleep_interruptible(data * 1000) here. The same
substitution has worked in other drivers that have used the exact same
code.

Thanks,
Nish
