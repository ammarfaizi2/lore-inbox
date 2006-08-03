Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWHCGhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWHCGhx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 02:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWHCGhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 02:37:53 -0400
Received: from 1wt.eu ([62.212.114.60]:17165 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932245AbWHCGhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 02:37:52 -0400
Date: Thu, 3 Aug 2006 08:29:03 +0200
From: Willy Tarreau <w@1wt.eu>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: benjamin.cherian.kernel@gmail.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Bug with USB proc_bulk in 2.4 kernel
Message-ID: <20060803062903.GA19176@1wt.eu>
References: <mailman.1152332281.24203.linux-kernel2news@redhat.com> <200607271521.38217.benjamin.cherian.kernel@gmail.com> <20060730003527.19bec8ce.zaitcev@redhat.com> <200607311141.29600.benjamin.cherian.kernel@gmail.com> <20060802195100.GA16290@1wt.eu> <20060802180216.da6c0d1e.zaitcev@redhat.com> <20060803023352.GA18264@1wt.eu> <20060802230058.0ff73025.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060802230058.0ff73025.zaitcev@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 11:00:58PM -0700, Pete Zaitcev wrote:
> Replace the semaphore exclusive_access with an open-coded lock for
> the special use. The lock can be taken for: read, write, and both.
> This way, two bulk URBs can be submitted simultaneously with ioctl
> USBDEVFS_BULK: one read and one write. Such access was possible
> before 2.4.28.
> 
> Signed-off-By: Pete Zaitcev <zaitcev@redhat.com>
> 
> ---
> 
> The semaphore was introduced in 2.4.28 for the purpose of exclusion
> between access from device.c (cat /proc/bus/usb/devices), devio.c
> through libusb, and in-kernel driver. Currently, only usb-storage
> observes the locking protocol. The most popular device which locks
> in case of simultaneous access is TEAC CD-210PU.

Perfect. Patch queued, thanks Pete.

Willy

