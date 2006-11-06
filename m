Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753583AbWKFRf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbWKFRf2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 12:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753568AbWKFRf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 12:35:28 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12306 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1753560AbWKFRf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 12:35:27 -0500
Date: Mon, 6 Nov 2006 18:35:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, Christian <christiand59@web.de>,
       Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, cpufreq@lists.linux.org.uk
Subject: Re: [discuss] Linux 2.6.19-rc4: known unfixed regressions (v2)
Message-ID: <20061106173528.GQ5778@stusta.de>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <454AFD01.4080306@linux.intel.com> <20061103155656.GA1000@redhat.com> <200611051832.13285.christiand59@web.de> <20061105200448.GE859@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061105200448.GE859@redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2006 at 03:04:48PM -0500, Dave Jones wrote:
> On Sun, Nov 05, 2006 at 06:32:12PM +0100, Christian wrote:
>  > Am Freitag, 3. November 2006 16:56 schrieb Dave Jones:
>  > > On Fri, Nov 03, 2006 at 11:25:37AM +0300, Alexey Starikovskiy wrote:
>  > >  > Could this be a problem?
>  > >  > --------------------
>  > >  > ...
>  > >  > CONFIG_ACPI_PROCESSOR=m
>  > >  > ...
>  > >  > CONFIG_X86_POWERNOW_K8=y
>  > >
>  > > Hmm, possibly.  Christian, does it work again if you set them both to =y ?
>  > 
>  > Yes, it works now! Only the change to CONFIG_ACPI_PROCESSOR=y made it work 
>  > again!
> 
> So, the reasoning behind this, is that we have this construct..
> 
> config X86_POWERNOW_K8_ACPI
>     bool
>     depends on X86_POWERNOW_K8 && ACPI_PROCESSOR
>     depends on !(X86_POWERNOW_K8 = y && ACPI_PROCESSOR = m)
>     default y
> 
> 
> Which makes us use the ACPI stuff if it's there, otherwise not,
> and in your case, it seems your system _needs_ this enabled
> to make powernow work.
> 
> Thing is, this was there in 2.6.18 too, so strictly speaking,
> we haven't regressed here, and you're getting exactly what you asked for.
> The problem is that it's completely silent as to why it then fails.
> 
> I'm open to improvements, but I'm not sure what the right thing to do
> here is.. opinions ?

The extreme solution would be

config X86_POWERNOW_K8
        tristate "AMD Opteron/Athlon64 PowerNow!"
        select CPU_FREQ_TABLE
        depends ACPI_PROCESSOR

A medium solution might be

config X86_POWERNOW_K8
        tristate "AMD Opteron/Athlon64 PowerNow!"
        select CPU_FREQ_TABLE
	depends (ACPI_PROCESSOR || ACPI_PROCESSOR=n)

But in the end, the best solution depends on how many percent of the 
X86_POWERNOW_K8 users have Christian's problem of requiring 
ACPI_PROCESSOR. If there are only very few people with this problem, I'd 
say leave it as it is.

> 	Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

