Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262591AbVHDQEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbVHDQEU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 12:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbVHDQDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 12:03:47 -0400
Received: from barclay.balt.net ([195.14.162.78]:61110 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S262585AbVHDQCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 12:02:17 -0400
Subject: Re: [PATCH] Remove suspend() calls from shutdown path
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
Reply-To: zilvinas@gemtek.lt
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1123168844.30257.64.camel@gaston>
References: <1123148187.30257.55.camel@gaston>
	 <20050804121604.GA4659@gemtek.lt>  <1123168844.30257.64.camel@gaston>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 19:02:09 +0300
Message-Id: <1123171329.9251.4.camel@swoop.gemtek.lt>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-04 at 17:20 +0200, Benjamin Herrenschmidt wrote:
> On Thu, 2005-08-04 at 15:16 +0300, Zilvinas Valinskas wrote:
> > Hello Ben, Andrew, 
> > 
> > This patch helps me if I disconnect all USB peripherals before shutting
> > down notebook. With connected peripherals (USB mouse, PL2303
> > USB<->serial converter/port) - powering off process stops right after
> > unmounting filesystems but before hda power off ... 
> > 
> > There is a bug report for this too:
> > http://bugzilla.kernel.org/show_bug.cgi?id=4992
> 
> This is unclear.
> 
> I would expect the behaviour you report to happen _without_ this patch,
> that is with current git tree, and I would expect this patch to fix it
> by reverting to the previous 2.6.12 behaviour...
> 
> Ben.

Sys-rq - T: shows device_suspend() is called, perhaps that explains. It
seems that any attempt to suspend either USB hub or device connected to
it results in freeze. :\ Just guessing. 

Anything else should I try ?


hcd_submit_urb
wait_for_completion
default_wake_function
usb_start_wait_urb
timeout_kill
usb_internal_control_msg
usb_control_msg
hub_port_suspend
__usb_suspend_device
locktree
usb_suspend_device
__link_walk_path
device_suspend   <----- still called ?
ohci_reboot
generic_ide_ioctl
activate_task
__group_send_sig_info
sys_kill
block_ioctl
block_ioctl
do_ioctl
vfs_ioctl
get_name
sys_ioctl
sys_enter_esp

