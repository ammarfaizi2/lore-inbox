Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbTIYTUo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 15:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbTIYTUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 15:20:44 -0400
Received: from traffic.dsnl.net ([213.160.215.14]:21184 "EHLO
	audrey1.deltasolutions.nl") by vger.kernel.org with ESMTP
	id S261685AbTIYTUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 15:20:42 -0400
Subject: Re: zr36120 2.6.x port (was: Re: [Mjpeg-users] DC30+ can't capture
	size greater than 224x168)
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: Pauline Middelink <middelink@polyware.nl>, linux-kernel@vger.kernel.org,
       kraxel@bytesex.org
In-Reply-To: <20030925171010.A17271@infradead.org>
References: <BAY7-F62oStVwgTlLlJ0001924a@hotmail.com>
	 <1064478814.2220.326.camel@shrek.bitfreak.net>
	 <20030925084932.GA22441@polyware.nl>
	 <1064484678.2227.465.camel@shrek.bitfreak.net>
	 <20030925102635.GA25634@polyware.nl>
	 <1064505583.2228.716.camel@shrek.bitfreak.net>
	 <20030925171010.A17271@infradead.org>
Content-Type: text/plain
Message-Id: <1064517681.2228.724.camel@shrek.bitfreak.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 25 Sep 2003 21:21:57 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2003-09-25 at 18:10, Christoph Hellwig wrote:
> On Thu, Sep 25, 2003 at 05:59:44PM +0200, Ronald Bultje wrote:
> > +	if (!try_module_get(THIS_MODULE)) {
> > +		printk(KERN_ERR "failed to acquire lock on myself\n");
> > +		return -EIO;
> > +	}
> 
> This is broken, you need an owner outside the open routine.

Eh? could you explain, please?

> > +
> > +	/* find the device */
> > +	for (i = 0; i < zoran_cards; i++) {
> > +		if (zorans[i].video_dev->minor == minor) {
> > +			ztv = &zorans[i];
> > +			break;
> > +		}
> > +	}
> 
> What serializes this?

We have an array of devices, and in order to find the right one, we go
through the array until the inode belonging to the device that's being
opened matches the one in the video device that we reigstered during
module loading. I don't know of a way to get that information in any
direct (non-loop) way, but that might be because I never cared to. I
admit it's ugly, but it's correct and used in other drivers, too.

Ronald

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>
Linux Video/Multimedia developer

