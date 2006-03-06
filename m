Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWCFVnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWCFVnl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWCFVnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:43:41 -0500
Received: from colin.muc.de ([193.149.48.1]:33807 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932370AbWCFVnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:43:40 -0500
Date: 6 Mar 2006 22:43:32 +0100
Date: Mon, 6 Mar 2006 22:43:32 +0100
From: Andi Kleen <ak@muc.de>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC][PATCH] kdump: x86_64 timer interrupt lockup due to pending interrupt
Message-ID: <20060306214332.GA18529@muc.de>
References: <20060306164034.GB10594@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306164034.GB10594@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 11:40:34AM -0500, Vivek Goyal wrote:
> 
> o check_timer() routine fails while second kernel is booting after a crash
>   on an opetron box. Problem happens because timer vector (0x31) seems to be
>   locked.
> 
> o After a system crash, it is not safe to service interrupts any more, hence
>   interrupts are disabled. This leads to pending interrupts at LAPIC. LAPIC
>   sends these interrupts to the CPU during early boot of second kernel. Other
>   pending interrupts are discarded saying unexpected trap but timer interrupt
>   is serviced and CPU does not issue an LAPIC EOI because it think this
>   interrupt came from i8259 and sends ack to 8259. This leads to vector 0x31
>   locking as LAPIC does not clear respective ISR and keeps on waiting for
>   EOI.
> 
> o In this patch, one extra EOI is being issued in check_timer() to unlock the
>   vector. Please suggest if there is a better way to handle this situation.

Shouldn't we rather do this for all interrupts when the APIC is set up? 
I don't see how the timer is special here.

-Andi
