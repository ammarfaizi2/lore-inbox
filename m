Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267334AbUGNJYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267334AbUGNJYi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 05:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267335AbUGNJYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 05:24:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16915 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267334AbUGNJYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 05:24:34 -0400
Date: Wed, 14 Jul 2004 10:24:17 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Hugang <hugang@soulinfo.com>
Cc: linux-kernel@vger.kernel.org, bcollins@debian.org
Subject: Re: [PATCH] fix rmmod sbp2 hang in 2.6.7
Message-ID: <20040714102417.A12942@flint.arm.linux.org.uk>
Mail-Followup-To: Hugang <hugang@soulinfo.com>,
	linux-kernel@vger.kernel.org, bcollins@debian.org
References: <20040714114854.29d4e015@localhost> <20040714161357.426b5c08@localhost> <20040714171107.49aa64f7@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040714171107.49aa64f7@localhost>; from hugang@soulinfo.com on Wed, Jul 14, 2004 at 05:11:07PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 05:11:07PM +0800, Hugang wrote:
> On Wed, 14 Jul 2004 16:13:57 +0800
> Hugang <hugang@soulinfo.com> wrote:
> | On Wed, 14 Jul 2004 11:48:54 +0800
> | Hugang <hugang@soulinfo.com> wrote:
> | 
> ....
> | Sorry, the above patch, can't fix rmmod sbp2 complete,I still got hang when
> | rmmod sbp2 in my PowerBook G4 sometimes.
> | 
> 
> This new patch can complete fix the bug. That's really hack. Any comment are
> welcome.

This down+up prevents drivers from being unloaded until there are no
references to their struct device_driver.  By removing this, you open
the very real possibility for an oops to occur.

If you're waiting inside that function for the last reference to be
dropped, the real question is why you still have references to it.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
