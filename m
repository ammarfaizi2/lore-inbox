Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbUB0CH3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 21:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbUB0CH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 21:07:29 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:13486 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261446AbUB0CH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 21:07:26 -0500
Subject: Re: Why no interrupt priorities?
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: tim.bird@am.sony.com, mgross@linux.co.intel.com
Content-Type: text/plain
Organization: 
Message-Id: <1077839238.2233.14.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 Feb 2004 18:47:18 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Bird writes:

> What's the rationale for not supporting interrupt priorities
> in the kernel?
>
> We're having a discussion of this in one of our CELF working
> groups, and it would help if someone could explain why an
> interrupt priority system has never been adopted in the
> mainstream Linux kernel. (I know that some implementations
> have been written and proposed).
>
> Is there a strong policy against such a thing, or is it just
> that the right implementation has not come along?

Simple reason: shared interrupts

Besides that, what you'd really want is a mask, not
a level. You might like to block out all network
interrupts while still allowing SCSI interrupts.
At some other time, you'd like the opposite.
None of the common hardware (PC, Mac, etc.) is at
all friendly to using a mask, even if you don't
have shared interrupts.

So the policy is: get in, shut the hardware up,
set a flag or wake something up, and get out.
Interrupt handlers are supposed to be very fast
and simple. Put the real work elsewhere.



