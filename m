Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312387AbSCUQlW>; Thu, 21 Mar 2002 11:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312384AbSCUQlO>; Thu, 21 Mar 2002 11:41:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61194 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312387AbSCUQlA>; Thu, 21 Mar 2002 11:41:00 -0500
Subject: Re: [PATCH] multithreaded coredumps for elf exeecutables
To: dan@debian.org (Daniel Jacobowitz)
Date: Thu, 21 Mar 2002 16:52:52 +0000 (GMT)
Cc: vamsi@in.ibm.com (Vamsi Krishna S .),
        mgross@unix-os.sc.intel.com (Mark Gross), pavel@suse.cz (Pavel Machek),
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        marcelo@conectiva.com.br, tachino@jp.fujitsu.com, jefreyr@pacbell.net,
        vamsi_krishna@in.ibm.com, richardj_moore@uk.ibm.com,
        hanharat@us.ibm.com, bsuparna@in.ibm.com, bharata@in.ibm.com,
        asit.k.mallick@intel.com, david.p.howell@intel.com,
        tony.luck@intel.com, sunil.saxena@intel.com
In-Reply-To: <20020321112722.A31634@nevyn.them.org> from "Daniel Jacobowitz" at Mar 21, 2002 11:27:22 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16o5o5-0005gM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We really need a non-signal-based way to tell the scheduler that a task
> can not be scheduled.  A lot of the machinery is all there, but private to
> sched.c; the rest is pretty straightforward.

You need interrupts to handle this, even if you don't wrap it in the top
layer of signals it will be able to use much of the code I agree. The nasty
case is the "currently running on another cpu" one. Especially since you 
can't just "trap it" - if you IPI that processor it might have moved by the
time the IPI arrives 8)

