Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVCaPJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVCaPJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 10:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVCaPHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 10:07:10 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:43203 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261429AbVCaPFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 10:05:47 -0500
Date: Thu, 31 Mar 2005 17:05:48 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Yum Rayan <yum.rayan@gmail.com>
Cc: linux-kernel@vger.kernel.org, mvw@planets.elm.net
Subject: Re: [PATCH] Reduce stack usage in acct.c
Message-ID: <20050331150548.GC19294@wohnheim.fh-wedel.de>
References: <df35dfeb05033023394170d6cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df35dfeb05033023394170d6cc@mail.gmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 March 2005 23:39:40 -0800, Yum Rayan wrote:
> 
> Before patch
> ------------
> check_free_space - 128
> do_acct_process - 105
> 
> After patch
> -----------
> check_free_space - 36
> do_acct_process - 44

It is always nice to see enthusiams, but in your case it might be a
bit misguided.  None of the functions you worked on appear to be real
problems wrt. stack usage.

But if you have time to tackle some of these functions, that may make
a real difference:

http://wh.fh-wedel.de/~joern/stackcheck.2.6.11

In principle, all recursive paths should consume as little stack as
possible.  Or the recursion itself could be avoided, even better.  And
some of the call chains with ~3k of stack consumption may be
problematic on other platforms, like the x86-64.  Taking care of those
could result in smaller stacks for the respective platform.

Jörn

-- 
When I am working on a problem I never think about beauty.  I think
only how to solve the problem.  But when I have finished, if the
solution is not beautiful, I know it is wrong.
-- R. Buckminster Fuller
