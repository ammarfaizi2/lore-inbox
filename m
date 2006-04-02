Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWDBWIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWDBWIb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 18:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWDBWIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 18:08:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62480 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932416AbWDBWIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 18:08:30 -0400
Date: Sun, 2 Apr 2006 23:08:07 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: include/asm-arm/memory.h changes break zaurus sl-5500 boot
Message-ID: <20060402220807.GD13901@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>, rpurdie@rpsys.net,
	lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>,
	kamezawa.hiroyu@jp.fujitsu.com
References: <20060402210003.GA11979@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060402210003.GA11979@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2006 at 11:00:03PM +0200, Pavel Machek wrote:
> This reverts this (and one more) patch, and fixes boot on
> collie. Without this patch, I get some fairly strange warnings about
> shift bigger than page size in pfn_to_page().

Not surprising given this gem:

> -#define arch_local_page_offset(pfn, nid) (LOCAL_MAP_NR((pfn) << PAGE_OFFSET))

PAGE_OFFSET being 3GB - that's one hell of a shift value!

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
