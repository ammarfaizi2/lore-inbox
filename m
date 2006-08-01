Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWHAVHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWHAVHO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 17:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWHAVHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 17:07:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15338 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750860AbWHAVHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 17:07:12 -0400
Date: Tue, 1 Aug 2006 14:07:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Blunck <jblunck@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix vmstat per cpu usage
Message-Id: <20060801140707.a55a0513.akpm@osdl.org>
In-Reply-To: <20060801173620.GM4995@hasse.suse.de>
References: <20060801173620.GM4995@hasse.suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006 19:36:21 +0200
Jan Blunck <jblunck@suse.de> wrote:

> The per cpu variables are used incorrectly in vmstat.h.
> 
> Signed-off-by: Jan Blunck <jblunck@suse.de>
> ---
>  include/linux/vmstat.h |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Index: linux-v2.6.18-rc3/include/linux/vmstat.h
> ===================================================================
> --- linux-v2.6.18-rc3.orig/include/linux/vmstat.h
> +++ linux-v2.6.18-rc3/include/linux/vmstat.h
> @@ -41,23 +41,23 @@ DECLARE_PER_CPU(struct vm_event_state, v
>  
>  static inline void __count_vm_event(enum vm_event_item item)
>  {
> -	__get_cpu_var(vm_event_states.event[item])++;
> +	__get_cpu_var(vm_event_states).event[item]++;
>  }

How odd.  Are there any negative consequences to the existing code?
