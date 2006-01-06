Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932718AbWAFSi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932718AbWAFSi5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWAFSi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:38:56 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32267 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932718AbWAFSiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:38:55 -0500
Date: Fri, 6 Jan 2006 18:38:46 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: need for packed attribute
Message-ID: <20060106183846.GF16093@flint.arm.linux.org.uk>
Mail-Followup-To: Oliver Neukum <oliver@neukum.org>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200601061915.43961.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601061915.43961.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 07:15:43PM +0100, Oliver Neukum wrote:
> Hi,
> 
> is there any architecture for which packed is required in structures like this:
> 
> /* All standard descriptors have these 2 fields at the beginning */
> struct usb_descriptor_header {
> 	__u8  bLength;
> 	__u8  bDescriptorType;
> };

sizeof(struct usb_descriptor_header) will be 4 on ARM.  If this
concerns you, you need to pack the structure thusly:

struct usb_descriptor_header {
	__u8  bLength;
	__u8  bDescriptorType;
} __attribute__((packed));
	

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
