Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276670AbRJKTIF>; Thu, 11 Oct 2001 15:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276673AbRJKTH4>; Thu, 11 Oct 2001 15:07:56 -0400
Received: from hera.cwi.nl ([192.16.191.8]:42442 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S276670AbRJKTHj>;
	Thu, 11 Oct 2001 15:07:39 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 11 Oct 2001 19:07:25 GMT
Message-Id: <UTC200110111907.TAA32409.aeb@cwi.nl>
To: adilger@turbolabs.com, arvest@orphansonfire.com
Subject: Re: 2.4.11 loses sda9
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2001 at 12:08:14AM -0600, Andreas Dilger wrote:

> You probably need to go into fdisk and change the partition type of
> sda9 from "0" to "83" (or any other non-zero type).  There is a
> reason that it is saying "omitting empty partition (9)" at boot,
> and "fdisk -l" doesn't list it - because type "0" means "I don't exist".

If I am not mistaken, it is fdisk rather than the kernel that says
"omitting empty partition (9)". (And the latest fdisk no longer
deletes partitions of type 0 from its listings.)
The sys_type field never had any significance to the kernel.

Andries


[By the way, it is a sad sight to see patch-2.4.11.
Where my own sources use  dev->hardsect_size , and
intermediate sources use  get_hardsect_size(dev)
an inline function defined roughly either as
        dev->hardsect_size
or as
        hardsect_size[MAJOR(dev)][MINOR(dev)]
so as to make it easy to switch between compiles where
a kdev_t is a number and we use the infamous arrays,
and compiles where a kdev_t is a pointer to a device struct,
and no arrays exist, I now see that get_hardsect_size(dev)
is replaced by
        get_hardsect_size(to_kdev_t(bdev->bd_dev))
. Yecch.
Al, I never understood why you want to introduce a
struct block_device * to do precisely what kdev_t
was designed to do.]
