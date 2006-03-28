Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWC1Nqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWC1Nqe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 08:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWC1Nqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 08:46:34 -0500
Received: from mail.vtacs.com ([207.42.84.219]:24760 "EHLO mail.vtacs.com")
	by vger.kernel.org with ESMTP id S932179AbWC1Nqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 08:46:33 -0500
From: "Greg Lee" <glee@swspec.com>
To: <Valdis.Kletnieks@vt.edu>, "'Lee Revell'" <rlrevell@joe-job.com>
Cc: <linux-kernel@vger.kernel.org>, <rmk+kernel@arm.linux.org.uk>
Subject: RE: HZ != 1000 causes problem with serial device shown by git-bisect 
Date: Tue, 28 Mar 2006 08:44:23 -0500
Message-ID: <0f0501c6526d$b95e8490$a100a8c0@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
x-mimeole: Produced By Microsoft MimeOLE V6.00.2900.2670
In-Reply-To: <200603280537.k2S5bLvZ012916@turing-police.cc.vt.edu>
Thread-Index: AcZSKbpWK1i0HSQwS3O+id169pJzlAAQQNLw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I may be misreading Greg's concern, but I got the feeling that he's worried
> that 2.6.16 isn't *really* fixed, but that something is just papering over the
> driver's innate displeasure with HZ==250 (and thus it's likely that in .17 or
> .18 or whenever, some *other* patch will make it re-manifest).

To be clear, I am virtually locked into a 2.6.14.2 kernel since that is what has been
qualified for use in the product.  I am "permitted" to patch the kernel with specifically
justified bug fixes.  If these patches are too broad (a judgment call by a group of
engineer's) then we have to re-qualify  the kernel selection which is the (long) process
that I am trying to avoid.  I performed a git bisect between 2.6.12.6 and 2.6.13 and found
the problem is first noticed when the commit that allows HZ==250 is made.  Support for
this change is pretty wide ranging --- a lot of use of msleep() instead of busy loops,
etc.

I did try the brute force approach, diffed the two kernels (800,000 line diff) and then
looked for any changes related to HZ (diff -Naur kernel1 kernel2 | egrep ^-.*HZ) and then
studied the code that was changed to see if I thought it might be related to this problem.
Given my limited understanding of the kernel code I was really just hoping to get lucky.
That did not prove out which is not surprising since it did not test the cases where the
code did not change and HZ is used and the code is not friendly to HZ != 1000.  This
pretty much leaves me at a dead end with this approach.

Then we decided, what the heck, we'll try the latest kernel (2.6.16) just to see if it is
fixed and voila, it is.  Jumping back one revision to 2.6.15.6 showed that the problem
existed again, so I decided to git-bisect those two versions (I'm down to 9 more
iterations) and then see if the change in those two versions yield any insight into the
core problem.  I'm not very hopeful though since this commit is in the path between
2.6.15.6 and 2.6.16):

commit 33f0f88f1c51ae5c2d593d26960c760ea154c2e2

Author: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date:   Mon Jan 9 20:54:13 2006 -0800

    [PATCH] TTY layer buffering revamp
    
    The API and code have been through various bits of initial review by
    serial driver people but they definitely need to live somewhere for a
    while so the unconverted drivers can get knocked into shape, existing
    drivers that have been updated can be better tuned and bugs whacked out.



So, any recommendations for a better approach?

(please cc replies)

Greg 


