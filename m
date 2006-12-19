Return-Path: <linux-kernel-owner+w=401wt.eu-S1752569AbWLSOV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbWLSOV1 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 09:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbWLSOV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 09:21:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60945 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752569AbWLSOV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 09:21:26 -0500
Date: Tue, 19 Dec 2006 09:20:03 -0500
From: Dave Jones <davej@redhat.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Berthold Cogel <cogel@rrz.uni-koeln.de>, linux-kernel@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: BUG linux-2.6-20-rc1: kernel BUG at drivers/cpufreq/cpufreq_userspace.c
Message-ID: <20061219142003.GC25461@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Berthold Cogel <cogel@rrz.uni-koeln.de>,
	linux-kernel@vger.kernel.org,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
References: <200612190421_MC3-1-D58E-782E@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612190421_MC3-1-D58E-782E@compuserve.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 04:18:13AM -0500, Chuck Ebbert wrote:
 > In-Reply-To: <45859609.8050502@rrz.uni-koeln.de>
 > 
 > On Sun, 17 Dec 2006 20:10:01 +0100, Berthold Cogel wrote:
 > > I've found a kernel bug in linux-2.6-20-rc1 from kernel.org:
 > > Dec 17 19:12:56 localhost kernel: kernel BUG at drivers/cpufreq/cpufreq_userspace.c:140!
 > 
 > Does this fix it?
 > 
 > Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
 > 
 > --- 2.6.20-rc1-32smp.orig/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
 > +++ 2.6.20-rc1-32smp/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
 > @@ -706,7 +706,7 @@ static int acpi_cpufreq_cpu_init(struct 
 >  		break;
 >  	case ACPI_ADR_SPACE_FIXED_HARDWARE:
 >  		acpi_cpufreq_driver.get = get_cur_freq_on_cpu;
 > -		get_cur_freq_on_cpu(cpu);
 > +		policy->cur = get_cur_freq_on_cpu(cpu);
 >  		break;
 >  	default:
 >  		break;

A similar fix is in Linus' -git tree as
http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=a507ac4b01ed379a74eca5060f3553c4a4e5854c
Hopefully one day the kernel.org scripts will get around to making a -git6 patch.

		Dave

-- 
http://www.codemonkey.org.uk
