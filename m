Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276702AbRJKTTh>; Thu, 11 Oct 2001 15:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276738AbRJKTT3>; Thu, 11 Oct 2001 15:19:29 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:54750 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276736AbRJKTSq>;
	Thu, 11 Oct 2001 15:18:46 -0400
Date: Thu, 11 Oct 2001 15:19:08 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: adilger@turbolabs.com, arvest@orphansonfire.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.11 loses sda9
In-Reply-To: <UTC200110111907.TAA32409.aeb@cwi.nl>
Message-ID: <Pine.GSO.4.21.0110111509340.24742-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Oct 2001 Andries.Brouwer@cwi.nl wrote:

> so as to make it easy to switch between compiles where
> a kdev_t is a number and we use the infamous arrays,
> and compiles where a kdev_t is a pointer to a device struct,
> and no arrays exist, I now see that get_hardsect_size(dev)
> is replaced by
>         get_hardsect_size(to_kdev_t(bdev->bd_dev))
> . Yecch.
> Al, I never understood why you want to introduce a
> struct block_device * to do precisely what kdev_t
> was designed to do.]
 
We had been through that way too many times.  You know what problems
with unified device struct I've brought before.  You know what
problems I have with your 64bit dev_t.  And you know _very_ well that
any patches in that area should be done in small steps.

Hell, I'd prefer that one to be done _much_ slower - with decent
debugging between the steps instead of "we've got to close the
holes opened by bdev-in-pagecache _NOW_" kind of situation we'd got.

IMO eventually we should have per-disk structure and keep reference to
it from struct block_device.  Then get_hardsect_size() wiuld turn into
access to field of that beast (and would take struct block_device *
as an argument).  But that's 2.5 stuff and I bloody refuse to participate
in attempts to do everything in one huge leap.  One we'd got is already
bad enough.

