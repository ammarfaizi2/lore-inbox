Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbVHRQdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVHRQdB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 12:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbVHRQdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 12:33:01 -0400
Received: from ns.suse.de ([195.135.220.2]:5593 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932285AbVHRQdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 12:33:00 -0400
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] Why isn't there a unregister_die_notifier?
References: <1124377142.5186.45.camel@localhost.localdomain.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 18 Aug 2005 18:32:59 +0200
In-Reply-To: <1124377142.5186.45.camel@localhost.localdomain.suse.lists.linux.kernel>
Message-ID: <p73br3vtdc4.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> Hi, I have a debugging module that I want to register a die notifier.
> But I just noticed that I can't unregister it.  So for now I either just
> keep the module loaded and never unloaded it, compile it into the
> kernel, or ifdef out the register_die_notifier when loaded as a module.
> 
> Is there some reason that there isn't such a call, or maybe there is,
> and I don't see it (called something else). Or is this something that
> should be added?

I didn't add one original because unloading debuggers is very tricky.
There is no locking and no reference counting and they can be entered
in any context.  Adding it would require some RCU tricks at least and
might still have some non trivial races.

-Andi
