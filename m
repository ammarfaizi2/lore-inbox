Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265356AbUFSJzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265356AbUFSJzI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 05:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265360AbUFSJzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 05:55:08 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:7758 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265356AbUFSJzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 05:55:04 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.7] bug_smp_call_function 
In-reply-to: Your message of "Sat, 19 Jun 2004 02:44:16 MST."
             <20040619024416.065f4026.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 19 Jun 2004 19:54:54 +1000
Message-ID: <5874.1087638894@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2004 02:44:16 -0700, 
Andrew Morton <akpm@osdl.org> wrote:
>Keith Owens <kaos@sgi.com> wrote:
>>
>>  sg.c has been fixed to no longer call vfree() with interrupts disabled.
>>  Change smp_call_function() from WARN_ON to BUG_ON when interrupts are
>>  disabled.  It was only set to WARN_ON because of sg.c.
>
>I prefer the WARN_ON.  It is exceedingly unlikely that the bug will cause
>lockups or memory/data corruption or anything else, so why nuke the user's
>box when we can trivially continue?
>
>We'll be sent the bug report either way.

I prefer to catch this bug every time instead of assuming that somebody
will see the report in the syslog.  Once the kernel code is clean
(which it should be now), BUG_ON() will prevent any new code
reintroducing this error.

