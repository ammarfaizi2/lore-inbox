Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263745AbUFFPoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263745AbUFFPoO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 11:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbUFFPoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 11:44:14 -0400
Received: from peabody.ximian.com ([130.57.169.10]:59075 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S263745AbUFFPoK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 11:44:10 -0400
Subject: Re: Using getpid() often, another way? [was Re: clone() <->
	getpid() bug in 2.6?]
From: Robert Love <rml@ximian.com>
To: Russell Leighton <russ@elegant-software.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <40C33A84.4060405@elegant-software.com>
References: <40C1E6A9.3010307@elegant-software.com>
	 <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org>
	 <40C32A44.6050101@elegant-software.com>
	 <40C33A84.4060405@elegant-software.com>
Content-Type: text/plain
Date: Sun, 06 Jun 2004 11:44:10 -0400
Message-Id: <1086536650.2804.20.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 (1.5.8-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-06 at 11:38 -0400, Russell Leighton wrote:

>   Given a code library with some exported functions which CAN be 
> executed outside a particular thread and others that MUST be executed in 
> a particular thread, how can I efficiently prevent or trap using of 
> these functions outside the proper execution context?

Are you sure you cannot use pthreads?  The new implementation (NPTL) has
a lot of improvements, including saner signal handling behavior.

If not, you probably are out of luck.  Best I can think of is somehow
using thread-specific storage, but you would obviously need to index
into it using something OTHER than the PID.  Which basically leaves you
with the stack.  So, unless you could cache the PID in a local
variable..

>  Would gettid() be any better?

If you aren't using CLONE_THREAD, gettid() will just return the PID.
And if you were using CLONE_THREAD, then getpid() would be worthless for
you and you would have to use gettid().  Either way, though, they
basically do the same thing (return current->tid vs. current->pid).

	Robert Love


