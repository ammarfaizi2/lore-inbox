Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbVCJE3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbVCJE3x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 23:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVCIXMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:12:53 -0500
Received: from fire.osdl.org ([65.172.181.4]:38887 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261652AbVCIWpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:45:33 -0500
Date: Wed, 9 Mar 2005 14:44:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Direct io on block device has performance regression on 2.6.x
 kernel
Message-Id: <20050309144458.2cbc554e.akpm@osdl.org>
In-Reply-To: <200503092159.j29LxIg26267@unix-os.sc.intel.com>
References: <20050309120458.7c25f5e3.akpm@osdl.org>
	<200503092159.j29LxIg26267@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> > Did you generate a kernel profile?
> 
>  Top 40 kernel hot functions, percentage is normalized to kernel utilization.
> 
>  _spin_unlock_irqrestore		23.54%
>  _spin_unlock_irq			19.27%

Cripes.

Is that with CONFIG_PREEMPT?  If so, and if you disable CONFIG_PREEMPT,
this cost should be accounting the the spin_unlock() caller and we can see
who the culprit is.   Perhaps dio->bio_lock.

