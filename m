Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264297AbUGBPFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264297AbUGBPFQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 11:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264633AbUGBPFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 11:05:16 -0400
Received: from sd291.sivit.org ([194.146.225.122]:1670 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S264297AbUGBPFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 11:05:10 -0400
Date: Fri, 2 Jul 2004 17:04:57 +0200
From: Stelian Pop <stelian@popies.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6] meye driver update (wait_ms -> msleep)
Message-ID: <20040702150456.GE2942@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <20040702140825.GD2942@crusoe.alcove-fr> <40E573DE.6090303@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40E573DE.6090303@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 10:40:30AM -0400, Jeff Garzik wrote:

> >-static inline void wait_ms(unsigned int ms) {
> >-	if (!in_interrupt()) {
> >-		set_current_state(TASK_UNINTERRUPTIBLE);
> >-		schedule_timeout(1 + ms * HZ / 1000);
> >-	}
> >-	else
> >-		mdelay(ms);
> >-}
> >-
> 
> I was worried about in_interrupt() removal (when you unconditionally 
> use msleep), so I reviewed this in-depth.  Looks OK to me.

Yup, the in_interrupt() test was reminiscent from a very old
version of the driver, and was wait_ms is not used anymore in
interrupt context, so its replacement by msleep() is safe.

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
