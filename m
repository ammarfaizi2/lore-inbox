Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVCRCHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVCRCHB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 21:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVCRCHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 21:07:01 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:59533 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261421AbVCRCG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 21:06:58 -0500
Date: Thu, 17 Mar 2005 18:06:45 -0800
From: Jason Uhlenkott <jasonuhl@sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, holt@sgi.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] Prezeroing V8 + free_hot_zeroed_page + free_cold_zeroed page
Message-ID: <20050318020645.GC156968@dragonfly.engr.sgi.com>
References: <Pine.LNX.4.58.0503171340480.9678@schroedinger.engr.sgi.com> <20050317140831.414b73bb.akpm@osdl.org> <Pine.LNX.4.58.0503171459310.10205@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503171459310.10205@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2005 at 05:36:50PM -0800, Christoph Lameter wrote:
> +        while (avenrun[0] >= ((unsigned long)sysctl_scrub_load << FSHIFT)) {
> +		set_current_state(TASK_UNINTERRUPTIBLE);
> +		schedule_timeout(30*HZ);
> +	}

This should probably be TASK_INTERRUPTIBLE.  It'll never actually get
interrupted either way since kernel threads block all signals, but
sleeping uninterruptibly contributes to the load average.  
