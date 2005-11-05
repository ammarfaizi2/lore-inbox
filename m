Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbVKEXd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbVKEXd1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 18:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVKEXd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 18:33:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13260 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751152AbVKEXd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 18:33:27 -0500
Date: Sat, 5 Nov 2005 15:33:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: ashok.raj@intel.com, rjw@sisk.pl, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, mingo@elte.hu, linux@brodo.de,
       venkatesh.pallipadi@intel.com
Subject: Re: 2.6.14-git3: scheduling while atomic from cpufreq on Athlon64
Message-Id: <20051105153304.09a1a4dc.akpm@osdl.org>
In-Reply-To: <20051105151944.A30804@unix-os.sc.intel.com>
References: <200510311606.36615.rjw@sisk.pl>
	<200510312045.32908.rjw@sisk.pl>
	<20051031124216.A18213@unix-os.sc.intel.com>
	<200511012007.19762.rjw@sisk.pl>
	<20051101111417.A31379@unix-os.sc.intel.com>
	<20051104143035.120fe158.akpm@osdl.org>
	<20051105151944.A30804@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <ashok.raj@intel.com> wrote:
>
> Now we leave a trace in current->flags indicating current thread already 
>  is under cpucontrol lock held, so we dont attempt to do this another time.
> 
> ..
> +#define PF_HOTPLUG_CPU	0x01000000	/* Currently performing CPU hotplug */
>

It's still hacky - I mean, we could use this trick to avoid recursion onto
any lock in the kernel whenever we get ourselves into a mess.  We'd gain an
awful lot of PF_* flags.

So we should still view this as a temporary fix.

I don't think I've seen an analysis of the actual deadlock yet.  Are you
able to provide a stack trace of the offending callpath?
