Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbTEDWKL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 18:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTEDWKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 18:10:11 -0400
Received: from are.twiddle.net ([64.81.246.98]:30867 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S261790AbTEDWKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 18:10:10 -0400
Date: Sun, 4 May 2003 15:22:27 -0700
From: Richard Henderson <rth@twiddle.net>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Yoav Weiss <ml-lkml@unpatched.org>, linux-kernel@vger.kernel.org
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
Message-ID: <20030504222227.GB6808@twiddle.net>
Mail-Followup-To: Chuck Ebbert <76306.1226@compuserve.com>,
	Yoav Weiss <ml-lkml@unpatched.org>, linux-kernel@vger.kernel.org
References: <200305041027_MC3-1-3758-4298@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305041027_MC3-1-3758-4298@compuserve.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 04, 2003 at 10:25:26AM -0400, Chuck Ebbert wrote:
> asmlinkage int sys_iopl(unsigned long unused)
> {
>         struct pt_regs * regs = (struct pt_regs *) &unused;       <== yuck!
[...]
>   Shouldnt it be like this?
> 
> asmlinkage int sys_iopl (struct pt_regs regs)

No, it should be like 

  int sys_iopl (struct pt_regs *regs)

and assembly language should push the proper address.

The struct-as-argument form allows the compiler to
smash the entire structure as it sees fit.

> fork, clone, vfork and execve all declare it that way...

They're all wrong too.


r~
