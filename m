Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbTEGR1W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 13:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264150AbTEGR1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 13:27:21 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33036 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264147AbTEGR1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 13:27:12 -0400
Date: Wed, 7 May 2003 10:39:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: mikpe@csd.uu.se
cc: Dave Jones <davej@codemonkey.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] restore sysenter MSRs at resume
In-Reply-To: <16057.16684.101916.709412@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.44.0305071033400.2997-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 May 2003 mikpe@csd.uu.se wrote:
> 
> We don't do apm suspend/resume on SMP, so this is no different from the
> current situation. I don't know if acpi does it or not.

Well, the thing is, if we ever do want to support it (and I suspect we 
do), we should have the infrastructure ready. It shouldn't be too hard to 
support SMP suspend in a 2.7.x timeframe, since it from a technology angle 
looks like simply hot-plug CPU's. Some of the infrastructure for that 
already exists.

But I seriously doubt we want to do CPU hot-plug as a device driver. 
Having a hook in place for it in the arch directory will make it easyish 
to add once we integrate all the other hotplug code (which is very 
unlikely in the 2.6.x timeframe).

> I could probably get away with simply having apm.c invoke the C code
> in suspend.c, which does restore the SYSENTER MSRs. suspend.c itself
> doesn't seem to depend on the SOFTWARE_SUSPEND machinery, but
> suspend_asm.S does.
> 
> Does that sound reasonable?

Sounds reasonable to me. In fact, it looks like it really already exists
as the current "restore_processor_state()" thing.

In fact, that one already _does_ call "enable_sep_cpu()", so what's up?

		Linus

