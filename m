Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263832AbUAMKoQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 05:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbUAMKoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 05:44:16 -0500
Received: from gprs214-71.eurotel.cz ([160.218.214.71]:2432 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263832AbUAMKoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 05:44:15 -0500
Date: Tue, 13 Jan 2004 11:45:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is this too ugly to merge?
Message-ID: <20040113104552.GA269@elf.ucw.cz>
References: <1073609923.2003.10.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073609923.2003.10.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> My question, then (at last!) is, are these 'too ugly', so that they'd
> never get merged? If you do consider them ugly, is it because you'd like
> to see better names (lower case? replace SWSUSP?) and/or because you
> think the whole idea is ugly and have a better solution?

Well, problem is not as much with uglyness of those macros, but with
need to patch many files to include those macros. If you can get
number of uses of those macros down to, say, 10, it will get
better. Can't you just do something at each syscall/pagefault
entry/exit?

Ordinarily, process get stopped by sending them SIGSTOP. That suggests
to me that we might be able to reuse existing mechanism... SIGSTOP-ed
task should not hold any locks since it can be SIGSTOPed for very long
time. And if SIGSTOP does not work properly ... well that would be
simple bugfix.

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
