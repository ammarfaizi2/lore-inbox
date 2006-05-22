Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWEVSir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWEVSir (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 14:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWEVSir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 14:38:47 -0400
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:46341 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751026AbWEVSiq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 14:38:46 -0400
Date: Mon, 22 May 2006 20:38:46 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Dave Jones <davej@redhat.com>, Laurence Vanek <lvanek@charter.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: Kernel 2.6.16-1.2122_FC5 & lmsensors
Message-Id: <20060522203846.1142e34c.khali@linux-fr.org>
In-Reply-To: <20060522174818.GA8016@redhat.com>
References: <4471F028.4090803@charter.net>
	<20060522174818.GA8016@redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, May 22, 2006 at 12:08:56PM -0500, Laurence Vanek wrote:
>  > Upon updating to the latest kernel (2.6.16-1.2122_FC5) & rebooting I 
>  > find that I no longer have lmsensors.  /var/log/messages gives this in 
>  > the suspect area:
>  > 
>  > ==========
>  > May 22 11:42:42 localhost kernel: i2c_adapter i2c-0: SMBus Quick command 
>  > not supported, can't probe for chips
>  > May 22 11:42:42 localhost kernel: i2c_adapter i2c-1: SMBus Quick command 
>  > not supported, can't probe for chips
>  > May 22 11:42:42 localhost kernel: i2c_adapter i2c-2: SMBus Quick command 
>  > not supported, can't probe for chips
>  > =========
>  > 
>  > something new in this release?
> 
> Probably a side-effect of [PATCH] smbus unhiding kills thermal management
> merged in 2.6.16.17.  Is this an ASUS board ?

The fact that lm_sensors disappeared could indeed be caused by this
patch if the system is based on one of the affected boards (which are
NOT only Asus board, despite of some comments in the code). I _did_
expect people to complain... There's nothing we can do for now though.

The error messages are definitely not related though. I suspect that
they were already there before, or this is just a coincidence.

What does the following command return?
cat /sys/class/i2c-adapter/i2c-*/device/name

(Or even better "i2cdetect -l" if you have that installed.)

I'd guess that i2c-0, i2c-1 and i2c-2 are from either a framebuffer
driver or a tv card driver. Anything like that on this system? Probably
the eeprom driver (if you load it as I presume) is trying to probe
these busses and they don't want to be probed.

-- 
Jean Delvare
