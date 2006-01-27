Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbWA0RuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWA0RuS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 12:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWA0RuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 12:50:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59872 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750915AbWA0RuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 12:50:17 -0500
Date: Fri, 27 Jan 2006 09:49:47 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: reuben-lkml@reub.net, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, zaitcev@redhat.com
Subject: Re: 2.6.16-rc1-mm3
Message-Id: <20060127094947.7439935d.zaitcev@redhat.com>
In-Reply-To: <20060127172720.GB13320@kroah.com>
References: <20060124232406.50abccd1.akpm@osdl.org>
	<43D7567E.60003@reub.net>
	<20060126053941.GA13361@kroah.com>
	<43DA161C.1070404@reub.net>
	<20060127172720.GB13320@kroah.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2006 09:27:20 -0800, Greg KH <greg@kroah.com> wrote:

> How about just disabling USB legacy support in the bios completly?
> Unless you have a USB keyboard that you need for a bootloader screen or
> BIOS configuration, that's the recommended setting (due to all of the
> horrible BIOS USB bugs we have seen over the years.)

I disagree with the "unless". Just disable it, period. Most of the time,
disabling "USB Legacy Support" leaves the bootloader fully operational.
I always recommend it as the first course of action in cases like this one.

This setting was used to set two things:
 - INT 11h delivering characters to the bootloader
 - Emulation of port 0x60
However, most decent BIOS vendors figured that the first was bogus.
They only use this setting to disable the port emulation.

BTW, the BIOS often has its finger in the bus sharing between EHCI and
its companion, there's never anything we can do about it. It is always
a BIOS update that fixes it. But it sure produces lots of false
regressions when our previous mode of operation worked by accident.

-- Pete
