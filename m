Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264385AbTLKW7I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 17:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264397AbTLKW7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 17:59:08 -0500
Received: from user-12hcje4.cable.mindspring.com ([69.22.77.196]:24450 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id S264385AbTLKW7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 17:59:04 -0500
Subject: Re: udev for dummies
From: David T Hollis <dhollis@davehollis.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031211221604.GA2939@werewolf.able.es>
References: <20031211221604.GA2939@werewolf.able.es>
Content-Type: text/plain
Message-Id: <1071183521.5900.36.camel@dhollis-lnx.kpmg.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Thu, 11 Dec 2003 17:59:14 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-12-11 at 17:16, J.A. Magallon wrote:
> Hi all...
> 
> I am starting to use 2.6, and I really would like to use udev.
> But I can't find a doc about how to move from taditional heavily
> populated /dev to new method.
> 
> Any pointer ?
> 
> I have installed udev and hotplug utils, and have hotplug enabled in
> kernel.
> As I undestand it, I should do now something like
> - run udev for the first time, so it populates /udev
> - check that basic dev files are there
> - move /dev to /dev.old, and ln -s /udev /dev (or real-move it and
>   change udev.conf to write directly on /dev)
> 
> Or just create and empty /dev, and let hotplug call hotplug scripts
> on boot which in turn call udev. Is this correct ? Will hotplug call
> udev for the built-in drivers ?
> Could it also work without hotplugging, ie, can I use udev to just
> create a minimal /dev for my system ?
> 
> After installing udev, I run /sbin/udev and nothing appears on
> /udev.
> 
> What am I missing / misunderstanding ?
> 
> TIA

You may be overthinking it a bit.  I just set up udev on my box and it's
working quite well.  It's not really intending to completely replace
/dev, rather it provides a dynamic device structure based on hotplugged
devices.  When you plug in some new device (USB thing, firewire,
whatever), hotplug is run.  hotplug winds up calling udev which is able
to use it's defined rules and permissions to create a device node in
/udev (NOTE: not /dev).  These device nodes are perfectly valid for use
by anything (/dev is really just a convention.  There isn't much/any
other real significance to it).  The big win with udev is I can create
my own rules so that certain things always have a device node that I
want.  For example, I have a San Disk Cruzer USB storage device.  I
don't want that to show up as /dev/sdX (where X can vary based on other
things I have plugged in).  I tell udev to always create it's device as
/udev/cruzer.  This way I can easily have entries in fstab to mount it,
etc etc.  Ditto for my other USB storage devices.

In short, don't start deleting your /dev directory just yet!

