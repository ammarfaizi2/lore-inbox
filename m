Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263306AbVFYDGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263306AbVFYDGU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 23:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbVFYDGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 23:06:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51651 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263306AbVFYDGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 23:06:16 -0400
Date: Fri, 24 Jun 2005 23:05:53 -0400
From: Bill Nottingham <notting@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [RFC] bind and unbind drivers from userspace through sysfs
Message-ID: <20050625030553.GB7380@nostromo.devel.redhat.com>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	Patrick Mochel <mochel@digitalimplant.org>
References: <20050624051229.GA24621@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050624051229.GA24621@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH (greg@kroah.com) said: 
> Even so, with these two patches, people should be able to do things that
> they have been wanting to do for a while (like take over the what driver
> to what device logic in userspace, as I know some distro installers
> really want to do.)

Playing devils advocate, with this, the process flow is:

- kernel sees a new device
- kernel sends hotplug event for bus with slot, address, vendor id, etc.
- userspace loads a module based on that info
  <some sort of synchronization here waiting for driver to initialize>
- userspace echos to sysfs to bind device
- kernel sends hotplug device event
- userspace creates device node, then continues with device

This looks:
a) inefficient
b) an awful lot like the PCMCIA model. Which... eww.

Bill
