Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262472AbSJ0RC2>; Sun, 27 Oct 2002 12:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262474AbSJ0RC1>; Sun, 27 Oct 2002 12:02:27 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37685 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262472AbSJ0RCZ>; Sun, 27 Oct 2002 12:02:25 -0500
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] x86 multiple user-mode privilege rings
References: <1035686893.2272.20.camel@ldb>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 27 Oct 2002 10:06:40 -0700
In-Reply-To: <1035686893.2272.20.camel@ldb>
Message-ID: <m11y6blskf.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Barbieri <ldb@ldb.ods.org> writes:

> Short explaination: 
> This patch implements a feature called "x86 multiring", which is a
> shorthand for x86 multiple user-mode privilege rings support. 
> It allows user-mode programs to create DPL 1 and 2 segments and get a
> modifiable per-process copy of IDT. 
> 
> User Mode Linux can use these features to implement a syscall mechanism
> identical to the one used by the kernel-mode kernel, and thus much
> faster than the current one, with free memory protection and with zero
> context switches. 

But there are privilege switches.
 
> Wine could also use it to achieve fast syscall-level emulation of
> Windows NT (and, to a lesser extent, Windows 3.1 and 9x). 
> 
> Obviously there is some risk of the patch creating security holes. 

Let me get the gist of the idea.
To accelerate UML, and wine type applications:
1) setup segments with restricted limits, so their children cannot
   write into their supervisor process even though they share a mm.
2) load a special system call table that switches processor modes
   when any system call is activated.

Unless I am mistaken all of the above can be accomplished without
using the cpus multiple rings of privilege.  Which would allow nesting
only limited by the address space reduction of each task.

Eric
