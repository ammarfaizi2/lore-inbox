Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUENTK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUENTK7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 15:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUENTK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 15:10:59 -0400
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:28835 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S262138AbUENTK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 15:10:57 -0400
Message-ID: <40A519BD.3030000@backtobasicsmgmt.com>
Date: Fri, 14 May 2004 12:10:53 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back To Basics Network Management
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Christoph Hellwig <hch@infradead.org>,
       Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
       linux-kernel@vger.kernel.org
Subject: Re: does udev support sw raid0?
References: <200405141442.38404.norberto+linux-kernel@bensa.ath.cx> <20040514183450.GA2345@kroah.com> <20040514193913.A27388@infradead.org> <20040514184659.GA2401@kroah.com>
In-Reply-To: <20040514184659.GA2401@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> How did this work with devfs then?  The device node would not be present
> before the ioctl needed to be called, right?  Or did it do the "magic
> lookup" mess and just "know" about md devices?

Right, see my recent thread on linux-hotplug-devel about this very subject.

As it stands today, the only gendisk that md registers without being 
asked to do so is md0, so /dev/md0 will always be present on a 
udev-enabled system with md. If you have auto-start MD arrays on your 
system, then those will be registered as well when md autostarts them at 
kernel boot time.

All other arrays (those that you want to start using mdadm, or those 
that you want to create because they've never existing before) suffer 
from the problem of requiring a device node before they can be controlled.

I chatted with Neil Brown about this, and he would not be opposed to the 
md driver exposing a character device specifically for the purpose of 
handling the md ioctls (like dm does), but when I looked more into it it 
seemed to be a waste of effort; the time could be better spent porting 
the md personalities over to dm, where all this stuff already works 
properly and there is naming/splitting/partitioning/etc. available.
