Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbUFCIjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUFCIjZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 04:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbUFCIjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 04:39:24 -0400
Received: from sd291.sivit.org ([194.146.225.122]:11469 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261851AbUFCIjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 04:39:23 -0400
Date: Thu, 3 Jun 2004 10:38:49 +0200
From: Stelian Pop <stelian@popies.net>
To: Daniel Drake <dsd@gentoo.org>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use msleep in meye driver
Message-ID: <20040603083848.GA3621@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Daniel Drake <dsd@gentoo.org>, video4linux-list@redhat.com,
	linux-kernel@vger.kernel.org
References: <40BDF8E6.6040601@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BDF8E6.6040601@gentoo.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 04:57:26PM +0100, Daniel Drake wrote:

> Remove meye's definition of wait_ms() and switch to using the new global 
> msleep() function.
[...]

> -static inline void wait_ms(unsigned int ms) {
> -	if (!in_interrupt()) {
> -		set_current_state(TASK_UNINTERRUPTIBLE);
> -		schedule_timeout(1 + ms * HZ / 1000);
> -	}
> -	else
> -		mdelay(ms);
> -}

>From what I see in kernel/timer.c, msleep() cannot be called in
interrupt context, so the in_interrupt() test must stay.

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
