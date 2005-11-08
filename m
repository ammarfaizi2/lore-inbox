Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbVKHCVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbVKHCVO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbVKHCVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:21:13 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:62688 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030251AbVKHCVM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:21:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ShDfmtdhlz0aDOTS5OEx6dpX+RL9yIYaMAJRtzmwrqiDnmkNtuv+uv+bQB5JAwJsZLJbTJ803RFNH1TT+CQPfJ8LFiXmqNb793rtRqBBA8EGxJsS8OFWlY+4biVxBS7qc8c3QVSsl+Nzmd353465DKU9jkUiz5g2oh8njKjtGO4=
Message-ID: <2cd57c900511071821l4603ea65l@mail.gmail.com>
Date: Tue, 8 Nov 2005 10:21:11 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: + cpu-hotplug-fix-locking-in-cpufreq-drivers-fix.patch added to -mm tree
Cc: Brice.Goglin@ens-lyon.org, ashok.raj@intel.com,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200511070553.jA75ro8N019892@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200511070553.jA75ro8N019892@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/11/7, akpm@osdl.org <akpm@osdl.org>:
>
> The patch titled
>
>      cpu-hotplug-fix-locking-in-cpufreq-drivers fix
>
> has been added to the -mm tree.  Its filename is
>
>      cpu-hotplug-fix-locking-in-cpufreq-drivers-fix.patch
>
>
> From: Brice Goglin <Brice.Goglin@ens-lyon.org>
>
> drivers/cpufreq/cpufreq.c uses current_in_cpu_hotplug.
> But, kernel/cpu.c is not built on UP boxes.
> This generates the following error:
>
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `__cpufreq_driver_target':
> : undefined reference to `current_in_cpu_hotplug'
>
> Signed-off-by: Brice Goglin <Brice.Goglin@ens-lyon.org>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
>
>  include/linux/cpu.h |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletion(-)
>
> diff -puN include/linux/cpu.h~cpu-hotplug-fix-locking-in-cpufreq-drivers-fix include/linux/cpu.h
> --- devel/include/linux/cpu.h~cpu-hotplug-fix-locking-in-cpufreq-drivers-fix    2005-11-06 21:53:34.000000000 -0800
> +++ devel-akpm/include/linux/cpu.h      2005-11-06 21:53:34.000000000 -0800
> @@ -33,7 +33,6 @@ struct cpu {
>
>  extern int register_cpu(struct cpu *, int, struct node *);
>  extern struct sys_device *get_cpu_sysdev(int cpu);
> -extern int current_in_cpu_hotplug(void);
>  #ifdef CONFIG_HOTPLUG_CPU
>  extern void unregister_cpu(struct cpu *, struct node *);
>  #endif
> @@ -43,6 +42,7 @@ struct notifier_block;
>  /* Need to know about CPUs going up/down? */
>  extern int register_cpu_notifier(struct notifier_block *nb);
>  extern void unregister_cpu_notifier(struct notifier_block *nb);
> +extern int current_in_cpu_hotplug(void);

Probably it would be better to always put things like this in header
as static inline. I was doing that, but yours patch came first.

int current_in_cpu_hotplug(void)
{
	return (current->flags & PF_HOTPLUG_CPU);
}

>
>  int cpu_up(unsigned int cpu);
>
> @@ -55,6 +55,10 @@ static inline int register_cpu_notifier(
>  static inline void unregister_cpu_notifier(struct notifier_block *nb)
>  {
>  }
> +static inline int current_in_cpu_hotplug(void)
> +{
> +       return 0;
> +}
>
>  #endif /* CONFIG_SMP */
>  extern struct sysdev_class cpu_sysdev_class;
> _
>
> Patches currently in -mm which might be from Brice.Goglin@ens-lyon.org are
>
> cpu-hotplug-fix-locking-in-cpufreq-drivers-fix.patch
> ppp_mppe-add-ppp-mppe-encryption-module.patch
> dlm-debug-fs.patch
> nmi-lockup-and-altsysrq-p-dumping-calltraces-on-_all_-cpus.patch
>
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
