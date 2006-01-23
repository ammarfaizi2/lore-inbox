Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWAWLFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWAWLFS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 06:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWAWLFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 06:05:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15851 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751274AbWAWLFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 06:05:15 -0500
Subject: Re: Rationale for RLIMIT_MEMLOCK?
From: Arjan van de Ven <arjan@infradead.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060123105634.GA17439@merlin.emma.line.org>
References: <20060123105634.GA17439@merlin.emma.line.org>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 12:05:12 +0100
Message-Id: <1138014312.2977.37.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

`
> 
> 1. What is the reason we're having special treatment
>    for the super-user here?

it's quite common to allow root (or more specific, the right capability)
to override rlimits. Many such security check behave that way so it's
only "just" to treat this one like that as well.


> 2. Why is it the opposite of what 2.6.8.1 and earlier did?

the earlier behavior didn't really make sense, and gave cause to
multimedia apps running as root only to be able to mlock etc etc. Now
this can be dynamically controlled instead.


> 4. Is the default hard limit of 32 kB initialized by the kernel or

the kernel has a relatively low default. The reason is simple: allow too
much mlock and the user can DoS the machine too easy. The kernel default
should be safe, the admin / distro can very easily override anyway.

You may ask: why is it not zero?
It is very useful for many things to have a "small" mlock area. gpg, ssh
and basically anything that works with keys and passwords. Small
relative to the other resources such a process takes (eg kernel stacks
etc).


