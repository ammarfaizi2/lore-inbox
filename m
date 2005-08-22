Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbVHVUBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbVHVUBr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVHVUBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:01:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22979 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750767AbVHVUBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:01:46 -0400
Date: Mon, 22 Aug 2005 16:01:44 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: suspicious behaviour in pcwd driver.
Message-ID: <20050822200144.GG27344@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20050822183006.GB27344@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822183006.GB27344@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2005 at 02:30:06PM -0400, Dave Jones wrote:
 > drivers/char/watchdog/pcwd.c does this if it detects
 > a temperature out of range..
 > 
 >             if (temp_panic) {
 >                 printk (KERN_INFO PFX "Temperature overheat trip!\n");
 >                 machine_power_off();
 >             }
 > 
 > Two problems here are..
 > 
 > 1. machine_power_off() isn't exported on ppc64. (patch below)

I was looking at an old tree, and this is now kernel_power_off()
so this isn't a problem for pcwd, however the export is still needed
for drivers/macintosh/therm_pm72.c

 > 2. that printk will never hit the logs, so the admin will just find
 > a powered off box with no idea what happened.
 > Should we at least sync block devices before doing the power off ?

AFAICS, this is still a problem with kernel_power_off() though ?

		Dave

