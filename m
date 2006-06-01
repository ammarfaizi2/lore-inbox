Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbWFABEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbWFABEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 21:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbWFABEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 21:04:13 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:37783 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S965107AbWFABEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 21:04:12 -0400
Message-ID: <349123849.25214@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 1 Jun 2006 09:04:34 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Adaptive read-ahead V12
Message-ID: <20060601010434.GA5019@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Bill Davidsen <davidsen@tmr.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <348628455.03454@ustc.edu.cn> <447DF9F6.3060302@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447DF9F6.3060302@tmr.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 04:17:58PM -0400, Bill Davidsen wrote:
> Wu Fengguang wrote:
> >----- Forwarded message from Iozone <capps@iozone.org> -----
> >
> >Subject: Adaptive read-ahead V12
> >From: Iozone <capps@iozone.org>
> >To: Wu Fengguang <wfg@mail.ustc.edu.cn>
> >X-Mailer: Microsoft Outlook Express 6.00.2900.2670
> >Date: Thu, 25 May 2006 11:44:37 -0500
> >
> >Wu Fengguang,
> >
> >       I see that Andrew M. is giving you some pushback.... 
> >   His argument is that the application could do a better job
> >   of scheduling its own read-ahead.  ( I've heard this one 
> >   before)
> >
> >   My thoughts on this argument would be along the 
> >   lines of:
> >
> >   Indeed the application might be able to do a better
> >   job, however expecting, or demanding, the rewrite
> >   of all applications to behave better might be an unreasonable
> >   expectation. 
> 
> A reasonable expectation would be that the application would have a way 
> to tell the kernel to ignore readahead for a given file, other than 
> changing the behavior of the kernel as a whole for all processes on the 
> machine. This smart application could then use aio or some other similar 
> method to do preread itself.

Sure. The adaptive readahead works fine with user level readahead via
the readahead() or posix_fadvise() syscall. I.e. if a program do
necessary readahead() calls that can cover all the file pages
requested by the following read() calls, it avoids triggering
unnecessary kernel readaheads.

> My personal opinion is that the kernel only does a good job reading 
> ahead for sequential access, and since that's the common case only a 
> means of preventing that effort need be provided.

posix_fadvise(fd, ..., POSIX_FADV_RANDOM) can do the trick for a file.
blockdev --setra 0 /dev/hda  does so for a device.

Wu
