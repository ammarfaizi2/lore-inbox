Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbTIGQIR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 12:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263362AbTIGQIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 12:08:17 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46866 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263357AbTIGQIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 12:08:13 -0400
Date: Sun, 7 Sep 2003 17:08:09 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Breno <brenosp@brasilsec.com.br>
Cc: Marcelo <marcelo@conectiva.com.br>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: mswap.patch - 2.4.20
Message-ID: <20030907170809.C23176@flint.arm.linux.org.uk>
Mail-Followup-To: Breno <brenosp@brasilsec.com.br>,
	Marcelo <marcelo@conectiva.com.br>,
	Kernel List <linux-kernel@vger.kernel.org>
References: <000a01c38db1$76b4e400$f8e4a7c8@bsb.virtua.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <000a01c38db1$76b4e400$f8e4a7c8@bsb.virtua.com.br>; from brenosp@brasilsec.com.br on Wed, Oct 08, 2003 at 12:33:01PM -0300
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 08, 2003 at 12:33:01PM -0300, Breno wrote:
> I dis this small patch , because i need to know information about swap´s
> consume.
> 
> patch for kernel 2.4.20

The "&&" operator can be useful sometimes.  I think this may be one of
those times.

> +
> +int show_swap_usage(void)
> +{
> +    struct task_struct *p = NULL;
> +    
> +    for_each_task(p)
> +    {
> +	if(p != NULL)
> +	{
> +	    if(p->pid != 1)
> +	    {
> +		if(p->mm != NULL)
> +		{
> +		    if(p->nswap > 0)
> +		    {
> +			printk(KERN_CRIT"Process name: %s pid %d\n",p->comm,p->pid);
> +			printk(KERN_CRIT"Nswap: %lu Totalvm %lu Cswap %lu\n",p->nswap,p->mm->total_vm,p->cnswap);
> +			return 0;
> +		    }
> +		}
> +	    }
> +	}
> +    }
> +    return 0;
> +}	


-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
