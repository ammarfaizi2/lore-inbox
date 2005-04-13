Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbVDMGsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbVDMGsO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 02:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVDMGsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 02:48:14 -0400
Received: from mail26.sea5.speakeasy.net ([69.17.117.28]:59332 "EHLO
	mail26.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S262320AbVDMGsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 02:48:10 -0400
Date: Tue, 12 Apr 2005 23:48:09 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Eshwar <eshwar@moschip.com>
cc: "'Tomko'" <tomko@haha.com>, linux-kernel@vger.kernel.org
Subject: RE: Why system call need to copy the date from the userspace before
 using it
Message-ID: <Pine.LNX.4.58.0504122341310.20829@shell2.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2005, Eshwar wrote:

>
> >The quick and simple answer to this question is: data integrity.
>
> >The main thing to understand is that, from the perspective of the
> >kernel, any user input provided in the form of system calls must have
> >immutable data. Only if the data is immutable can the kernel code parse
> >it and decide what to do, without getting into really hairy race
> >conditions. And, for that matter, it's much simpler and less error-prone
> >to program code where you don't have to worry about the inputs changing
> >around you all the time.
>
> Does this approach lead to major performance bottleneck??
>

It should not be so much of a performance bottleneck -- this kind of
operation lends itself naturally to parallelization, since it has few
(if any) dependencies. The only race I can think of off-hand is the
exit() syscall, but I'm sure that's already handled elsewhere (just not
sure of the details) In the end, however, if you believe my previous
email, then you should believe that the copy has to happen in any case.

I don't have any actual data points on-hand. Perhaps someone else does?

-Vadim Lobanov
