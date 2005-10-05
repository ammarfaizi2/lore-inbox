Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbVJEHjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbVJEHjh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 03:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbVJEHjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 03:39:37 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:28841 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932565AbVJEHjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 03:39:37 -0400
Date: Wed, 5 Oct 2005 09:39:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>, Todd.Kneisel@bull.com,
       Felix Oxley <lkml@oxley.org>
Subject: Re: 2.6.14-rc3-rt2
Message-ID: <20051005073957.GB22873@elte.hu>
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com> <20051004130009.GB31466@elte.hu> <Pine.LNX.4.58.0510041007100.13294@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510041007100.13294@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Also the inclusion of ktimer (I believe) has made a dependency with 
> mpparse and IO_APIC.  Since now mpparse.c calls setup_IO_APIC_early 
> which is defined only if X86_IO_APIC is, the kernel wont link without. 
> So, is the following patch sufficient? Or does mpparse.c need to be 
> different, that is should we not call setup_IO_APIC_early if 
> X86_IO_APIC is not set?

>  config X86_MPPARSE
>  	bool
> -	depends on X86_LOCAL_APIC && !X86_VISWS
> +	depends on X86_LOCAL_APIC && X86_IO_APIC && !X86_VISWS
>  	default y

thanks, applied.

	Ingo
