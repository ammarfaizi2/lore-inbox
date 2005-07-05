Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVGEVt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVGEVt1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 17:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbVGEVrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 17:47:12 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44810 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261972AbVGEVhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 17:37:18 -0400
Date: Tue, 5 Jul 2005 22:37:14 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pawel Kolodziejski <pablo@omega.xtr.net.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: missing "platform_remove_devices" in kernel 2.6
Message-ID: <20050705223714.A15292@flint.arm.linux.org.uk>
Mail-Followup-To: Pawel Kolodziejski <pablo@omega.xtr.net.pl>,
	linux-kernel@vger.kernel.org
References: <3878.192.168.5.14.1120597493.squirrel@omega.xtr.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3878.192.168.5.14.1120597493.squirrel@omega.xtr.net.pl>; from pablo@omega.xtr.net.pl on Tue, Jul 05, 2005 at 11:04:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2005 at 11:04:53PM +0200, Pawel Kolodziejski wrote:
> I attached patch for kernel 2.6.12 which add missing
> "platform_remove_devices" function in "drivers/base/platform.c" file.

It's missing because platform_register_devices() is only intended to
be called from code areas which only registers platform devices - eg,
platform specific initialisation code.

Using platform_register_devices() from a module to register a set of
statically allocated devices is very dangerous - you should be using
platform_device_register_simple() instead.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
