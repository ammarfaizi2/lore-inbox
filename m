Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVA2RoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVA2RoZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 12:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVA2RoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 12:44:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:52390 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261339AbVA2RoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 12:44:22 -0500
Date: Sat, 29 Jan 2005 09:44:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, rohit.seth@intel.com,
       asit.k.mallick@intel.com
Subject: Re: [Discuss][i386] Platform SMIs and their interferance with tsc
 based delay calibration
In-Reply-To: <20050128185101.A19117@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.58.0501290927180.2362@ppc970.osdl.org>
References: <20050128185101.A19117@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 28 Jan 2005, Venkatesh Pallipadi wrote:
>
> Current tsc based delay_calibration can result in significant errors in
> loops_per_jiffy count when the platform events like SMIs (System
> Management Interrupts that are non-maskable) are present. This could
> lead to potential kernel panic(). This issue is becoming more visible
> with 2.6 kernel (as default HZ is 1000) and on platforms with higher SMI
> handling latencies. During the boot time, SMIs are mostly used by BIOS
> (for things like legacy keyboard emulation).

Hmm. I see the problem, but I don't know that I'm 100% happy with this
patch, though.

In particular, I don't see why you didn't just put this in the generic 
calibrate_delay() routine. You seem to have basically duplicated it, and 
added the "guess from an external timer" code - and I don't see what's 
non-generic about that, except for some trivial "what's the current timer" 
lookup.

		Linus
