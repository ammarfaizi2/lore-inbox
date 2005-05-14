Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbVENFgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbVENFgJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 01:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVENFgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 01:36:09 -0400
Received: from fire.osdl.org ([65.172.181.4]:37295 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262538AbVENFgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 01:36:05 -0400
Date: Fri, 13 May 2005 22:35:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] kernel/sched.c: remove two unused functions
Message-Id: <20050513223505.7c2b5478.akpm@osdl.org>
In-Reply-To: <20050513004716.GR3603@stusta.de>
References: <20050513004716.GR3603@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> This patch removes the unused functions wait_for_completion_timeout and 
> wait_for_completion_interruptible_timeout.
> 
> Is any usage for them planned or is this patch OK?
> 

>From the changelog for the patch which added these functions:



Adds 3 new completion API calls, which are a straightforward extension of
the current APIs:
  
 int wait_for_completion_interruptible(struct completion *x);
 unsigned long wait_for_completion_timeout(struct completion *x,
                                                   unsigned long timeout);
 unsigned long wait_for_completion_interruptible_timeout(
                        struct completion *x, unsigned long timeout);
  
This enables the conversion of more semaphore-using code to completions.
There is code that cannot be converted right now (and is forced to use
semaphores) because these primitives are missing.  Thomas Gleixner has a
bunch of patches to make use of them.
