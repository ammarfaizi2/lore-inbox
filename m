Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279261AbRKIFL4>; Fri, 9 Nov 2001 00:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279277AbRKIFLq>; Fri, 9 Nov 2001 00:11:46 -0500
Received: from zok.sgi.com ([204.94.215.101]:10626 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S279264AbRKIFLc>;
	Fri, 9 Nov 2001 00:11:32 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives? 
In-Reply-To: Your message of "Fri, 09 Nov 2001 10:59:21 +1100."
             <20011109105921.A6822@krispykreme> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 09 Nov 2001 16:11:23 +1100
Message-ID: <7462.1005282683@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2001 10:59:21 +1100, 
Anton Blanchard <anton@samba.org> wrote:
> 
>> > Are there any speed difference between hard-linked device drivers and
>> > their modular counterparts?
>
>Its worse on some architectures that need to pass through a trampoline
>when going between kernel and module (eg ppc). Its even worse on ppc64
>at the moment because we have a local TOC per module which needs to be
>saved and restored.

Is that TOC save and restore just for module code or does it apply to
all calls through function pointers?

On IA64, R1 (global data pointer) must be saved and restored on all
calls through function pointers, even if both the caller and callee are
in the kernel.  You might know that this is a kernel to kernel call but
gcc does not so it has to assume the worst.  This is not a module
problem, it affects all indirect function calls.

