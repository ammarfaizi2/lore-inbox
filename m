Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263605AbUEGO1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263605AbUEGO1v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 10:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbUEGOZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 10:25:59 -0400
Received: from dingo.clsp.jhu.edu ([128.220.117.40]:13184 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263605AbUEGOZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 10:25:12 -0400
Date: Thu, 6 May 2004 15:45:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Alexey Mahotkin <alexm@w-m.ru>
Subject: Re: [PATCH][2.6] throttle P4 thermal warnings
Message-ID: <20040506134506.GB241@elf.ucw.cz>
References: <Pine.LNX.4.58.0404300952350.2332@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404300952350.2332@montezuma.fsmlabs.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> In really bad conditions this can keep printing for a while, throttle the
> output somewhat. Also change the "CPU%d" formatting to better match the
> other boot output.

Hmm, is it possible that you see "temperature above treshold", but
then you throttle it so you never see "temperature normal" message?

That would be pretty bad...

Also please consider putting Temperature above threshold and running
in modulated clock mode on single line.
								Pavel


> 
> -	rdmsr (MSR_IA32_THERM_STATUS, l, h);
> -	if (l & 1) {
> -		printk(KERN_EMERG "CPU#%d: Temperature above threshold\n", cpu);
> -		printk(KERN_EMERG "CPU#%d: Running in modulated clock mode\n", cpu);
> +	if (time_after(next[cpu], jiffies))
> +		return;
> +
> +	next[cpu] = jiffies + HZ*5;
> +	rdmsr(MSR_IA32_THERM_STATUS, l, h);
> +	if (l & 0x1) {
> +		printk(KERN_EMERG "CPU%d: Temperature above threshold\n", cpu);
> +		printk(KERN_EMERG "CPU%d: Running in modulated clock mode\n", cpu);
>  	} else {
> -		printk(KERN_INFO "CPU#%d: Temperature/speed normal\n", cpu);
> +		printk(KERN_INFO "CPU%d: Temperature/speed normal\n", cpu);
>  	}
>  }
> 
-- 
When do you have heart between your knees?
