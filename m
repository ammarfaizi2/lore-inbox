Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261443AbTCONpj>; Sat, 15 Mar 2003 08:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261447AbTCONpj>; Sat, 15 Mar 2003 08:45:39 -0500
Received: from mx0.inoc.net ([64.246.130.30]:4102 "EHLO mx0.inoc.net")
	by vger.kernel.org with ESMTP id <S261443AbTCONph>;
	Sat, 15 Mar 2003 08:45:37 -0500
Date: Sat, 15 Mar 2003 07:56:26 -0500
From: Christopher Meredith <theophile@saintmail.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PowerNow!, cpufreq, and swsusp
Message-Id: <20030315075626.5cfda32f.theophile@saintmail.net>
In-Reply-To: <20030312183954.GA13653@suse.de>
References: <3e6f6919.1546.10699@saintmail.net>
	<20030312183954.GA13653@suse.de>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Mar 2003 17:40:01 -0100
Dave Jones <davej@codemonkey.org.uk> wrote:

> On Wed, Mar 12, 2003 at 12:06:33PM -0500, Christopher Meredith wrote:
> 
>  > Also, cpufreq doesn't seem to do anything. Should it be
>  > working automatically?
> 
> no.
> 
>  > Even when the machine sits unattended
>  > for over 8 hours, the fan never turns off and the cpu
>  > temperature is consustently 69-70 degrees C.
> 
> The kernel doesn't define policy, but exposes the necessary
> interface to userspace.  There are a few folks working on
> tools / scripts to adjust the speed dynamically.
> look through the cpufreq mailing list archives to find them
> (or google)
> 
>  > What must I do here?
> 
> Read Documentation/cpu-freq/user-guide.txt
> 
> short: mount sysfs, and ..
> 
> (root@evo:cpufreq)# cd /sys/class/cpu/cpufreq/cpu0/cpufreq
> (root@evo:cpufreq)# cat /proc/cpuinfo | grep MHz
> cpu MHz		: 1390.536
> (root@evo:cpufreq)# echo powersave >scaling_governor
> (root@evo:cpufreq)# cat /proc/cpuinfo | grep MHz
> cpu MHz		: 529.728
> (root@evo:cpufreq)# echo performance >scaling_governor
> 

All right, it seems that for me, these things reside in /sys/devices/sys/cpu0:
root@Judea:/sys/devices/sys/cpu0# ls
available_scaling_governors  name            scaling_governor
cpuinfo_max_freq             power           scaling_max_freq
cpuinfo_min_freq             scaling_driver  scaling_min_freq

At any rate, 'cat available_scaling_governors' gives this:
performance powersave

If I 'echo powersave > scaling_governor', the fan slows down and the processor registers at about 600+ MHz (down from 1500+). So far so good. But when I 'echo performance > scaling_governor', the entire system locks up and I have to hard reset. Am I still missing something here? Also, I had thought the purpose of this technology was to incrementally scale the clock speed depending upon what the computer was doing, this saving battery power. Is this correct? If so, how do I enable this?

Also, with regard to swsusp, after creating a swap partition and seemingly adding the 'resume' line to lilo.conf, whenever I do 'echo 4 > /proc/acpi/sleep', the computer ditches X and prints ACPI information on all consoles. This seems good at first, but no matter how long I let it sit, it doesn't ever suspend or try to do anything similar (that I can tell). Am I still doing something wrong?

Thanks!

~Christopher
