Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUA1EiG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 23:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265848AbUA1EiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 23:38:06 -0500
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:34675 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265847AbUA1EiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 23:38:03 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>,
       Alessandro Suardi <alessandro.suardi@oracle.com>
Subject: Re: 2.6.2-rc2-bk1 oopses on boot (ACPI patch)
Date: Tue, 27 Jan 2004 23:37:55 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, linux-acpi@intel.com
References: <40171B5B.4020601@oracle.com> <20040127184228.3a0b8a86.akpm@osdl.org>
In-Reply-To: <20040127184228.3a0b8a86.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401272337.55676.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 January 2004 09:42 pm, Andrew Morton wrote:
> Alessandro Suardi <alessandro.suardi@oracle.com> wrote:
> > Already reported, but I'll do so once again, since it looks like
> >   in a short while I won't be able to boot official kernels in my
> >   current config...
> >
> > Original report here:
> >
> > http://www.ussg.iu.edu/hypermail/linux/kernel/0312.3/0442.html
>
> Divide by zero.  Looks like ACPI is now passing bad values into the
> frequency change notifier.

It is a common problem with Dell's DSDT implementation which does not
follow ACPI spec and it's been going on for ages. From the original
report:

cpufreq: CPU0 - ACPI performance management activated
 cpufreq: *P0: 1Mhz, 0 mW, 0 uS
 cpufreq: P1: 0Mhz, 0 mW, 0 uS
 divide error: 0000 [#1]

As you can see all data is bogus... Patching DSDT cures it for sure,
sometimes CONFIG_ACPI_RELAXED_AML helps as well.

I suppose ACPI P-states driver could check frequencies/latencies and
refuse to activate if the are bogus.

-- 
Dmitry
