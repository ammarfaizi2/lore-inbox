Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933731AbWKSXZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933731AbWKSXZR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 18:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933733AbWKSXZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 18:25:17 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44431 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933731AbWKSXZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 18:25:16 -0500
Date: Sun, 19 Nov 2006 15:21:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] PM: suspend/resume debugging should depend on 
 SOFTWARE_SUSPEND
In-Reply-To: <200611192225.52074.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.64.0611191518170.3692@woody.osdl.org>
References: <200611190320_MC3-1-D21B-111C@compuserve.com> <200611191955.23782.rjw@sisk.pl>
 <Pine.LNX.4.64.0611191153200.3692@woody.osdl.org> <200611192225.52074.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Nov 2006, Rafael J. Wysocki wrote:
> > concept works anywhere that has a CMOS chip, so if somebody were to spend 
> > a few minutes testing it on x86-64 and others, it would work elsewhere 
> > too..
> 
> I can do that if someone gives me the code.

Well, I actually _think_ it works almost as-is on x86-64 too, but the 
magic is all in that small inline asm thing in <linux/resume-trace.h>.

The ".long" in that inline asm probably needs to be a ".quad" - see gow 
"generate_resume_trace()" uses it.

Also the "show_file_hash()" right now has a "tracedata += 6", and it 
should probably be "tracedata += 2 + sizeof(void *)" instead.

IOW, it really should be very easy to get to work on x86-64, I just 
haven't had the energy or inclination, since the only devices I've 
personally used it on have been regular 32-bit ones..

		Linus
