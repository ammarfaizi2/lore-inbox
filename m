Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268432AbUHLA2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268432AbUHLA2l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 20:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268363AbUHLA1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:27:47 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:14279 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S268444AbUHLACG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 20:02:06 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH][2.6] Completely out of line spinlocks / i386 
In-reply-to: Your message of "Wed, 11 Aug 2004 15:13:15 MST."
             <Pine.LNX.4.58.0408111511380.1839@ppc970.osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 12 Aug 2004 10:01:50 +1000
Message-ID: <23701.1092268910@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2004 15:13:15 -0700 (PDT), 
Linus Torvalds <torvalds@osdl.org> wrote:
>
>
>On Wed, 11 Aug 2004, Pavel Machek wrote:
>> 
>> Fine, so perhaps we do not want config option?
>
>The inline spinlocks are _wonderful_ for seeing where the contention is in 
>a simple profile.
>
>In contrast, in a profile the out-of-lines ones will show "x% was spent on 
>spinlocks". Which doesn't help much when you want to see where the problem 
>is.
>
>This was _hugely_ useful, at least for me, for seeing what locks were 
>problematic.

Tweak the profile code to detect that the instruction pointer is in the
out of line spinlock code and replace the ip with the caller's ip.  We
already do that for ia64, where the out of line spinlock code is a big
win.  A kdb backtrace on an ia64 contended lock will even decode the
address of the lock, which is only possible because the lock address is
in a known location for this case.

