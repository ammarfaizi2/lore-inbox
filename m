Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264525AbTIJEYT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 00:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbTIJEYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 00:24:19 -0400
Received: from mail.kroah.org ([65.200.24.183]:27068 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264525AbTIJEYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 00:24:16 -0400
Date: Tue, 9 Sep 2003 21:24:28 -0700
From: Greg KH <greg@kroah.com>
To: Matt Domsch <Matt_Domsch@Dell.com>
Cc: rmk@arm.linux.org.uk, Dave Jones <davej@redhat.com>,
       Anatoly Pugachev <mator@gsib.ru>, linux-kernel@vger.kernel.org
Subject: Re: Buggy PCI drivers - do not mark pci_device_id as discardable data
Message-ID: <20030910042428.GA10134@kroah.com>
References: <20030910033524.GD9760@kroah.com> <Pine.LNX.4.44.0309091752320.17200-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0309091752320.17200-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 06:12:48PM -0500, Matt Domsch wrote:
> > > agp_serverworks_probe() is marked __init.  Thus the static lookup
> > Ah, Russell just got a patch for this into the tree today.
> 
> Thanks Russell.  However, I believe your patch only fixes the
> pci_device_id tables marked __initdata, not the probe functions (or
> anything they call) being marked __init, which is what Anatoly tripped up.  
> 
> At least these have probe functions marked __init in -test5.

These either need to be marked __devinit and make "new_id" dependant on
CONFIG_HOTPLUG, or we need to remove the __init marker on these
functions.

Any throughts about which?

thanks,

greg k-h
