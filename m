Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268765AbUIQNrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268765AbUIQNrz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 09:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268764AbUIQNrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 09:47:55 -0400
Received: from holomorphy.com ([207.189.100.168]:29100 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268757AbUIQNrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 09:47:48 -0400
Date: Fri, 17 Sep 2004 06:47:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Message-ID: <20040917134737.GS9106@holomorphy.com>
References: <20040915151815.GA30138@elte.hu> <20040917103945.GA19861@elte.hu> <20040917132641.GR15426@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040917132641.GR15426@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 12:39:45PM +0200, Ingo Molnar wrote:
>> task not migrating to another CPU within the BLK critical section?

On Fri, Sep 17, 2004 at 03:26:41PM +0200, Andrea Arcangeli wrote:
> I very much doubt, I'd expect this to work, but it really should be a
> config option if you don't open 2.7. This is the kind of thing that
> cannot happen in a 2.6.* release without a config option to leave off in
> production IMHO since it can have implications well outside the mainline
> kernel (every driver outside the kernel would be affected too).

IMHO this would be more likely to fix bugs than introduce them so long
as the BKL is acquired before spinlocks in all instances. There are
many instances where scheduling under the BKL is inadvertent and thus
racy, but very few (if any) where the BKL is an inner lock or a holder
of the BKL yields so something that will wake it can acquire the BKL.


-- wli
