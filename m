Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbUCCPpu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 10:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbUCCPpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 10:45:49 -0500
Received: from gruby.cs.net.pl ([62.233.142.99]:65297 "EHLO gruby.cs.net.pl")
	by vger.kernel.org with ESMTP id S262491AbUCCPps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 10:45:48 -0500
Date: Wed, 3 Mar 2004 16:45:47 +0100
From: Jakub Bogusz <qboosh@pld-linux.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] USB_GADGET depends on USB
Message-ID: <20040303154547.GK7223@gruby.cs.net.pl>
References: <20040303135756.GH7223@gruby.cs.net.pl> <20040303152738.GH25687@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303152738.GH25687@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 07:27:40AM -0800, Greg KH wrote:
> On Wed, Mar 03, 2004 at 02:57:56PM +0100, Jakub Bogusz wrote:
> > Up to current cset it's possible to select USB_GADGET even if USB is
> > disabled (causing only compilation errors). This patch adds depends
> > rules to disallow USB_GADGET if USB is not enabled (similar to those
> > found in other drivers/usb/*/Kconfig files).
> 
> But why would you want to do that?  You can have a box with USB gadget
> support but not USB "host" support on it just fine.
> 
> This patch is not correct, nor needed.

Now I know, David Brownell already explained it to me.

It was because make (old)config) asks questions about USB_GADGET,
USB_ETH, USB_FILE_STORAGE, USB_G_SERIAL, USB_ZERO, USB_GADGETFS even on
platforms where no USB peripheral controller is available (like sparc32) -
which make no sense as none of them can be built without any
CONFIG_USB_GADGET_*.
These options could be omitted on such platforms...


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Team        http://www.pld-linux.org/
