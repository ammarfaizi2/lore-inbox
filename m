Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319373AbSIFUcO>; Fri, 6 Sep 2002 16:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319376AbSIFUcO>; Fri, 6 Sep 2002 16:32:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22279 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319373AbSIFUcO>;
	Fri, 6 Sep 2002 16:32:14 -0400
Date: Fri, 6 Sep 2002 21:36:52 +0100
From: Matthew Wilcox <willy@debian.org>
To: Corey Minyard <minyard@acm.org>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Version 2 of the Linux IPMI driver
Message-ID: <20020906213652.G26580@parcelfarce.linux.theplanet.co.uk>
References: <20020906201856.F26580@parcelfarce.linux.theplanet.co.uk> <3D790F2E.1050306@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D790F2E.1050306@acm.org>; from minyard@acm.org on Fri, Sep 06, 2002 at 03:25:18PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2002 at 03:25:18PM -0500, Corey Minyard wrote:
> You access a device as a filesystem?  That's bizarre.  It's a device, 
> and they call them "devices" in the kernel for a reason.  Why would you 
> want to do this?  Especially with devfs, the whole device numbering 
> problem goes away.  You could easily make it a misc device.

The point is to get away from using character devices where we don't need
them (and we really don't need them in most places).  Plus, there's no
dependency on devfs with this approach.

> Plus, your patch misses a lot of places where IPMI is going.

Oh, I'm quite aware of the limitations of my driver.  I just don't
want to see yet another character device + ioctl interface going into
the kernel when it's really not necessary.  

> And it wasn't stupid to call your "driver" BMC.  That's exactly what it 
> is.  It's not IPMI, it's a KCS BMC interface (hooked in as a filesystem).

Right, but it should probably be addressed as /dev/ipmi since what we're
doing is sending IPMI messages.

-- 
Revolutions do not require corporate support.
