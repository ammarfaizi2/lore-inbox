Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbVHRQwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbVHRQwS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 12:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbVHRQwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 12:52:18 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:44791 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932299AbVHRQwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 12:52:17 -0400
Subject: Re: [QUESTION] Why isn't there a unregister_die_notifier?
From: Steven Rostedt <rostedt@goodmis.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <p73br3vtdc4.fsf@verdi.suse.de>
References: <1124377142.5186.45.camel@localhost.localdomain.suse.lists.linux.kernel>
	 <p73br3vtdc4.fsf@verdi.suse.de>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 18 Aug 2005 12:52:09 -0400
Message-Id: <1124383929.5186.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-18 at 18:32 +0200, Andi Kleen wrote:
> Steven Rostedt <rostedt@goodmis.org> writes:
> 
> > Hi, I have a debugging module that I want to register a die notifier.
> > But I just noticed that I can't unregister it.  So for now I either just
> > keep the module loaded and never unloaded it, compile it into the
> > kernel, or ifdef out the register_die_notifier when loaded as a module.
> > 
> > Is there some reason that there isn't such a call, or maybe there is,
> > and I don't see it (called something else). Or is this something that
> > should be added?
> 
> I didn't add one original because unloading debuggers is very tricky.
> There is no locking and no reference counting and they can be entered
> in any context.  Adding it would require some RCU tricks at least and
> might still have some non trivial races.

Yeah, I use macros to call all the debugger code and spinlocks to
protect them. The macros change when the module is built into the kernel
to not do any protection, since it isn't needed.  It's not the most
efficient thing, and RCU would probably be better. But I can insert and
remove this module over and over with the debugging going on, and it
hasn't broke yet. But I guess, I'll just do without for now.

-- Steve


