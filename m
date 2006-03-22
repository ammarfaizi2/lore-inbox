Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWCVSMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWCVSMV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 13:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWCVSMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 13:12:20 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:34956 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932300AbWCVSMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 13:12:20 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ashok Raj <ashok.raj@intel.com>
Subject: Re: Linux v2.6.16
Date: Wed, 22 Mar 2006 19:11:05 +0100
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, Peter Williams <pwil3058@bigpond.net.au>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
References: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org> <200603221839.41867.rjw@sisk.pl> <20060322095457.A12334@unix-os.sc.intel.com>
In-Reply-To: <20060322095457.A12334@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221911.06576.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 22 March 2006 18:54, Ashok Raj wrote:
> On Wed, Mar 22, 2006 at 06:39:41PM +0100, Rafael J. Wysocki wrote:
> > > 
> > > Please consider for inclusion... resending with changelog per Andrew.
> > 
> > Please don't apply this patch.
> > 
> > CPU hotplug is used by swsusp for disabling the nonboot CPUs.  Software
> > suspend won't work on SMP without CPU hotplugging.
> > 
> 
> Hi Rafael,
> 
> what part of this is not suitable for swsusp? All we do is just use flat physical mode
> for IPI processing. The only difference is moving from logical flat mode to using
> flat physical mode.
> 
> Have you tested swsusp with CONFIG_GENERICARCH and CONFIG_HOTPLUG_CPU=y ?
> 
> It might help to explain why this would break your swsusp with SMP work?

On SMP systems swsusp (suspend in general, AFAICT) uses the disable_nonboot_cpus()
function defined in kernel/power/smp.c, which calls cpu_down() that is only
defined if CONFIG_HOTPLUG_CPU is set.  We can't suspend and resume SMP systems
reliably without it.

Greetings,
Rafael
