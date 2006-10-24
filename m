Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbWJXKBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWJXKBI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 06:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbWJXKBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 06:01:08 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:43258 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1030269AbWJXKBF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 06:01:05 -0400
Date: Tue, 24 Oct 2006 03:00:32 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] x86_64 add missing enter_idle() calls
Message-ID: <20061024100032.GA7085@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20061006081607.GB8793@frankl.hpl.hp.com> <200610161636.52721.ak@suse.de> <20061021091837.GA24670@frankl.hpl.hp.com> <200610211522.53938.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610211522.53938.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Sat, Oct 21, 2006 at 03:22:53PM +0200, Andi Kleen wrote:
> 
> > I finally found the culprit for this. The current code is wrong for the
> > simple reason that the cpu_idle() function is NOT always the lowest level
> > idle loop function. For enter_idle()/__exit_idle() to work correctly they
> > must be placed in the lowest-level idle loop. The cpu_idle() eventually ends
> > up in the idle() function, but this one may have a loop in it! This is the
> > case when idle()=cpu_default_idle() and idle()=poll_idle(), for instance. 
> 
> Ah now I remember - i had actually fixed that (it was the cleanup-idle-loops
> patch) that moved the loops one level up. But then I disabled the patch
> at the request of Andrew because it conflicted with some ACPI idle changes.
> 
> I'll readd it for .20, then things should be ok.
> 

Ok, that's good. In the meantime, I need to produce the i386 equivalent.
Given how poll_idle() works (tight loop), I don't think we can just add
enter_idle()/exit_idle() around the loop, we also need to cover the interrupt
handlers, because that is the only place where we can catch activity considered
useful.

-- 
-Stephane
