Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264042AbSIQKzi>; Tue, 17 Sep 2002 06:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264045AbSIQKzi>; Tue, 17 Sep 2002 06:55:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264042AbSIQKzh>; Tue, 17 Sep 2002 06:55:37 -0400
Date: Tue, 17 Sep 2002 12:00:33 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Dominik Brodowski <linux@brodo.de>, torvalds@transmeta.com,
       hpa@transmeta.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cpufreq@www.linux.org.uk
Subject: Re: [PATCH][2.5.35] CPUfreq documentation (4/5)
Message-ID: <20020917120033.A28438@flint.arm.linux.org.uk>
References: <20020917113547.H25385@brodo.de> <1032257979.3070.29.camel@nomade>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1032257979.3070.29.camel@nomade>; from xavier.bestel@free.fr on Tue, Sep 17, 2002 at 12:19:37PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2002 at 12:19:37PM +0200, Xavier Bestel wrote:
> Le mar 17/09/2002 à 11:35, Dominik Brodowski a écrit :
> 
> > +The third argument, a void *pointer, points to a struct cpufreq_freqs
> > +consisting of five values: cpu, min, max, policy and max_cpu_freq. Min 
> > +and max are the lower and upper frequencies (in kHz) of the new
> > +policy, policy the new policy, cpu the number of the affected CPU or
> > +CPUFREQ_ALL_CPUS for all CPUs; and max_cpu_freq the maximum supported
> > +CPU frequency. This value is given for informational purposes only.
> 
> - Why choosing a void* ? that doesn't validate type ..

That's the type specified by the notifier code.  You have two choices:

int notifier_foo(struct notifier_block *nb, int foo, void *bar)
{
	struct my_bar *my = bar;
}

struct notifier_block nb = {
	.notifier_call = notifier_foo,
};

OR:

int notifier_foo(struct notifier_block *nb, int foo, struct my_bar *my)
{
}

struct notifier_block nb = {
	.notifier_call = (int (*)(struct notifier_block *, int, void *))notifier_foo,
};

So, you end up with a cast in one place or the other.  I know which one
I prefer.

> - The struct cpufreq_freqs actually consists of only three values (cpu,
> old, new). The five values you cite here are in the struct
> cpufreq_policy.

Yep, it's a little unclear.

The policy notifiers are called with struct cpufreq_policy, which have
five values.  The transition notifiers are called with struct
cpufreq_freqs, which has three values.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

