Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262798AbTJUKxI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 06:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262801AbTJUKxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 06:53:08 -0400
Received: from hal-4.inet.it ([213.92.5.23]:7559 "EHLO hal-4.inet.it")
	by vger.kernel.org with ESMTP id S262798AbTJUKxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 06:53:04 -0400
Date: Tue, 21 Oct 2003 12:52:34 +0200
From: Mattia Dongili <dongili@supereva.it>
To: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: Re: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Message-ID: <20031021105234.GF893@inferi.kami.home>
Reply-To: dongili@supereva.it
Mail-Followup-To: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
References: <88056F38E9E48644A0F562A38C64FB60077914@scsmsx403.sc.intel.com> <1066725533.5237.3.camel@laptop.fenrus.com> <20031021095925.GB893@inferi.kami.home> <20031021101737.GA31352@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031021101737.GA31352@wiggy.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 12:17:37PM +0200, Wichert Akkerman wrote:
> Previously Mattia Dongili wrote:
> > I remember Linus forcing a kernel only policy management:
> > http://www.linux.org.uk/mailman/private/cpufreq/2002-August/000865.html
> 
> That archive is password-protected..

<QUOTE>

On Wed, 28 Aug 2002, Dominik Brodowski wrote:
> 
> The following patches add CPU frequency and volatage scaling
> support (Intel SpeedStep, AMD PowerNow, etc.) to kernel 2.5.32

The thing is, this interface appears fundamentally broken with respect to
CPU's that change their frequency on the fly. I happen to know one such 
CPU rather well myself.

What is this interface supposed to do about a CPU that can change its 
frequency dynamically several hundred times a second? Having the OS 
control it simply isn't an option - the overhead of the control is _way_ 
more than is acceptable at that level.

In short, this interface is too broken to be called generic. 

A quote from Peter Anvin:

  "What is worse is that the interface is, in my opinion, fundamentally
   broken for *ALL* CPUs.  It doesn't present a policy interface to the
   kernel, instead it presents a frequency-setting interface and expect
   the policy to be done in userspace.  The kernel is the only part of the
   system which has sufficient information (idle times of all CPUs, for
   example) to do a decent job managing the CPU frequency efficiently.  
   On Transmeta CPUs this policy should simply be passed down to CMS, of
   course; on other CPUs the kernel needs to manage it."

In other words: there is no valid way that a _user_ can set the policy
right now: the user can set the frequency, but since any sane policy
depends on how busy the CPU is, the user isn't even, the right person to
_do_ that, since the user doesn't _know_.

Also note that policy is not just about how busy the CPU is, but also 
about how _hot_ the CPU is. Again, a user-mode application (that maybe 
polls the situation every minute or so), simply _cannot_ handle this 
situation. You need to have the ability to poll the CPU tens of times a 
second to react to heat events, and clearly user mode cannot do that 
without impacting performance in a big way.

The interface needs to be improved upon. It is simply _not_ valid to say
"run at this speed" as the primary policy.

		Linus

</QUOTE>

anyway there has been a full discussion regarding this issue.

The result has been a major redesing of the cpufreq interface in
accordance to Linus' statements

Note: if you're subscribed to the cpufreq list you have a password to
enter at the propmt :)

ciao
-- 
mattia
:wq!
