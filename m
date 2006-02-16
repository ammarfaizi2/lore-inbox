Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWBPBg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWBPBg4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 20:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWBPBg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 20:36:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40938 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751341AbWBPBgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 20:36:54 -0500
Date: Wed, 15 Feb 2006 17:35:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: [PATCH] Provide an interface for getting the current tick
 length
Message-Id: <20060215173545.43a7412d.akpm@osdl.org>
In-Reply-To: <17395.53939.795908.336324@cargo.ozlabs.ibm.com>
References: <17395.53939.795908.336324@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
>
> +u64 current_tick_length(void)
>  +{
>  +	long time_adjust_step, delta_nsec;
>  +
>  +	if ((time_adjust_step = time_adjust) != 0 ) {

<mutters something about coding style>

>  +		/*
>  +		 * Limit the amount of the step to be in the range
>  +		 * -tickadj .. +tickadj
>  +		 */
>  +		time_adjust_step = min(time_adjust_step, (long)tickadj);
>  +		time_adjust_step = max(time_adjust_step, (long)-tickadj);
>  +	}
>  +	delta_nsec = tick_nsec + time_adjust_step * 1000;

Is that going to overflow if sizeof(long) == 4?

>  +	return ((u64) delta_nsec << (SHIFT_SCALE - 10)) + time_adj;
>  +}
