Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268490AbUJOVtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268490AbUJOVtG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 17:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268482AbUJOVtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 17:49:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52103 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268497AbUJOVrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 17:47:53 -0400
Date: Fri, 15 Oct 2004 17:47:20 -0400
From: Dave Jones <davej@redhat.com>
To: "H. J. Lu" <hjl@lucon.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>, ebiederm@xmission.com,
       akpm@osdl.org
Subject: Re: 2.6.9 kexec patch causes kernel panic during reboot on x86-64
Message-ID: <20041015214720.GQ24319@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, "H. J. Lu" <hjl@lucon.org>,
	linux kernel <linux-kernel@vger.kernel.org>, ebiederm@xmission.com,
	akpm@osdl.org
References: <20041015214013.GA6555@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041015214013.GA6555@lucon.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 02:40:13PM -0700, H. J. Lu wrote:
 > 2.6.9 kexec patch adds a call to find_isa_irq_pin in disable_IO_APIC.
 > But find_isa_irq_pin is marked __init on x86-64, which leads to
 > kernel panic. This patch should fix it.

Andrew,
 This is the x86-64 counterpart of the x86 patch I pushed
into mainline (mistakingly instead of -mm) last week.
Looks good to me.

		Dave

 > --- linux-2.6.8/arch/x86_64/kernel/io_apic.c.init	2004-10-14 16:21:44.000000000 -0700
 > +++ linux-2.6.8/arch/x86_64/kernel/io_apic.c	2004-10-15 14:34:53.615495099 -0700
 > @@ -332,7 +332,7 @@ static int __init find_irq_entry(int api
 >  /*
 >   * Find the pin to which IRQ[irq] (ISA) is connected
 >   */
 > -static int __init find_isa_irq_pin(int irq, int type)
 > +static int find_isa_irq_pin(int irq, int type)
 >  {
 >  	int i;
 >  

