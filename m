Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbVBXQVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbVBXQVh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 11:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVBXQUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 11:20:30 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:24490 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262410AbVBXQPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 11:15:49 -0500
Subject: Re: [PATCH] CKRM [7/8]  Resource controller for number of tasks
	per class
From: Dave Hansen <haveblue@us.ibm.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ckrm-tech@lists.sourceforge.net
In-Reply-To: <E1D4FOI-0006wW-00@w-gerrit.beaverton.ibm.com>
References: <E1D4FOI-0006wW-00@w-gerrit.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 24 Feb 2005 08:15:43 -0800
Message-Id: <1109261743.7244.64.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-24 at 01:34 -0800, Gerrit Huizenga wrote:
> This patch provides a resource controller for limiting the number
> of tasks per class in CKRM.

It takes 627 lines of code to count the number of tasks in a class?
What does all of that infrastructure buy you, again?

All of the logic to borrow if you've gone over your limit should be a
quite repeated theme throughout all of the controllers.  Seems to me
that at least a larger chunk of that should be in generic code.  

> +static void numtasks_res_free(void *my_res)
> +{
...
> +       if (unlikely(atomic_read(&res->cnt_cur_alloc) < 0)) {
> +               printk(KERN_WARNING "numtasks_res: counter below 0
> \n");
> +       }
> +       if (unlikely(atomic_read(&res->cnt_cur_alloc) > 0 ||
> +                               atomic_read(&res->cnt_borrowed) > 0)) 

How often is this called?  Do you really need unlikely()?

-- Dave

