Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262509AbUKLMDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbUKLMDi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 07:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbUKLMDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 07:03:38 -0500
Received: from lucidpixels.com ([66.45.37.187]:45728 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S262509AbUKLMDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 07:03:30 -0500
Date: Fri, 12 Nov 2004 07:03:28 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: Non-e1000, 2.6.9 page allocation failures with OSS/audio.
Message-ID: <Pine.LNX.4.61.0411120658490.19273@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The other page allocation failures were due to the e1000+TSO segmentation 
offload issue.

I use OSS sound drivers with 2.6.9.

Here are the options I use and have been using for quite some time without 
error:

1] <*> Open Sound System (DEPRECATED)
2] <*>   OSS sound modules
3] [*]     Verbose initialisation
4] [*]     Persistent DMA buffers
5] <*>     Crystal CS4232 based (PnP) cards

My LILO append line as is follows:
append="cs4232=0x530,5,1,0,388,5 mce video=atyfb:1600x1200-16@60"

What happened to the page allocation / memory subsystem in 2.6.9?
I do not recall getting these with 2.6.4, 2.6.5, 2.6.6, 2.6.7, 2.6.8 or 
2.6.8.1.

gaim: page allocation failure. order:4, mode:0x21
  [<c0139227>] __alloc_pages+0x247/0x3b0
  [<c01393a8>] __get_free_pages+0x18/0x40
  [<c035c7ca>] sound_alloc_dmap+0xaa/0x1b0
  [<c0364d50>] ad_mute+0x20/0x40
  [<c035cb9f>] open_dmap+0x1f/0x100
  [<c035cfe8>] DMAbuf_open+0x178/0x1d0
  [<c035a98a>] audio_open+0xba/0x280
  [<c015d8e3>] cdev_get+0x53/0xc0
  [<c0359b1c>] sound_open+0xac/0x110
  [<c0358e1e>] soundcore_open+0x1ce/0x300
  [<c0358c50>] soundcore_open+0x0/0x300
  [<c015d5a4>] chrdev_open+0x104/0x250
  [<c015d4a0>] chrdev_open+0x0/0x250
  [<c0152e02>] dentry_open+0x1d2/0x270
  [<c0152c1c>] filp_open+0x5c/0x70
  [<c0152ef5>] get_unused_fd+0x55/0xf0
  [<c0153059>] sys_open+0x49/0x90
  [<c010405b>] syscall_call+0x7/0xb
gaim: page allocation failure. order:3, mode:0x21
  [<c0139227>] __alloc_pages+0x247/0x3b0
  [<c01393a8>] __get_free_pages+0x18/0x40
  [<c035c7ca>] sound_alloc_dmap+0xaa/0x1b0
  [<c0364d50>] ad_mute+0x20/0x40
  [<c035cb9f>] open_dmap+0x1f/0x100
  [<c035cfe8>] DMAbuf_open+0x178/0x1d0
  [<c035a98a>] audio_open+0xba/0x280
  [<c015d8e3>] cdev_get+0x53/0xc0
  [<c0359b1c>] sound_open+0xac/0x110
  [<c0358e1e>] soundcore_open+0x1ce/0x300
  [<c0358c50>] soundcore_open+0x0/0x300
  [<c015d5a4>] chrdev_open+0x104/0x250
  [<c015d4a0>] chrdev_open+0x0/0x250
  [<c0152e02>] dentry_open+0x1d2/0x270
  [<c0152c1c>] filp_open+0x5c/0x70
  [<c0152ef5>] get_unused_fd+0x55/0xf0
  [<c0153059>] sys_open+0x49/0x90
  [<c010405b>] syscall_call+0x7/0xb
gaim: page allocation failure. order:4, mode:0x21
  [<c0139227>] __alloc_pages+0x247/0x3b0
  [<c01393a8>] __get_free_pages+0x18/0x40
  [<c035c7ca>] sound_alloc_dmap+0xaa/0x1b0
  [<c0364d50>] ad_mute+0x20/0x40
  [<c035cb9f>] open_dmap+0x1f/0x100
  [<c035cf2d>] DMAbuf_open+0xbd/0x1d0
  [<c035a98a>] audio_open+0xba/0x280
  [<c015d8e3>] cdev_get+0x53/0xc0
  [<c0359b1c>] sound_open+0xac/0x110
  [<c0358e1e>] soundcore_open+0x1ce/0x300
  [<c0358c50>] soundcore_open+0x0/0x300
  [<c015d5a4>] chrdev_open+0x104/0x250
  [<c015d4a0>] chrdev_open+0x0/0x250
  [<c0152e02>] dentry_open+0x1d2/0x270
  [<c0152c1c>] filp_open+0x5c/0x70
  [<c0152ef5>] get_unused_fd+0x55/0xf0
  [<c0153059>] sys_open+0x49/0x90
  [<c010405b>] syscall_call+0x7/0xb
gaim: page allocation failure. order:3, mode:0x21
  [<c0139227>] __alloc_pages+0x247/0x3b0
  [<c01393a8>] __get_free_pages+0x18/0x40
  [<c035c7ca>] sound_alloc_dmap+0xaa/0x1b0
  [<c0364d50>] ad_mute+0x20/0x40
  [<c035cb9f>] open_dmap+0x1f/0x100
  [<c035cf2d>] DMAbuf_open+0xbd/0x1d0
  [<c035a98a>] audio_open+0xba/0x280
  [<c015d8e3>] cdev_get+0x53/0xc0
  [<c0359b1c>] sound_open+0xac/0x110
  [<c0358e1e>] soundcore_open+0x1ce/0x300
  [<c0358c50>] soundcore_open+0x0/0x300
  [<c015d5a4>] chrdev_open+0x104/0x250
  [<c015d4a0>] chrdev_open+0x0/0x250
  [<c0152e02>] dentry_open+0x1d2/0x270
  [<c0152c1c>] filp_open+0x5c/0x70
  [<c0152ef5>] get_unused_fd+0x55/0xf0
  [<c0153059>] sys_open+0x49/0x90
  [<c010405b>] syscall_call+0x7/0xb
gaim: page allocation failure. order:4, mode:0x21
  [<c0139227>] __alloc_pages+0x247/0x3b0
  [<c01393a8>] __get_free_pages+0x18/0x40
  [<c035c7ca>] sound_alloc_dmap+0xaa/0x1b0
  [<c0364d50>] ad_mute+0x20/0x40
  [<c035cb9f>] open_dmap+0x1f/0x100
  [<c035cfe8>] DMAbuf_open+0x178/0x1d0
  [<c035a98a>] audio_open+0xba/0x280
  [<c0359b1c>] sound_open+0xac/0x110
  [<c0358e1e>] soundcore_open+0x1ce/0x300
  [<c0358c50>] soundcore_open+0x0/0x300
  [<c015d5a4>] chrdev_open+0x104/0x250
  [<c015d4a0>] chrdev_open+0x0/0x250
  [<c0152e02>] dentry_open+0x1d2/0x270
  [<c0152c1c>] filp_open+0x5c/0x70
  [<c0152ef5>] get_unused_fd+0x55/0xf0
  [<c0153059>] sys_open+0x49/0x90
  [<c010405b>] syscall_call+0x7/0xb
gaim: page allocation failure. order:3, mode:0x21
  [<c0139227>] __alloc_pages+0x247/0x3b0
  [<c01393a8>] __get_free_pages+0x18/0x40
  [<c035c7ca>] sound_alloc_dmap+0xaa/0x1b0
  [<c0364d50>] ad_mute+0x20/0x40
  [<c035cb9f>] open_dmap+0x1f/0x100
  [<c035cfe8>] DMAbuf_open+0x178/0x1d0
  [<c035a98a>] audio_open+0xba/0x280
  [<c0359b1c>] sound_open+0xac/0x110
  [<c0358e1e>] soundcore_open+0x1ce/0x300
  [<c0358c50>] soundcore_open+0x0/0x300
  [<c015d5a4>] chrdev_open+0x104/0x250
  [<c015d4a0>] chrdev_open+0x0/0x250
  [<c0152e02>] dentry_open+0x1d2/0x270
  [<c0152c1c>] filp_open+0x5c/0x70
  [<c0152ef5>] get_unused_fd+0x55/0xf0
  [<c0153059>] sys_open+0x49/0x90
  [<c010405b>] syscall_call+0x7/0xb
gaim: page allocation failure. order:4, mode:0x21
  [<c0139227>] __alloc_pages+0x247/0x3b0
  [<c01393a8>] __get_free_pages+0x18/0x40
  [<c035c7ca>] sound_alloc_dmap+0xaa/0x1b0
  [<c0364d50>] ad_mute+0x20/0x40
  [<c035cb9f>] open_dmap+0x1f/0x100
  [<c035cf2d>] DMAbuf_open+0xbd/0x1d0
  [<c035a98a>] audio_open+0xba/0x280
  [<c0359b1c>] sound_open+0xac/0x110
  [<c0358e1e>] soundcore_open+0x1ce/0x300
  [<c0358c50>] soundcore_open+0x0/0x300
  [<c015d5a4>] chrdev_open+0x104/0x250
  [<c015d4a0>] chrdev_open+0x0/0x250
  [<c0152e02>] dentry_open+0x1d2/0x270
  [<c0152c1c>] filp_open+0x5c/0x70
  [<c0152ef5>] get_unused_fd+0x55/0xf0
  [<c0153059>] sys_open+0x49/0x90
  [<c010405b>] syscall_call+0x7/0xb
gaim: page allocation failure. order:3, mode:0x21
  [<c0139227>] __alloc_pages+0x247/0x3b0
  [<c01393a8>] __get_free_pages+0x18/0x40
  [<c035c7ca>] sound_alloc_dmap+0xaa/0x1b0
  [<c0364d50>] ad_mute+0x20/0x40
  [<c035cb9f>] open_dmap+0x1f/0x100
  [<c035cf2d>] DMAbuf_open+0xbd/0x1d0
  [<c035a98a>] audio_open+0xba/0x280
  [<c0359b1c>] sound_open+0xac/0x110
  [<c0358e1e>] soundcore_open+0x1ce/0x300
  [<c0358c50>] soundcore_open+0x0/0x300
  [<c015d5a4>] chrdev_open+0x104/0x250
  [<c015d4a0>] chrdev_open+0x0/0x250
  [<c0152e02>] dentry_open+0x1d2/0x270
  [<c0152c1c>] filp_open+0x5c/0x70
  [<c0152ef5>] get_unused_fd+0x55/0xf0
  [<c0153059>] sys_open+0x49/0x90
  [<c010405b>] syscall_call+0x7/0xb

