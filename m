Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTJUUpG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTJUUpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:45:05 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:37873 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S263375AbTJUUo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:44:57 -0400
Date: Tue, 21 Oct 2003 22:32:15 +0200
From: Dominik Brodowski <linux@brodo.de>
To: danielk@mrl.nyu.edu
Cc: Mattia Dongili <dongili@supereva.it>, linux-kernel@vger.kernel.org,
       cpufreq@www.linux.org.uk
Subject: Re: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Message-ID: <20031021203215.GE26971@brodo.de>
References: <88056F38E9E48644A0F562A38C64FB60077914@scsmsx403.sc.intel.com> <1066725533.5237.3.camel@laptop.fenrus.com> <20031021095925.GB893@inferi.kami.home> <20031021101737.GA31352@wiggy.net> <20031021105234.GF893@inferi.kami.home> <Pine.SOL.4.53.0310211057060.6187@graphics.cat.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.53.0310211057060.6187@graphics.cat.nyu.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 11:36:56AM -0400, Daniel Thor Kristjansson wrote:
> 
> The _user_ shouldn't set the cpu frequency hundred of times a second,
> but a userland program should set the priorities. If you are just
> looking at CPU Temperature and the idle loop for setting your cpu
> frequency then it's fine to do it in the kernel. But if you are looking
> at dozens of factors and balancing them it is much safer to do so in
> userland.

Wrong. Passing "events" or "information" to cpufreq governors by
cpufreq_governor() is much easier, cheaper, and more reliable. 

> CPUFreq has been rearchitectured to allow this type of thing,
> you can have a governor in the kernel that sets CPU Frequency based on
> load within limits specified by a userland program.

Wrong again. CPUfreq has been rearchitectured to do this kernel-space. 
The userspace governor allows setting to specific frequencies by the user
["I _want_ 500 MHz and nothing else!"], and it offers backwards
compatibility for the first-era cpufreq interface [LART project etc.].

> ACPI can meantime throttle the CPU if it gets too hot

However, frequency scaling is much more efficient on lowering the CPU heat,
too.

> The user may know things the kernel doesn't such as "this laptop is
> burning a hole in my pants." She might want to construct a policy that
> doesn't minimize power consumption since she's plugged in, but gives the
> CPU lots of juice at first when the idle goes down, but then backs off
> if it detects a long running 100% utilization such as during a long
> compile.

Yes indeed. She wants to set a cpufreq policy which suits of her needs: 
it consists of a
- minimum frequency	=> not too low [she's plugged in]
- maximum frequency	=> 100%
- cpufreq governor	=> some kind of yet-to-be-written 
				dynamic cpufreq governor with
				temperature or long-term-statistic
				knowledge.

_I_ wouldn't want to run this governor, though -- I want kernel compiles to
complete as fast as possible. So, we need different in-kernel governors.

> This would maximize responsiveness in interactive settings but
> still keep her lap comfortably cool when compiling mozilla. Putting the
> complexity of policies specified by something like an XML file in the
> kernel scares me, putting it in a userspace program that communicates
> with a low level governor is a more comforting thought.

Well, the thing one of the cpufreq userspace programs does is really fine:
based on low-frequency events [power plug-in, running specific programs,
etc.] different cpufreq policies [see above] are selected. No XML file
necessary.

	Dominik

