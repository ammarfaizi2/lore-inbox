Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262988AbVDBEMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262988AbVDBEMb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 23:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbVDBEMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 23:12:31 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:9641 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262988AbVDBEM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 23:12:27 -0500
Date: Fri, 1 Apr 2005 20:11:05 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD64 Machine hardlocks when using memset
Message-Id: <20050401201105.4a03bda1.pj@engr.sgi.com>
In-Reply-To: <424E0424.7080308@shaw.ca>
References: <3NZDp-4yY-7@gated-at.bofh.it>
	<3OmgF-6HV-17@gated-at.bofh.it>
	<3OmgF-6HV-15@gated-at.bofh.it>
	<3Oy8m-74-15@gated-at.bofh.it>
	<424E0424.7080308@shaw.ca>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert wrote:
> It does run visibly slower

The x86_64 memset(), both in user space and the kernel, for whatever gcc
I have, and for a current kernel, uses the "repz stos" or "rep stosq"
prefixed instruction for the bulk of the copy.  This combination is a
long running, interruptible Intel string instruction that loops on
itself until the CX register decrements to zero.

Was your windows app using "stos"?

I'll wager a nickel that the actual crash you see comes when the
processor has to handle an interrupt while in the middle of this
instruction.

I'll wager a dime it's hardware, though interrupt activity may be
required to provoke it.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
