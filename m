Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbUCDLkE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 06:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbUCDLkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 06:40:04 -0500
Received: from zero.aec.at ([193.170.194.10]:64260 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261844AbUCDLkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 06:40:00 -0500
To: Dave Jones <davej@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.2, AMD kernel: MCE: The hardware reports a non fatal,
 correctable incident
References: <1vmlH-3HK-5@gated-at.bofh.it> <1vq6q-7YO-33@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 04 Mar 2004 12:39:59 +0100
In-Reply-To: <1vq6q-7YO-33@gated-at.bofh.it> (Dave Jones's message of "Tue,
 02 Mar 2004 23:00:46 +0100")
Message-ID: <m3llmgj0xc.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:

> I'm toying with the idea of marking it CONFIG_BROKEN for 2.6,
> and fixing it up later.

I would actually suggest to switch over to the rewritten MCE handler
from x86-64 for i386 too. IMHO it is much better. It is race free,
does not panic the machine if not needed, CPU independent, follows the
Intel and AMD recommendations, run time sysfs configurable, logs to a
separate device and does lots of other things much better
[of course I'm biased on that a bit]. Disadvantage is that it isn't
as well tested.

I haven't tried it on i386, but i wrote it to be easily portable
to 32bit too. It does periodic MCEs too, but with a much lower 
frequency and they could be turned off. I'm considering to turn
them off for x86-64 too, because they seem to only log one bit
ECC errors all the time. But with the new separate log device it's much
less of a problem.

The only thing you would lose is the support for P5 MCEs, but these
could be relatively easily readded if that should be a problem.
Extended register logging for P4 is also not implemented right now,
but that hardly seems like a needed feature.

-Andi

