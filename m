Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268242AbUHFTb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268242AbUHFTb0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268244AbUHFT2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:28:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15627 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268247AbUHFT1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:27:51 -0400
Date: Fri, 6 Aug 2004 20:27:47 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Hamie <hamish@travellingkiwi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cs using 100% CPU
Message-ID: <20040806202747.H13948@flint.arm.linux.org.uk>
Mail-Followup-To: Hamie <hamish@travellingkiwi.com>,
	linux-kernel@vger.kernel.org
References: <40FA4328.4060304@travellingkiwi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40FA4328.4060304@travellingkiwi.com>; from hamish@travellingkiwi.com on Sun, Jul 18, 2004 at 10:30:16AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2004 at 10:30:16AM +0100, Hamie wrote:
> Anyone know why this happens? Something busy waiting? (BUt that should 
> show as system cpu right?) or something taking out really long locks?

It'll be because IDE is using PIO to access the CF card, which could
have long access times (so reading a block of sectors could take some
time _and_ use CPU.)  Obviously, PIO requires the use of the CPU, so
the CPU can't be handed off to some other task while this is occuring.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
