Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751810AbWCNOCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbWCNOCE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 09:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbWCNOCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 09:02:04 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:9646 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751810AbWCNOCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 09:02:00 -0500
Subject: Re: What is ptrace flag PT_TRACESYSGOOD for?
From: "Charles P. Wright" <cwright@cs.sunysb.edu>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200603140531_MC3-1-BAA0-B3C3@compuserve.com>
References: <200603140531_MC3-1-BAA0-B3C3@compuserve.com>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 09:01:54 -0500
Message-Id: <1142344915.11982.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 05:26 -0500, Chuck Ebbert wrote:
> I am trying to document PTRACE_SETOPTIONS and I can't figure out what
> the option PTRACE_O_TRACESYSGOOD is used for.  Google is no help;
> I can't find an explanation for _why_ it's there.  All I can see is that
> it causes ptrace() to deliver syscall stops with SIGTRAP | 0x80
> instead of just SIGTRAP and it can be used with PTRACE_SYSEMU.
Chuck,

The PTRACE_O_TRACESYSGOOD is useful, because it allows you to
differentiate between a standard SIGTRAP and a system call entry or
exit.  For example, if you have a ptrace monitor and receive a SIGTRAP,
without O_SYSGOOD, it isn't clear if the kernel returned from wait (1)
because someone did kill -TRAP pid, or (2) the process was entering a
system call.

Charles

