Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262928AbTJNSps (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 14:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbTJNSps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 14:45:48 -0400
Received: from nondot.cs.uiuc.edu ([128.174.245.159]:63673 "EHLO nondot.org")
	by vger.kernel.org with ESMTP id S262928AbTJNSor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 14:44:47 -0400
Date: Tue, 14 Oct 2003 14:00:54 -0500 (CDT)
From: Chris Lattner <sabre@nondot.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [x86] Access off the bottom of stack causes a segfault?
In-Reply-To: <Pine.LNX.4.56.0310141136080.2098@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.44.0310141358420.4165-100000@nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Generated code:
> >         .intel_syntax
> > ...
> > main:
> >         mov DWORD PTR [%ESP - 16004], %EBP    # Save EBP to stack
>                          ^^^^^^^^^^^^
>
> Yes, this is the problem (even Windows does that IIRC).

Ok, I realize what's going on here.  The question is, why does the linux
kernel consider this to be a bug?  Where (in the X86 specs) is it
documented that it's illegal to access off the bottom of the stack?

My compiler does a nice leaf function optimization where it does not even
bother to adjust the stack for leaf functions, which eliminates the adds
and subtracts entirely from these (common) functions.  This completely
invalidates the optimization.

Since I'm going to have to live with lots of preexisting kernels, it looks
like I'm going to have to disable it entirely, which is disappointing.
I'm still curious though why this is thought to be illegal.

-Chris

-- 
http://llvm.cs.uiuc.edu/
http://www.nondot.org/~sabre/Projects/

