Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbTFJURP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbTFJUQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:16:03 -0400
Received: from chaos.analogic.com ([204.178.40.224]:23169 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262299AbTFJUOn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 16:14:43 -0400
Date: Tue, 10 Jun 2003 16:31:37 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: David Schwartz <davids@webmaster.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: Large files
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKEECGDJAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.53.0306101621380.6382@chaos>
References: <MDEHLPKNGKAHNMBLJOLKEECGDJAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jun 2003, David Schwartz wrote:

>
> > With 32 bit return values, ix86 Linux has a file-size limitation
> > which is currently about 0x7fffffff. Unfortunately, instead of
> > returning from a write() with a -1 and errno being set, so that
> > a program can do something about it, write() executes a signal(25)
> > which kills the task even if trapped. Is this one of those <expletive
> > deleted> POSIX requirements or is somebody going to fix it?
>
> 	If the program were smart enough to do something sane about it, it should
> be smart enough to handle the signal correctly. What do you think should
> happen if a program compiled today calls 'time' in 2039? You want to shut
> down the program as quickly as possible before it does something insane.
>
> 	DS
>

A trap on that signal doesn't even allow a longjump() to recover!
The signal can be trapped, but the kernel kills the task anyway.
All you can do is make the program print something else than
the "File too large" default. It's sick, very sick. The file-too-
big problem should have been handled properly by the kernel. The
kernel has no business making a policy decision. If the file is
getting too big, the kernel should fail to write any more than
the maximum allowable and return the correct information in the
defined API. It must not make a policy decision and kill the
task.

This has far-reaching consequences.

Even opening the file with large file attributes can result in
the file getting to large eventually. The kernel must not blow
away a task because it "thinks" something. It is not allowed to
"think". It is not allowed to generate policy.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

