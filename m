Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265638AbTFSAGz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 20:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265639AbTFSAGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 20:06:55 -0400
Received: from fed1mtao06.cox.net ([68.6.19.125]:26240 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S265638AbTFSAGx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 20:06:53 -0400
Message-ID: <3EF101E4.3030900@cox.net>
Date: Wed, 18 Jun 2003 17:20:52 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5a) Gecko/20030603
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Flaw in the driver-model implementation of attributes
References: <20030619000604.19693.qmail@email.com>
In-Reply-To: <20030619000604.19693.qmail@email.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clayton Weaver wrote:

> (Doubting that there is a sysfs faq anywhere
> yet, ...)

Sounds like we're getting there!

> 
> What is a sysfs "class", as in /sys/class/...?

It is an abstraction. It is a group of objects that implement common 
functionality, and have common attributes and behaviors.

> 
> What do sysfs classes have in common? How is
> a /sys/class/ different from a /sys/devices,
> /sys/bus, etc?

/sys/bus, /sys/block are just special-case classes that get their own 
top-level directory. They could just easily have been put under 
/sys/class/block, /sys/class/bus.

> 
> In re: the current discussion, are the "usb-storage" attributes under discussion
> something that the vfs would need to know
> about(/sys/block/)? Something that a pci
> bus would need to know about? Something that
> a usb controller would need to know about?

IMHO, no. Any attributes specific to a usb-storage device are not 
something that any other layer would care about. As an example, a 
flash-memory USB key I have here support software write protection; 
while I don't know if the usb-storage driver currently exposes that, it 
could, and that would be very specific to usb-storage. Any userspace 
application that wanted to manipulate the state of that protection would 
look at /sys/class/usb-storage/... for devices it could potentially 
manage. It doesn't need to how or where those devices are connected, or 
even what type of media they may be. It only needs to know that they are 
usb-storage devices, and that they have a "writeprotect" attribute 
exposed in the appropriate place.

