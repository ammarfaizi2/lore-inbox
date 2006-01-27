Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751569AbWA0Wfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbWA0Wfk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbWA0Wfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:35:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58344 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751568AbWA0Wfk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:35:40 -0500
Date: Fri, 27 Jan 2006 14:37:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, torvalds@osdl.org,
       ergot86@gmail.com, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 2.6.15] i386: allow disabling X86_FEATURE_SEP at boot
Message-Id: <20060127143713.2efc16ed.akpm@osdl.org>
In-Reply-To: <200601261339_MC3-1-B6C3-2E03@compuserve.com>
References: <200601261339_MC3-1-B6C3-2E03@compuserve.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
> Allow the x86 "sep" feature to be disabled at bootup.  This
> forces use of the int80 vsyscall.
> 

Why is there a need to do this?

> 
>  Documentation/kernel-parameters.txt |    6 +++++-
>  arch/i386/kernel/cpu/common.c       |   13 +++++++++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> --- 2.6.15a.orig/arch/i386/kernel/cpu/common.c
> +++ 2.6.15a/arch/i386/kernel/cpu/common.c
> @@ -27,6 +27,7 @@ EXPORT_PER_CPU_SYMBOL(cpu_16bit_stack);
>  static int cachesize_override __devinitdata = -1;
>  static int disable_x86_fxsr __devinitdata = 0;
>  static int disable_x86_serial_nr __devinitdata = 1;
> +static int disable_x86_sep __devinitdata = 0;
>  

hm, I guess lots of things in there should be __cpuinit/__cpuinitdata. 
__devinit is a superset of that, but we're being a little wasteful in the
case of CONFIG_HOTPLUG&&!CONFIG_HOTPLUG_CPU.
