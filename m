Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263815AbUGAD7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbUGAD7a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 23:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbUGAD7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 23:59:30 -0400
Received: from lakermmtao11.cox.net ([68.230.240.28]:14806 "EHLO
	lakermmtao11.cox.net") by vger.kernel.org with ESMTP
	id S263815AbUGAD71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 23:59:27 -0400
In-Reply-To: <20040701033620.GB1564@mail.shareable.org>
References: <20040701033620.GB1564@mail.shareable.org>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0B128D6C-CB13-11D8-947A-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Michael Kerrisk <michael.kerrisk@gmx.net>, linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Table of mmap PROT_* implementations by architecture
Date: Wed, 30 Jun 2004 23:59:25 -0400
To: Jamie Lokier <jamie@shareable.org>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 30, 2004, at 23:36, Jamie Lokier wrote:
> From a study of Linux 2.6.5 source code, and some patches.
> This is based on studying the source, not running tests, so there
> may be errors.
> ======================+================================================ 
> ========
> Requested PROT flags  | ---    R--    -W-    RW-    --X    R-X    -WX   
>   RWX
> ======================+================================================ 
> ========
> [...]
> ppc                   | ---(1) r-x    rwx(5) rwx    r-x(5) r-x     
> rwx(5) rwx
> ppc64                 | ---(1) r-x    rwx(5) rwx    r-x(5) r-x     
> rwx(5) rwx
> ppc (PaX)	      | ---(1) r--    rw-    rw-    r-x    r-x    rw-(2)  
> rw-(2)
> ppc64 (PaX for 2.6)   | ---(1) r--    rw-    rw-    r-x    r-x     
> rw-(2) rw-(2)
> [...]
>
> (1) - In kernel, maybe these pages are readable using "write()"?
>       In each case that is labelled, I'm not sure from reading the  
> code.
>       (Pages are always readable using ptrace(), that's ok, but write()
>       and other kernel reads shouldn't be able to read PROT_NONE  
> pages).

This is wrong for PPC32 and PPC64, see the email written earlier today:

On June 30, 2004, at 00:47, Paul Mackerras wrote:
>> Thus PROT_NONE pages aren't readable from userspace, but it appears
>> they _are_ readable from kernel space.  Is this correct?
>
> No.  Kernel accesses to pages in the user portion of the address space
> (0 .. TASK_SIZE-1) are done using the user permissions.  On classic
> PPC this is implemented (in part) by setting Ks = Kp = 1 in the
> segment descriptors for the user segments, which tells the hardware to
> check the access as if it was a user access even in supervisor mode.
>
> We do the same on ppc64 as well.

Cheers,
Kyle Moffett



