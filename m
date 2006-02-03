Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWBCAvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWBCAvP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 19:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWBCAvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 19:51:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42184 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750758AbWBCAvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 19:51:14 -0500
Date: Thu, 2 Feb 2006 16:52:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: ashok.raj@intel.com, davej@redhat.com, linux-kernel@vger.kernel.org,
       pavel@ucw.cz
Subject: Re: [patch -mm4] i386 cpu hotplug: don't access freed memory
Message-Id: <20060202165257.29dcfa20.akpm@osdl.org>
In-Reply-To: <200602021904_MC3-1-B771-46F7@compuserve.com>
References: <200602021904_MC3-1-B771-46F7@compuserve.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
> @@ -160,10 +162,17 @@ static void __cpuinit get_cpu_vendor(str
>  				c->x86_vendor = i;
>  				if (!early)
>  					this_cpu = cpu_devs[i];
> -				break;
> +				return;
>  			}
>  		}
>  	}
> +	if (!printed) {
> +		printed++;
> +		printk(KERN_ERR "CPU: Vendor unknown, using generic init.\n");
> +		printk(KERN_ERR "CPU: Your system may be unstable.\n");
> +	}
> +	c->x86_vendor = X86_VENDOR_UNKNOWN;
> +	this_cpu = &default_cpu;

Well that's a worry.  Under what circumstances (if any) will this final bit
of code get executed?
