Return-Path: <linux-kernel-owner+w=401wt.eu-S965437AbWLPOWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965437AbWLPOWd (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 09:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965441AbWLPOWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 09:22:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41065 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965437AbWLPOWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 09:22:31 -0500
Date: Sat, 16 Dec 2006 09:18:28 -0500
From: Dave Jones <davej@redhat.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18.5 usb/sysfs bug.
Message-ID: <20061216141828.GA23368@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chuck Ebbert <76306.1226@compuserve.com>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <200612160050_MC3-1-D538-EA63@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612160050_MC3-1-D538-EA63@compuserve.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2006 at 12:47:09AM -0500, Chuck Ebbert wrote:
 > In-Reply-To: <20061215213715.GB15792@redhat.com>
 > 
 > On Fri, 15 Dec 2006 16:37:15 -0500, Dave Jones wrote:
 > 
 > > > Can you enable CONFIG_USB_DEBUG and send the log info that happens right
 > > > before this oops?
 > >
 > > Gah, and here it is, actually attached this time.
 > 
 > > BUG: unable to handle kernel NULL pointer dereference at virtual address 0000000b
 > 
 > > EIP is at sysfs_hash_and_remove+0x18/0xfd
 > 
 > That's strange.  Remove_files called sysfs_hash_and_remove()
 > with dir==0xfffffff3 (-13 decimal.)

Hmm, That's -EACCESS.  Something not checking a return code at a lower
level maybe ?

 > What is pcscd?

Some smart card daemon iirc.

 > Earlier in bootup you got this:
 > 
 > hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0004
 > uhci_hcd 0000:00:1d.0: port 2 portsc 008a,00
 > hub 1-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
 > usb 1-2: USB disconnect, address 2
 > usb 1-2: usb_disable_device nuking all URBs
 > uhci_hcd 0000:00:1d.0: shutdown urb f7ed7540 pipe 40408280 ep1in-intr
 > usb 1-2: unregistering interface 1-2:1.0
 >  usbdev1.2_ep81: ep_device_release called for usbdev1.2_ep81
 > usb 1-2:1.0: uevent
 > usb 1-2: unregistering device
 >  usbdev1.2_ep00: ep_device_release called for usbdev1.2_ep00
 > 
 > usb_remove_ep_files() is in the call trace, so this may be related?

It's odd that something disconnects during boot, as nothing gets plugged.

		Dave

-- 
http://www.codemonkey.org.uk
