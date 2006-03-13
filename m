Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWCMUaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWCMUaQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWCMUaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:30:16 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:52424 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932443AbWCMUaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:30:13 -0500
Date: Mon, 13 Mar 2006 12:25:54 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: William Cohen <wcohen@nc.rr.com>
Cc: linux-kernel@vger.kernel.org, perfmon@napali.hpl.hp.com,
       perfctr-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       oprofile-list <oprofile-list@lists.sourceforge.net>
Subject: Re: [Perfctr-devel] 2.6.16-rc5 perfmon2 new code base + libpfm with Montecito support
Message-ID: <20060313202554.GD32683@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20060308155311.GD13168@frankl.hpl.hp.com> <4415BC45.1010601@nc.rr.com> <20060313185500.GB32683@frankl.hpl.hp.com> <4415C4E9.5070702@nc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4415C4E9.5070702@nc.rr.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will,

On Mon, Mar 13, 2006 at 02:15:53PM -0500, William Cohen wrote:
> 
> Yes, I have a similar patch for i386 in the kernel. I don't yet have 
> modifications for opcontrol or ophelp.

Your patch is very close to mine. I'll merge tthe two and will include
it in my next version.

My understand of opcontrol is that is passes the information from ophelp
to the kernel via /dev/oprofile. I don't know how it passes it to the oprofiled
daemon.

The daemon should not be difficult to change. I hacked something quickly
and got it up on pentium M. The only remaining problem is ophelp, I think.


> One question would be identifying the processor when using the perfmon2 
> support for i386/* processors? There is prior support in the oprofile 
> driver for i386 processors. Identify the processor differently depending 
> on whether perfmon2 is being used to distinguish between the different 
> interfaces? The way that OProfile has the events each name processor 
> requires a different directory in /usr/share/oprofile. Would prefer to 
> keep down the proliferation of new directories.

I think it would be easier to check in /sys/kernel/perfmon to detect
that it is running on perfmon2. Then opcontrol can pass the inormation
around to ophelp, oprofiled is necessary. Ophelp then just needs
to know the perfmon2 register mapping for each CPU. I don't know
how this information is represented today.

-- 
-Stephane
