Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268122AbUIWAHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268122AbUIWAHv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 20:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268126AbUIWAHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 20:07:51 -0400
Received: from holomorphy.com ([207.189.100.168]:33490 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268122AbUIWAHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 20:07:49 -0400
Date: Wed, 22 Sep 2004 17:07:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Thomas Habets <thomas@habets.pp.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
Message-ID: <20040923000733.GT9106@holomorphy.com>
References: <200409230123.30858.thomas@habets.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409230123.30858.thomas@habets.pp.se>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 01:23:08AM +0200, Thomas Habets wrote:
> How about a sysctl that does "for the love of kbaek, don't ever kill these 
> processes when OOM. If nothing else can be killed, I'd rather you panic"?
> Examples for this list would be /usr/bin/vlock and /usr/X11R6/bin/xlock. 
> I just got a very uncomfortable surprise when found my box unlocked thanks to 
> this.
> After playing around a bit, I made the patch below, but it's almost
> completely untested. I'm not even sure I take the binaries name from
> the right place. And I don't know if the locking can race. If it's
> too ugly then it'd be great if someone implemented it the right way.
> (iow: huge fucking disclaimer)
> echo "/usr/bin/vlock /usr/X11R6/bin/xlock" > /proc/sys/vm/oom_pardon

Assuming this is desirable (otherwise, why would you have written it?)

(1) uts_sem isn't the right lock.
(2) You acquire uts_sem under tasklist_lock, a deadlock.
(3) It would probably make more sense to dynamically register and
	unregister the various criteria for exempt processes than mess
	with space-separated fields of a single string.


-- wli
