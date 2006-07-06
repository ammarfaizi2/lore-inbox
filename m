Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbWGFQ2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWGFQ2I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 12:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbWGFQ2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 12:28:07 -0400
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:47807 "EHLO
	mail6.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S964949AbWGFQ2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 12:28:06 -0400
Date: Thu, 6 Jul 2006 09:28:05 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Ulrich Drepper <drepper@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix poll() nfds check.
In-Reply-To: <a36005b50607060844s6c19fb3fp6e91eb1dc86dfbec@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0607060923440.21972@shell3.speakeasy.net>
References: <Pine.LNX.4.58.0607051949460.6604@shell3.speakeasy.net> 
 <20060705203959.53e128ef.akpm@osdl.org> <a36005b50607060844s6c19fb3fp6e91eb1dc86dfbec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2006, Ulrich Drepper wrote:

> On 7/5/06, Andrew Morton <akpm@osdl.org> wrote:
> > [EINVAL]
> >     The nfds argument is greater than {OPEN_MAX}, or ...
>
> This requirement must be treated the same way as the EMFILE error in
> open(): ignore the OPEN_MAX limit if ulimit says so.  The question is
> what to do if the ulimit < OPEN_MAX.  POSIX does not require OPEN_MAX
> to be the exact limit.

This interpretation makes more sense to me. No hardcoded magic number
limits where the behavior of the syscall changes.

> So, I think removing the OPEN_MAX comparison is the correct way to do
> this here.  If somebody wants strict POSIX compliance they have to set
> ulimit -n to 256.

Andrew, assuming that you're willing to make this change to the code, I
can redo this patch against the latest rc and resend, if that'll make it
easier to apply.

-- Vadim Lobanov
