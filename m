Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261519AbREYSto>; Fri, 25 May 2001 14:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261616AbREYSte>; Fri, 25 May 2001 14:49:34 -0400
Received: from [198.99.130.100] ([198.99.130.100]:21508 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S261519AbREYStV>;
	Fri, 25 May 2001 14:49:21 -0400
Message-Id: <200105251749.NAA01282@karaya.com>
X-Mailer: exmh version 2.1.1 10/15/1999
To: dean gaudet <dean-list-linux-kernel@arctic.org>
cc: linux-kernel@vger.kernel.org, Jonathan Lundell <jlundell@pobox.com>,
        Andi Kleen <ak@suse.de>,
        Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        Keith Owens <kaos@ocs.com.au>, Andreas Dilger <adilger@turbolinux.com>
Subject: Re: [CHECKER] large stack variables (>=1K) in 2.4.4 and 2.4.4-ac8 
In-Reply-To: Your message of "Fri, 25 May 2001 11:37:48 PDT."
             <Pine.LNX.4.33.0105251130040.17081-100000@twinlark.arctic.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 25 May 2001 13:49:57 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean-list-linux-kernel@arctic.org said:
> also you don't need the task struct at the top to do this -- you just
> allocate 16k instead of 8k, put the task struct on page 0 of the
> allocation, unmap page 1, and put the stack frame on pages 2 and 3.
> (you'd probably have to do a 16k allocation regardless to get the
> guard page.)

This is exactly what UML does.  My stacks are larger than the host's stacks 
and I was having stack overflow problems when the Linux started saving SSE 
state on signal frames.

So I doubled the stack size and put in a guard page while I was at it.

				Jeff


