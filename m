Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266493AbUA3Akx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 19:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266497AbUA3Akx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 19:40:53 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:51920
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S266493AbUA3Akv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 19:40:51 -0500
Message-ID: <4019A7EE.301@redhat.com>
Date: Thu, 29 Jan 2004 16:40:14 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040118
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Jamie Lokier <jamie@shareable.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com>	 <401894DA.7000609@redhat.com> <20040129132623.GB13225@mail.shareable.org>	 <40194B6D.6060906@redhat.com>  <20040129191500.GA1027@mail.shareable.org> <1075420794.1592.162.camel@cog.beaverton.ibm.com>
In-Reply-To: <1075420794.1592.162.camel@cog.beaverton.ibm.com>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:

> Another issue with having a separate entry point for vgettimeofday is
> that I don't quite understand how glibc detects if vsyscall is
> available, and how deals with the vsyscall page moving around.

Well, this is indeed a problem which needs an addition solution.  If
we'd look for the symbol, it's automatically handled.  Likewise if the
normal syscall handler does it magically.

If a call to the magic address is needed we'd need from kind of version
information in the vDSO to check for the existence of the extension.
This check needs to be done for every call unless a new-enough kernel is
assumed outright.  One could add a functions to the vDSO which is called
via the symbol table and which returns the necessary information to make
the decision.  The result would have to be stored in a local variable to
avoid making that call over and over again.  This all requires the PIC
setup which makes the whole thing once again more expensive than the
simple implicit table lookup.


-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
