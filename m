Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268678AbUILLcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268678AbUILLcW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 07:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268685AbUILL3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:29:05 -0400
Received: from cantor.suse.de ([195.135.220.2]:14785 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268682AbUILLY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:24:58 -0400
Date: Sun, 12 Sep 2004 13:24:54 +0200
From: Andi Kleen <ak@suse.de>
To: Tejun Heo <tj@home-tj.org>
Cc: linux-kernel@vger.kernel.org, zwane@fsmlabs.com
Subject: Re: [PATCH] Interrupt entry CONFIG_FRAME_POINTER fix
Message-Id: <20040912132454.6cf1d60c.ak@suse.de>
In-Reply-To: <20040912091628.GB13359@home-tj.org>
References: <20040912091628.GB13359@home-tj.org>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Sep 2004 18:16:28 +0900
Tejun Heo <tj@home-tj.org> wrote:

>  On x86_64, rbp isn't saved on entering interrupt handler even when
> CONFIG_FRAME_POINTER is turned on.  This breaks profile_pc()
> (resulting in oops) which uses regs->rbp to track back to the original
> stack.  Save full stack when CONFIG_FRAME_POINTER is specified.


I don't think your patch is correct, you don't restore rbp ever and it gets corrupted.

I think the correct change is to fix profile_pc() to not reference rbp, but just hardcode
the rsp offset for the FP and non FP cases (8 and 0) 

-Andi

