Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264924AbUFLVPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264924AbUFLVPw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 17:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264925AbUFLVPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 17:15:52 -0400
Received: from lakermmtao09.cox.net ([68.230.240.30]:10169 "EHLO
	lakermmtao09.cox.net") by vger.kernel.org with ESMTP
	id S264924AbUFLVPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 17:15:51 -0400
In-Reply-To: <20040612135302.Y22989@build.pdx.osdl.net>
References: <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <20040611201523.X22989@build.pdx.osdl.net> <C636D44C-BC2B-11D8-888F-000393ACC76E@mac.com> <20040612135302.Y22989@build.pdx.osdl.net>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ADFD1FB4-BCB5-11D8-888F-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: In-kernel Authentication Tokens (PAGs)
Date: Sat, 12 Jun 2004 17:15:50 -0400
To: Chris Wright <chrisw@osdl.org>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 12, 2004, at 16:53, Chris Wright wrote:
> Actually that's not the case.  The UID is currently insufficient to
> describe the security domain that a process is running in.  The whole
> of the LSM infrastructure is designed with this in mind.  So somehting
> like SELinux may enforce a security domain change (w/out a UID change)
> across an execve() of pagsh.  I was simply trying to ascertain if you
> were storing this within task->user which I think would be wrong.

Ahh, ok, I myself have no experience with LSM, so there will likely be 
some
need to change my implementation.  Currently the only field that I add 
to
existing structures in the kernel is a pag field in the task_struct.  
PAG
structures themselves need some way of determining if the calling task
is in the same "grouping" as a stored "grouping" within the PAG.  My
implementation uses UIDs, but I would be very glad if you could tell me
what I should use instead.  I need some kind of structure or pointer 
that I
can embed within a PAG and a token, and some kind of equality test.

The other thing that needs to be implemented is some kind of limit that
restricts how many PAGs/tokens and how much memory can be allocated
in the kernel per user and per process.  Do you have any information on
where would be the best place to store that information?

Cheers,
Kyle Moffett

