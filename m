Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUEKFYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUEKFYb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 01:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUEKFYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 01:24:31 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:40613 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263020AbUEKFY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 01:24:28 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       randy.dunlap@osdl.org, Sam Ravnborg <sam@ravnborg.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Sort kallsyms in name order: kernel shrinks by 30k 
In-reply-to: Your message of "Tue, 11 May 2004 15:08:55 +1000."
             <1084252135.31802.312.camel@bach> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 11 May 2004 15:23:28 +1000
Message-ID: <22374.1084253008@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2004 15:08:55 +1000, 
Rusty Russell <rusty@rustcorp.com.au> wrote:
>Admittedly, anyone who sets CONFIG_KALLSYMS doesn't care about space,
>it's a fairly trivial change.
>
>Name: Sort Kallsyms for Stem Compression
>Status: Booted on 2.6.6
>Depends: Misc/kallsyms-include-aliases.patch.gz
>
>Leaving the symbols sorted by name rather than address, so stem
>compression works more effectively.  Saves a little over 30k here.

Not sure this is a good idea.  proc_pid_wchan() calls kallsyms_lookup()
and has been identified as a bottleneck on systems with a large number
of processes.  top can consume a complete cpu out of 128 cpus, all
because of this bottleneck.  I was toying with the idea of doing a
binary chop on the address lookup, but this patch prevents that fix.

