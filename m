Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932665AbVKXWeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbVKXWeL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 17:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbVKXWeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 17:34:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30614 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932665AbVKXWeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 17:34:09 -0500
Message-ID: <43863F92.80707@redhat.com>
Date: Thu, 24 Nov 2005 14:32:50 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SMP alternatives
References: <1132766489.7268.71.camel@localhost.localdomain>	 <4384AECC.1030403@zytor.com>	 <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org>	 <1132782245.13095.4.camel@localhost.localdomain>	 <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org>	 <20051123214835.GA24044@nevyn.them.org>	 <Pine.LNX.4.64.0511231416490.13959@g5.osdl.org>	 <20051123222056.GA25078@nevyn.them.org>	 <Pine.LNX.4.64.0511231502250.13959@g5.osdl.org>	 <20051123234256.GA27337@nevyn.them.org>
In-Reply-To: <20051123234256.GA27337@nevyn.them.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/05, Daniel Jacobowitz <dan@debian.org> wrote:
> Those are the wrong ways of doing this in userspace.  There are right
> ways.  For instance, tag the binary at link time "single-threaded".

This works and the system is designed this way.  But it's unlikely
that any distribution will ship code like this since the maintenance
is to problematic.


> Glibc does not do this to the best of my knowledge.  It does select
> different code paths in various places based on the presence of
> multiple threads, but that's for cancellation, not for locking.

Wrong.  Linus is right, we jump over lock prefix.  After a lot of
benchmarking I found this to be the fastest was and the Intel people
seemed to agree.


> This is also a trivially solvable problem in userspace; you make the
> dynamic linker enforce consistency of the tags.

This would require that potentially every single DSO is duplicated as
threaded and non-threaded.  If you like this you might as well enter
the horror world of BSD with their libc_r.  This will never fly, the
support costs are too high.


> The number of userspace libraries that use atomic operations is, in
> practice, quite small.

It really not and the number using them is growing.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
