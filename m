Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316309AbSHRVrM>; Sun, 18 Aug 2002 17:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316339AbSHRVrM>; Sun, 18 Aug 2002 17:47:12 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:47117 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316309AbSHRVrL>;
	Sun, 18 Aug 2002 17:47:11 -0400
Date: Sun, 18 Aug 2002 14:46:17 -0700
From: Greg KH <greg@kroah.com>
To: Adam Belay <ambx1@netscape.net>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.31 driverfs: patch for your consideration
Message-ID: <20020818214617.GB19482@kroah.com>
References: <3D5D7E50.4030307@netscape.net> <20020817030604.GB7029@kroah.com> <3D5E595A.7090106@netscape.net> <20020817190324.GA9320@kroah.com> <3D5ECEFE.4020404@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D5ECEFE.4020404@netscape.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Sun, 21 Jul 2002 20:27:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 10:32:30PM +0000, Adam Belay wrote:
> Also after looking at the interface code I realized that not just my
> code used sprintf.  Do you think they should all use snprintf instead
> or is the probability of a driver attribute exceeding the one page
> buffer size so low that it doesn't matter?

snprintf is always a good idea to be using.

> Also I was wondering if you think resource management variables (irq, 
> io, dma, etc) should live in the device structure like power management 
> variables do?

Lots of different devices do not have irq, io, and dma assigned to them
(like every USB device).  These values should be on a per-bus type (i.e.
most pci devices _do_ have those types of values.

> Global resource management seams interesting to me, although there
> already is a proc interface that does list resources, I'm wondering if
> the driver model is a good place to put such an interface?

Yes it is a good place to put them, as almost every /proc file that does
not deal with processes will eventually be moving to this fs.

thanks,

greg k-h
