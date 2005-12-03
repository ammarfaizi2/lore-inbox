Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbVLCBKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVLCBKE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 20:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVLCBKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 20:10:04 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:2286 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751125AbVLCBKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 20:10:03 -0500
Subject: Re: copy_from_user/copy_to_user question
From: Steven Rostedt <rostedt@goodmis.org>
To: Vinay Venkataraghavan <raghavanvinay@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051202224025.39396.qmail@web32108.mail.mud.yahoo.com>
References: <20051202224025.39396.qmail@web32108.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 20:09:59 -0500
Message-Id: <1133572199.32583.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-02 at 14:40 -0800, Vinay Venkataraghavan wrote:
> I have a question regarding copy_to_user and
> copy_from_user, specifically the conditons and
> situations when they can be used.
> 
> Firstly, I guess it is always safe to use these
> funtions when making an ioctl call. 

It's basically safe whenever you can schedule, and you are running on
behalf of a user task (as appose to a kernel thread).

> 
> But my question is: Are there any specific
> circumstances or conditions when these functions don't
> have to be used, but at the same time ensure that no
> page fault occurs and crashes the system.

Sure, they don't need to be used if you don't need to get data to or
from user context.

> 
> The reason I ask is, there is some software that I am
> dealing with that just don't use these functions. 

What is this code and what is it doing?

> 
> Secondly, they seem to use memcpy as opposed to using
> copy_to_user/copy_from_user which is also very
> dangerous.

If they are grabbing data from user context into kernel (or vise versa)
that could easily cause an oops.  Not to mention it is a security risk.

-- Steve


