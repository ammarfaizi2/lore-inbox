Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267349AbUGNKUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267349AbUGNKUo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 06:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUGNKUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 06:20:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25860 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267349AbUGNKUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 06:20:42 -0400
Date: Wed, 14 Jul 2004 11:20:38 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Hugang <hugang@soulinfo.com>
Cc: linux-kernel@vger.kernel.org, bcollins@debian.org
Subject: Re: [PATCH] fix rmmod sbp2 hang in 2.6.7
Message-ID: <20040714112038.A14881@flint.arm.linux.org.uk>
Mail-Followup-To: Hugang <hugang@soulinfo.com>,
	linux-kernel@vger.kernel.org, bcollins@debian.org
References: <20040714114854.29d4e015@localhost> <20040714161357.426b5c08@localhost> <20040714171107.49aa64f7@localhost> <20040714102417.A12942@flint.arm.linux.org.uk> <20040714172957.52de0f9b@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040714172957.52de0f9b@localhost>; from hugang@soulinfo.com on Wed, Jul 14, 2004 at 05:29:57PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 05:29:57PM +0800, Hugang wrote:
> On Wed, 14 Jul 2004 10:24:17 +0100
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> | This down+up prevents drivers from being unloaded until there are no
> | references to their struct device_driver.  By removing this, you open
> | the very real possibility for an oops to occur.
> Yes, I agree with you. When sbp2 is using the module count is not zero, 
> so I can rmmod it, So I think, for sbp2 that's safe, That's true on my
> laptop.

The module count does not cover all cases, especially the case which this
semaphore protects against.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
