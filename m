Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262923AbUJ0V6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262923AbUJ0V6H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 17:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262928AbUJ0Vs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:48:26 -0400
Received: from wingding.demon.nl ([82.161.27.36]:3713 "EHLO wingding.demon.nl")
	by vger.kernel.org with ESMTP id S262720AbUJ0VhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:37:22 -0400
Date: Wed, 27 Oct 2004 23:38:07 +0200
From: Rutger Nijlunsing <rutger@nospam.com>
To: Paulo Marques <pmarques@grupopie.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add p4-clockmod driver in x86-64
Message-ID: <20041027213807.GA9334@nospam.com>
Reply-To: linux-kernel@tux.tmfweb.nl
References: <88056F38E9E48644A0F562A38C64FB600333A69D@scsmsx403.amr.corp.intel.com> <417FB7BA.9050005@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417FB7BA.9050005@grupopie.com>
Organization: M38c
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 03:59:06PM +0100, Paulo Marques wrote:
> Pallipadi, Venkatesh wrote:
> >>....
> >Yes. Clock modulation is not as useful compared to enhanced speedstep.
> >But, 
> >I feel, it should be OK to have the driver, though it is not really
> >useful 
> >in common case. It may be useful in some exceptional cases. 
> 
> I think I have one of such cases.
> 
> I am one of the members of the robotic soccer team from the University 
> of Oporto, and a couple of months ago we were looking for new 
> motherboards for our robots, because we are starting to need new 
> hardware (on-board lan, usb2.0, etc.).
> 
> We really don't need excepcional performance, but we really, really need 
> low power consumption, so lowering the clock on a standard mainboard 
> seemed to be the best cost/performance scenario.
> 
> Could this driver be used to keep a standard p4 processor at say 25% 
> clock speed at all times?

Nope, p4-clockmod is completely useles. It doesn't slow down the CPU
frequency, it only executes 7000 tick some kind of 'hlt' / 'halt'
instruction out of 8000 ticks (for example, to get 12.5%) just like
Linux's idle routine.

So you've got the _disadvantages_ of a slow clock (programs run
slower), and not the _advantages_ (power consumption is same as idle
CPU and not lower, temperature is same as idle CPU and not lower).

But why does the P4 have such a mode? It uses this mode during thermal
throttling to get to the 'idle' temperature.

Therefore, p4-clockmod is completely misnamed: it's _not_ a cpufreq
driver in the sense that it does not change the frequency. The
documentation should be updated to reflect this (eventually).

In short: p4-clockmod can be emulated in software.

-- 
Rutger Nijlunsing ---------------------------- rutger ed tux tmfweb nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
