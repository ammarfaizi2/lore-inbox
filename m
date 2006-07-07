Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWGGDAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWGGDAv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 23:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWGGDAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 23:00:51 -0400
Received: from terminus.zytor.com ([192.83.249.54]:19594 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751147AbWGGDAu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 23:00:50 -0400
Message-ID: <44ADCE5B.9040907@zytor.com>
Date: Thu, 06 Jul 2006 20:00:43 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Vadim Lobanov <vlobanov@speakeasy.net>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix poll() nfds check.
References: <Pine.LNX.4.58.0607051949460.6604@shell3.speakeasy.net>
In-Reply-To: <Pine.LNX.4.58.0607051949460.6604@shell3.speakeasy.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vadim Lobanov wrote:
> Hi,
> 
> This is a trivial patch to fix the nfds check in the poll system call
> implementation. Namely, OPEN_MAX no longer does anything important in
> the kernel, and checking that nfds is greater than max_fdset AND greater
> than OPEN_MAX therefore just seems wrong.
> 
> This brings up a slightly-tangential question: Why do the nfds checks
> exist in select()/poll()? They're not strictly necessary, since bad
> input will be caught later when we validate all the fds, one by one.
> Furthermore, these checks optimize the handling of error cases (which
> should be uncommon) while pessimizing correct usage of the syscalls
> (which should be more common).
> 

The reason for these is presumably to keep applications which uses 
select() to overflow their fd_sets.  Unfortunately fd_set is defined in 
such a way that it's a static size.

Using ulimit seems like a reasonable compromise for this.

	-hpa
