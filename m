Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311732AbSCTQFY>; Wed, 20 Mar 2002 11:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311733AbSCTQFO>; Wed, 20 Mar 2002 11:05:14 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52017 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S311732AbSCTQFE>; Wed, 20 Mar 2002 11:05:04 -0500
To: Matthias Scheidegger <mscheid@iam.unibe.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: extending callbacks?
In-Reply-To: <Pine.GSO.4.44.0203191111320.20995-100000@speedy>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Mar 2002 08:59:15 -0700
Message-ID: <m18z8nw7qk.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Scheidegger <mscheid@iam.unibe.ch> writes:

> Hi,
> 
> I've got the following problem: I want to register a callback in a kernel
> structure, but I need to supply an additional argument to my own code. I.e. I
> need a callback
> 
> int (*cb)(int u)
> 
> to really call
> 
> int (*real_cb)(int u, void* my_arg)
> 
> At the moment, I'm only focussing on the i386 architecture.
> In user space, I'd do this by generating some machine code, which takes the
> original args, pushes my_fixed_arg and calls real_cb (using mprotect to make
> the generated code callable). That way I'd use a function
> 
> int (*)(int) create_callback(int (*real_cb)(int, void*), void *arg);
> 
> Is there a good way to do that in the kernel?
> Not necessarily using self modifying code, I'll only use it if I must.

The general case requires self modifying code.  Where do you need this in the
kernel.  For most callbacks the kernel is already passing a fairly generic
parameter you can use.  So this trick should be unnecessary.  

In general it would be better to modify what the kernel is passing the function
than to build up an infrastructure to avoid fixing the code.  Especially
as runtime generated code tends to have a performance penalty.

Eric

