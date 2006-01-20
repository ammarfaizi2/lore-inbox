Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWATRgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWATRgp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 12:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWATRgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 12:36:45 -0500
Received: from c-67-174-241-67.hsd1.ca.comcast.net ([67.174.241.67]:9406 "EHLO
	plato.virtuousgeek.org") by vger.kernel.org with ESMTP
	id S1750776AbWATRgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 12:36:44 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Brent Casavant <bcasavan@sgi.com>
Subject: Re: [PATCH] SN2 user-MMIO CPU migration
Date: Fri, 20 Jan 2006 09:36:20 -0800
User-Agent: KMail/1.9
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, jes@sgi.com,
       tony.luck@intel.com
References: <20060118163305.Y42462@chenjesu.americas.sgi.com> <200601191818.43157.jbarnes@virtuousgeek.org> <20060120003303.O81637@chenjesu.americas.sgi.com>
In-Reply-To: <20060120003303.O81637@chenjesu.americas.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601200936.21111.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 19, 2006 10:47 pm, Brent Casavant wrote:
> On Thu, 19 Jan 2006, Jesse Barnes wrote:
> > Maybe you could just turn the above into mmiowb() calls instead? 
> > That would cover altix, origin, and ppc as well I think.  On other
> > platforms it would be a complete no-op.
>
> As you obviously noted, the core of the code was lifted from mmiowb().
> But no, an mmiowb() as such isn't correct.  At the time this code is
> executing, it's on a CPU remote from the one which issued any PIO
> writes to the device.  So in this case we need to poll the Shub
> register for a remote node, but mmiowb() only polls for the Shub
> corresponding to the current CPU.

Ah, ok.  It sounds like Ingo might have a better place to put it anyway.  
(I was thinking this was on the switch out path on the CPU where the 
task last ran, didn't look at it in detail.)

Of course, the other option is just to require tasks that do MMIO 
accesses from userspace to be pinned to particular CPU or node. :)

Thanks,
Jesse
