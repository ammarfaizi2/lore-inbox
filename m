Return-Path: <linux-kernel-owner+w=401wt.eu-S932153AbXAQJWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbXAQJWo (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 04:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbXAQJWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 04:22:44 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4194 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932153AbXAQJWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 04:22:43 -0500
Date: Wed, 17 Jan 2007 09:22:33 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix emergency reboot: call reboot notifier list if possible
Message-ID: <20070117092233.GA30197@flint.arm.linux.org.uk>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20070117091319.GA30036@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070117091319.GA30036@elte.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2007 at 10:13:19AM +0100, Ingo Molnar wrote:
> we dont call the reboot notifiers during emergency reboot mainly because 
> it could be called from atomic context and reboot notifiers are a 
> blocking notifier list. But actually the kernel is often perfectly 
> reschedulable in this stage, so we could as well process the 
> reboot_notifier_list.

My experience has been that when there has been the need to use this
facility, the kernel hasn't been reschedulable.  (If it were then I'd
use "reboot -f" instead.)

If we're going to do this, can we make the new behaviour have a different
key combination so the original way remains?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
