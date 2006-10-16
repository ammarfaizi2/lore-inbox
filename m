Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWJPOOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWJPOOK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 10:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWJPOOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 10:14:10 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:52711 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S932067AbWJPOOH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 10:14:07 -0400
Date: Mon, 16 Oct 2006 07:13:42 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] x86_64 add missing enter_idle() calls
Message-ID: <20061016141342.GF15540@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20061006081607.GB8793@frankl.hpl.hp.com> <200610161208.13628.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610161208.13628.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Mon, Oct 16, 2006 at 12:08:13PM +0200, Andi Kleen wrote:
> On Friday 06 October 2006 10:16, Stephane Eranian wrote:
> > Hi,
> > 
> > Unless I am mistaken, I think we are missing some calls to enter_idle()
> > in the x86_64 tree. The following patch adds a bunch of missing
> > enter_idle() callbacks for some of the "direct" interrupt handlers.
> > 
> > changelog:
> > 	- adds missing enter_idle() calls to most of the "direct" interrupt
> > 	  handlers.
> 
> HLT returns after an interrupt and then does enter_idle()

With the original code, the number of callbacks you see for IDLE_START and
IDLE_STOP is not too obvious.

On an idle system Opteron 250 with HZ=250, one would expect to see for a 10s duration:
	- for CPU0      : IDLE_START = IDLE_STOP = about 5000 calls
	- for other CPUs: IDLE_START = IDLE_STOP = about 2500  calls

With the original code, you get the following number of calls:

CPU0.IDLE_START = 44 (enter_idle)
CPU0.IDLE_STOP  = 5206 (exit_idle)

CPU1.IDLE_START = 27 (enter_idle)
CPU1.IDLE_STOP  = 2528 (exit_idle)

Now, of course, you may get "batched" interrupts where you do not return to idle
before you process the next interrupt. But the difference seems quite high here.

Do you have an explanation for this?

-- 
-Stephane
