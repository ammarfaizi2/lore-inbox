Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbTEDOPq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 10:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbTEDOPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 10:15:46 -0400
Received: from siaag1ab.compuserve.com ([149.174.40.4]:61832 "EHLO
	siaag1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263612AbTEDOPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 10:15:45 -0400
Date: Sun, 4 May 2003 10:25:26 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
To: Yoav Weiss <ml-lkml@unpatched.org>
Cc: linux-kernel@vger.kernel.org
Message-ID: <200305041027_MC3-1-3758-4298@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> btw, I guess that now, at least when X_workaround==1, exploits will focus
> on getting iopl(2) called before they get the actual shellcode called.
> In some cases it may be easy to cause a call to iopl (param doesn't matter
> as long as its not zero).

  I looked at sys_iopl() and it seems to be checking if its param is
> 3, so EBX on the stack must be 0x00000003 to set iopl to 3.

  The declaration is misleading ("unused"???:)

asmlinkage int sys_iopl(unsigned long unused)
{
        struct pt_regs * regs = (struct pt_regs *) &unused;       <== yuck!
        unsigned int level = regs->ebx;
        ...
        if (level > 3)
                return -EINVAL;


  Shouldnt it be like this?

asmlinkage int sys_iopl (struct pt_regs regs)
{
        unsigned int level = regs.ebx;
        ...


fork, clone, vfork and execve all declare it that way...



