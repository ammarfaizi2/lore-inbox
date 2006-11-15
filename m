Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030834AbWKOSgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030834AbWKOSgj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030836AbWKOSgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:36:39 -0500
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:10934 "EHLO
	aa012msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1030834AbWKOSgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:36:37 -0500
Date: Wed, 15 Nov 2006 19:36:10 +0100
From: Mattia Dongili <malattia@linux.it>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: ego@in.ibm.com, Reuben Farrelly <reuben-linuxkernel@reub.net>,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com,
       linux-kernel@vger.kernel.org,
       CPUFreq Mailing List <cpufreq@lists.linux.org.uk>,
       "Sadykov, Denis M" <denis.m.sadykov@intel.com>
Subject: Re: 2.6.19-rc5-mm2
Message-ID: <20061115183610.GA4812@inferi.kami.home>
Mail-Followup-To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	ego@in.ibm.com, Reuben Farrelly <reuben-linuxkernel@reub.net>,
	Andrew Morton <akpm@osdl.org>, davej@redhat.com,
	linux-kernel@vger.kernel.org,
	CPUFreq Mailing List <cpufreq@lists.linux.org.uk>,
	"Sadykov, Denis M" <denis.m.sadykov@intel.com>
References: <EB12A50964762B4D8111D55B764A8454E4128E@scsmsx413.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EB12A50964762B4D8111D55B764A8454E4128E@scsmsx413.amr.corp.intel.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.19-rc5-mm2-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2006 at 10:06:23AM -0800, Pallipadi, Venkatesh wrote:
[...]
> >Venki, I'm a little worried about the switch/case in question (line
> >702): the data->cpu_feature is set either to SYSTEM_IO_CAPABLE or
> >SYSTEM_INTEL_MSR_CAPABLE just a few lines above so it seems the switch
> >variable is wrong and none of the 2 cases will ever get a chance to
> >execute.
> >
> 
> The variable is set few lines before. So, it should be OK to switch on
> that 
> variable set and one of the two cases will execute. isn't it? Or am 
> I missing something?

Yes, patch is coming.

> >Unfortunately I don't have enough knowledge to tell if it's simply
> >necessary to fix the switch variable as 
> 
> Get_cur_freq_on_cpu will not work on SYSTEM_IO space as ACPI does not
> have an interface to get the current frequency. It only has a interface
> to say whether the last transitions tried was successful or not.
> So, if indeed a change in switch is required, first option should be
> good...

Hmmmm... I see, the following path fooled me, but re-reading it seems
more obvious what it is doing :)

	get_cur_freq_on_cpu
		extract_freq
			switch (data->cpu_feature) {
			case SYSTEM_INTEL_MSR_CAPABLE:
				return extract_msr(val, data);
			case SYSTEM_IO_CAPABLE:
				return extract_io(val, data);
			...

-- 
mattia
:wq!
