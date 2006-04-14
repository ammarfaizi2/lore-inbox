Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWDNSx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWDNSx1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 14:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWDNSx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 14:53:27 -0400
Received: from ns2.suse.de ([195.135.220.15]:36294 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751409AbWDNSx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 14:53:26 -0400
Date: Fri, 14 Apr 2006 20:52:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Roland McGrath <roland@redhat.com>
Subject: Re: [patch 21/22] fix non-leader exec under ptrace
Message-ID: <20060414185248.GN27388@opteron.random>
References: <20060413230141.330705000@quad.kroah.org> <20060413230938.GV5613@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413230938.GV5613@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 04:09:38PM -0700, Greg KH wrote:
> -stable review patch.  If anyone has any objections, please let us know.

I tried to reproduce the old bug but I failed, no matter how many
patches I backout. However this isn't the -stable that was advertised
initially if patches like this are merged, given that it's unclear if
the old deadlock will come back or not. If I got an answer within a week
and not with a delay of half year after I posted the fix for the
deadlock we would be in a better shape, since perhaps I could still
reproduce it somehow (I could reproduce it in a reasonable amount of
time half an year ago). It's possible that scheduling and userland
changes may have hidden the deadlock (the deadlock requires buggy
userland and a sigsegv in gdb to reproduce, so if gdb is doing any
better that could be hidding it). It's also possible that the bug was
fixed in some other way, so I will try again after going back to the sp3
codebase that shouldn't have changed *that* much.

All details are in https://bugzilla.novell.com/show_bug.cgi?id=115754
