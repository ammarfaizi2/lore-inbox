Return-Path: <linux-kernel-owner+w=401wt.eu-S1946017AbWLVKIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946017AbWLVKIt (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 05:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946018AbWLVKIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 05:08:49 -0500
Received: from madara.hpl.hp.com ([192.6.19.124]:57129 "EHLO madara.hpl.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946017AbWLVKIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 05:08:48 -0500
Date: Fri, 22 Dec 2006 02:07:00 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] add i386 idle notifier (take 3)
Message-ID: <20061222100700.GB1895@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20061220140500.GB30752@frankl.hpl.hp.com> <20061220210514.42ed08cc.akpm@osdl.org> <20061221091242.GA32601@frankl.hpl.hp.com> <20061222010641.GK6993@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222010641.GK6993@stusta.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrian,

On Fri, Dec 22, 2006 at 02:06:41AM +0100, Adrian Bunk wrote:
> > changelog:
> > 	- add a notifier mechanism to the low level idle loop. You can
> > 	  register a callback function which gets invoked on entry and exit
> > 	  from the low level idle loop. The low level idle loop is defined as
> > 	  the polling loop, low-power call, or the mwait instruction. Interrupts
> > 	  processed by the idle thread are not considered part of the low level
> > 	  loop. The notifier can be used to measure precisely how much is spent
> > 	  in useless execution (or low power mode). The perfmon subsystem uses it
> > 	  to turn on/off monitoring.
> 
> 
> Why is this patch not submitted as part of the perfmon patch that also 
> adds a user of this code?
> 

If you look at the perfmon-new-base patch, you'll see a base.diff patch which
includes this one. I am slowly getting rid of this requirement by pushing
those "infrastructure patches" to mainline so that the perfmon patch gets
smaller over time. Submitting smaller patches makes it easier for maintainers
to integrate.

> And why does it bloat the kernel with EXPORT_SYMBOL's although even your 
> perfmon-new-base-061204 doesn't seem to add any modular user?
> 

I have tried to stay as close as possible from the x86-64 implementation
of this mechanism. The registration entry points are exported to modules,
just like they are for x86-64. Also note that the x86-64 idle notifier does
not have a user at this point, yet it is in the kernel. Perfmon will become
the first user of this mechanism.

-- 
-Stephane
