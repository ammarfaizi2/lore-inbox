Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbTJJOp3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 10:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTJJOp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 10:45:29 -0400
Received: from holomorphy.com ([66.224.33.161]:7297 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262814AbTJJOp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 10:45:26 -0400
Date: Fri, 10 Oct 2003 07:47:23 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: G?bor L?n?rt <lgb@lgb.hu>
Cc: Stuart Longland <stuartl@longlandclan.hopto.org>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       Fabian.Frederick@prov-liege.be, linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts
Message-ID: <20031010144723.GC727@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	G?bor L?n?rt <lgb@lgb.hu>,
	Stuart Longland <stuartl@longlandclan.hopto.org>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	Fabian.Frederick@prov-liege.be, linux-kernel@vger.kernel.org
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be> <20031009115809.GE8370@vega.digitel2002.hu> <20031009165723.43ae9cb5.skraw@ithnet.com> <3F864F82.4050509@longlandclan.hopto.org> <20031010125137.4080a13b.skraw@ithnet.com> <3F86BD0E.4060607@longlandclan.hopto.org> <20031010143529.GT5112@vega.digitel2002.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031010143529.GT5112@vega.digitel2002.hu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 04:35:29PM +0200, G?bor L?n?rt wrote:
> Why? Sure, you should note OS before unplug a CPU ;-) but in this case OS
> should be noticed that it could not use that CPU any more (like scheduler,
> interrupt delivering etc). And then it's not an issue if you unplug THAT
> cpu. Sure, some hw supporting is needed, a "normal" motherboard does not
> like to unplug a CPU when powered of course by hardware issues, but "CPU
> hotplug capable" motherboards can support this. Maybe of course some notice
> mechanism is needed for the motherboard as well not only for the OS, but it
> only mean that notfication before unplugging the CPU should be delivered to
> the OS _and_ to the hardware. Sure, I have no experience at all in this
> area, so this is only a theory (I've never see a hardware support this yet).

You need at least enough warning to get out of critical sections (e.g.
holding a spinlock) and dump registers out to memory. i.e. as long as it
takes to schedule out whatever's currently running on the thing.

... and unless you want to start enforcing realtime bounds, the answer
to "how long do you have to give the kernel to do it?" is "forever".
In practice, it won't take forever, but no finite time is enforcible.


-- wli
