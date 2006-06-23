Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWFWNNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWFWNNi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWFWNNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:13:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56813 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964811AbWFWNNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:13:38 -0400
Message-ID: <449BE8F8.5020607@redhat.com>
Date: Fri, 23 Jun 2006 15:13:28 +0200
From: Milan Broz <mbroz@redhat.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Christoph Hellwig <hch@lst.de>, agk@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] dm: support ioctls on mapped devices
References: <20060621193121.GP4521@agk.surrey.redhat.com>	<20060621205206.35ecdbf8.akpm@osdl.org>	<449A51A2.4080601@redhat.com>	<20060622012957.97697208.akpm@osdl.org>	<20060622151721.GT19222@agk.surrey.redhat.com>	<20060622095551.b5c6ddce.akpm@osdl.org>	<20060623100018.GA6985@lst.de> <20060623032108.28debec2.akpm@osdl.org>
In-Reply-To: <20060623032108.28debec2.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton wrote:
> On Fri, 23 Jun 2006 12:00:18 +0200
> Christoph Hellwig <hch@lst.de> wrote:
> 
>> On Thu, Jun 22, 2006 at 09:55:51AM -0700, Andrew Morton wrote:
>>>> - long (*unlocked_ioctl) (struct file *, unsigned, unsigned long);
>>>> + long (*unlocked_ioctl) (struct inode *, struct file *, unsigned, unsigned long);
>>>>
>>>> so it can be used for block devices?
>>> Perhaps it should (have).  It's a bit nasty, but we do have at least two
>>> internal callers who don't have a file*.
>>>
>>> The alternative would be to cook up a fake file* like blkdev_get() does,
>>> but we don't want to propagate that practice.
>> Faking up the file struct is the only viable short-term option.  It
>> should be done in ioctl_by_bdev which every kernel blockdevice ioctl
>> user should use.  Long-term we should not pass a struct file but
>> a struct block_device *, but braindamage in floppy.c prevents that.
> 
> Ho hum.  The short-term will continue to be long-term.
> 
> Milan, I've lost the plot on where we stand on these patches.  I think some
> rework is needed, yes?

yes, 
we need at least create fake file.

Milan
