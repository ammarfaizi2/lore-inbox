Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272607AbTHSSE3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272602AbTHSR77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 13:59:59 -0400
Received: from mtaw6.prodigy.net ([64.164.98.56]:45028 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S270772AbTHSRvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 13:51:49 -0400
Message-ID: <3F4264BA.3020207@pacbell.net>
Date: Tue, 19 Aug 2003 10:56:10 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: jw@pegasys.ws
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Does sysfs really provides persistent hardware path to devices?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's nice.  Now add a second camera from the same vendor
> :(  No, i don't expect you to be able to uniquely identify
> identical devices being added and removed from a single USB buss
> in a persistent way.  But it would be nice if we could get
> consistency between busses so that a mouse on one USB buss
> weren't confused with a mouse on another USB buss.

Well the add/remove part is potentially an issue, depending
on how you run things.  The conventional solution, used
with other serial lines since long before UNIX, is labeling
ports according to what should be plugged in to them.

There's a usb_device->devpath field that provides a stable
topological identifier for devices within a USB bus, each id
corresponding to one of those port labels.  That field is
merged into sysfs bus_id values for USB.

It's not so nice for bus identifiers themselves, "usbN".
Though clearly there's a physical path there too, and it's
normally stable enough that PCI slot names won't change.
(Except on high end systems, where the topology may be
more stable than the bus numbers ... but we don't have
anything like usb_device->devpath for use with PCI.)

So the problem is how to munch the sysfs information into
the persistent path information you want.  It's demonstrably
doable ... though it does look to be a PITA.

- Dave

