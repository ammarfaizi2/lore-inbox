Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263217AbTHVOwN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 10:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbTHVOwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 10:52:13 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:34320 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263217AbTHVOwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 10:52:09 -0400
Date: Fri, 22 Aug 2003 15:52:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: davej@codemonkey.org.uk, kernel list <linux-kernel@vger.kernel.org>,
       paul.devriendt@amd.com, aj@suse.de
Subject: Re: Cpufreq for opteron
Message-ID: <20030822155207.A17469@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pavel Machek <pavel@ucw.cz>, davej@codemonkey.org.uk,
	kernel list <linux-kernel@vger.kernel.org>, paul.devriendt@amd.com,
	aj@suse.de
References: <20030822135946.GA2194@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030822135946.GA2194@elf.ucw.cz>; from pavel@ucw.cz on Fri, Aug 22, 2003 at 03:59:46PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 03:59:46PM +0200, Pavel Machek wrote:
> +	tristate "AMD K8 PowerNow!"
> +	depends on CPU_FREQ_TABLE

shouldn't be this
	
	depends on CPU_FREQ?

> +#ifdef CONFIG_SMP
> +#error cpufreq support is disabled for config_smp
> +#endif

bah.  better depend on !CONFIG_SMP in the Kconfig file.

> +/* driver entry point for term */
> +static void __exit
> +drv_exit(void)
> +{
> +	dprintk(KERN_INFO PFX "drv_exit\n");
> +
> +	cpufreq_unregister_driver(&cpufreq_amd64_driver);
> +	if (ppst) {
> +		kfree(ppst);

kfree(NULL) is fine.

> +		ppst = 0;

this should be ppst = NULL but in fact is completly superflous as
the module is gone afterwards.

> +	}
> +	return;

superflous.

