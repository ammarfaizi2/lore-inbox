Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbVKEGF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVKEGF6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 01:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVKEGF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 01:05:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49317 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751238AbVKEGF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 01:05:57 -0500
Date: Fri, 4 Nov 2005 22:05:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] kconfig: fix restart for choice symbols
Message-Id: <20051104220547.2e5686dc.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0511031606240.2497@scrub.home>
References: <Pine.LNX.4.61.0511031606240.2497@scrub.home>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> wrote:
>
> 
> The restart check whether new symbols became visible, didn't always work 
> for choice symbols.
> 
> ...
> --- linux-2.6.orig/scripts/kconfig/conf.c	2005-11-03 13:19:34.000000000 +0100
> +++ linux-2.6/scripts/kconfig/conf.c	2005-11-03 13:22:59.000000000 +0100
> @@ -468,7 +468,8 @@ static void check_conf(struct menu *menu
>  
>  	sym = menu->sym;
>  	if (sym) {
> -		if (sym_is_changable(sym) && !sym_has_value(sym)) {
> +		if ((sym_is_changable(sym) || sym_is_choice(sym)) &&
> +		    !sym_has_value(sym)) {
>  			if (!conf_cnt++)
>  				printf(_("*\n* Restart config...\n*\n"));
>  			rootEntry = menu_get_parent_menu(menu);

This makes `make allmodconfig' go into an infinite loop.


USB Gadget Drivers
  Gadget Zero (DEVELOPMENT) (USB_ZERO) [M/n/?] m
  Ethernet Gadget (with CDC Ethernet support) (USB_ETH) [M/n/?] m
    RNDIS support (EXPERIMENTAL) (USB_ETH_RNDIS) [Y/n/?] y
  Gadget Filesystem (EXPERIMENTAL) (USB_GADGETFS) [M/n/?] m
  File-backed Storage Gadget (USB_FILE_STORAGE) [M/n/?] m
    File-backed Storage Gadget testing version (USB_FILE_STORAGE_TEST) [Y/n/?] y
  Serial Gadget (with CDC ACM support) (USB_G_SERIAL) [M/n/?] m
*
* Restart config...
*
*
* USB Gadget Support
*
Support for USB Gadgets (USB_GADGET) [M/n/y/?] m
  Debugging information files (USB_GADGET_DEBUG_FILES) [Y/n/?] y
USB Peripheral Controller
> 1. NetChip 2280 (USB_GADGET_NET2280)
  2. Toshiba TC86C001 'Goku-S' (USB_GADGET_GOKU) (NEW)
  3. Dummy HCD (DEVELOPMENT) (USB_GADGET_DUMMY_HCD) (NEW)
choice[1-3?]: 1
USB Gadget Drivers
  Gadget Zero (DEVELOPMENT) (USB_ZERO) [M/n/?] m
  Ethernet Gadget (with CDC Ethernet support) (USB_ETH) [M/n/?] m
    RNDIS support (EXPERIMENTAL) (USB_ETH_RNDIS) [Y/n/?] y
  Gadget Filesystem (EXPERIMENTAL) (USB_GADGETFS) [M/n/?] m
  File-backed Storage Gadget (USB_FILE_STORAGE) [M/n/?] m
    File-backed Storage Gadget testing version (USB_FILE_STORAGE_TEST) [Y/n/?] y
  Serial Gadget (with CDC ACM support) (USB_G_SERIAL) [M/n/?] m
*
* Restart config...
*
*
* USB Gadget Support
*
Support for USB Gadgets (USB_GADGET) [M/n/y/?] m
  Debugging information files (USB_GADGET_DEBUG_FILES) [Y/n/?] y
USB Peripheral Controller
> 1. NetChip 2280 (USB_GADGET_NET2280)
  2. Toshiba TC86C001 'Goku-S' (USB_GADGET_GOKU) (NEW)
  3. Dummy HCD (DEVELOPMENT) (USB_GADGET_DUMMY_HCD) (NEW)
choice[1-3?]: 1
USB Gadget Drivers
  Gadget Zero (DEVELOPMENT) (USB_ZERO) [M/n/?] m
  Ethernet Gadget (with CDC Ethernet support) (USB_ETH) [M/n/?] m
    RNDIS support (EXPERIMENTAL) (USB_ETH_RNDIS) [Y/n/?] y
  Gadget Filesystem (EXPERIMENTAL) (USB_GADGETFS) [M/n/?] m
  File-backed Storage Gadget (USB_FILE_STORAGE) [M/n/?] m
    File-backed Storage Gadget testing version (USB_FILE_STORAGE_TEST) [Y/n/?] y
  Serial Gadget (with CDC ACM support) (USB_G_SERIAL) [M/n/?] m
*
* Restart config...
*
*
* USB Gadget Support
*
Support for USB Gadgets (USB_GADGET) [M/n/y/?] m
  Debugging information files (USB_GADGET_DEBUG_FILES) [Y/n/?] y
USB Peripheral Controller
> 1. NetChip 2280 (USB_GADGET_NET2280)
  2. Toshiba TC86C001 'Goku-S' (USB_GADGET_GOKU) (NEW)
  3. Dummy HCD (DEVELOPMENT) (USB_GADGET_DUMMY_HCD) (NEW)
choice[1-3?]: 1
USB Gadget Drivers
  Gadget Zero (DEVELOPMENT) (USB_ZERO) [M/n/?] m
  Ethernet Gadget (with CDC Ethernet support) (USB_ETH) [M/n/?] m
    RNDIS support (EXPERIMENTAL) (USB_ETH_RNDIS) [Y/n/?] y
  Gadget Filesystem (EXPERIMENTAL) (USB_GADGETFS) [M/n/?] m
  File-backed Storage Gadget (USB_FILE_STORAGE) [M/n/?] m
    File-backed Storage Gadget testing version (USB_FILE_STORAGE_TEST) [Y/n/?] y
  Serial Gadget (with CDC ACM support) (USB_G_SERIAL) [M/n/?] m
