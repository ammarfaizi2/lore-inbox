Return-Path: <linux-kernel-owner+w=401wt.eu-S1422894AbWLUJNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422894AbWLUJNS (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 04:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422886AbWLUJNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 04:13:17 -0500
Received: from gundega.hpl.hp.com ([192.6.19.190]:59614 "EHLO
	gundega.hpl.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422894AbWLUJNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 04:13:16 -0500
Date: Thu, 21 Dec 2006 01:12:42 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] add i386 idle notifier (take 3)
Message-ID: <20061221091242.GA32601@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20061220140500.GB30752@frankl.hpl.hp.com> <20061220210514.42ed08cc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220210514.42ed08cc.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On Wed, Dec 20, 2006 at 09:05:14PM -0800, Andrew Morton wrote:
> On Wed, 20 Dec 2006 06:05:00 -0800
> Stephane Eranian <eranian@hpl.hp.com> wrote:
> 
> > Hello,
> > 
> > Here is the latest version of the idle notifier for i386.
> > This patch is against 2.6.20-rc1 (GIT). In this kernel, the idle
> > loop code was modified such that the lowest level idle
> > routines do not have loops anymore (e.g., poll_idle). As such,
> > we do not need to call enter_idle() in all the interrupt handlers.
> > 
> > This patch also duplicates the x86-64 bug fix for a race condition
> > as posted by Venkatesh Pallipadi from Intel.
> > 
> > changelog:
> > 	- add idle notification mechanism to i386
> > 
> 
> None of the above text is actually usable as a changelog entry.  We are
> left wondering:
> 
> - why is this patch needed?
> 
> - what does it do?
> 
> - how does it do it?
> 
> The three questions which all changelogs should answer ;)

Sorry about that. Here is a new changelog:

changelog:
	- add a notifier mechanism to the low level idle loop. You can
	  register a callback function which gets invoked on entry and exit
	  from the low level idle loop. The low level idle loop is defined as
	  the polling loop, low-power call, or the mwait instruction. Interrupts
	  processed by the idle thread are not considered part of the low level
	  loop. The notifier can be used to measure precisely how much is spent
	  in useless execution (or low power mode). The perfmon subsystem uses it
	  to turn on/off monitoring.

-- 
-Stephane
