Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267822AbTAHSlO>; Wed, 8 Jan 2003 13:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267845AbTAHSlO>; Wed, 8 Jan 2003 13:41:14 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:64876 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S267822AbTAHSlN>;
	Wed, 8 Jan 2003 13:41:13 -0500
Date: Wed, 8 Jan 2003 19:49:51 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB CF reader reboots PC
Message-ID: <20030108184951.GA19268@win.tue.nl>
References: <20030108165130.GA1181@Master.Wizards> <20030108181645.GC3127@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108181645.GC3127@kroah.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 10:16:45AM -0800, Greg KH wrote:

> > Insert CF card. 
> > ls /dev shows sda and sda1
> > mount it. 
> > ls /dev shows sda - no sda1
> > cd to mounted CF card
> > process hangs, sd-mod & usb-storage "busy"
> > rmmod -f usb-storage or sd-mod causes PC to stop
> > (keyboard & mouse unresponsive, wmfire frozen, net disconnects)

> So if devfs is enabled, everything works just fine?

No. I have seen this kind of thing, and muttered a little bit
on earlier occasions.
The problem is that USB storage invents a GUID, that usually
is composed of vendor and product ID of the reader, possibly
also a serial number, but does not involve the card.
When the card goes away, the partitions stay, and the device
is treated as "not present".
When a new card is inserted confusion arises.

We see that when a device goes from "not present" to "present"
it may be necessary to throw out all data we have on it.
Thus, maybe it was pointless to keep this data when it went away.

This is somewhat related to the IDs discussion of a few days ago.
People invent IDs, but nobody knows of what precisely.

Andries
