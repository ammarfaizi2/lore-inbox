Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbVKKMp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVKKMp3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 07:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVKKMp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 07:45:29 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:6276 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750718AbVKKMp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 07:45:28 -0500
Subject: Re: [PATCH] poll(2) timeout values
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ulrich Drepper <drepper@gmail.com>
Cc: Peter Staubach <staubach@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <a36005b50511101649l744f78c1i76133434be7304e8@mail.gmail.com>
References: <437375DE.1070603@redhat.com>
	 <1131642956.20099.39.camel@localhost.localdomain>
	 <a36005b50511101049vf20cde5m9385c433e18dcd2d@mail.gmail.com>
	 <1131662022.20099.44.camel@localhost.localdomain>
	 <a36005b50511101649l744f78c1i76133434be7304e8@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 11 Nov 2005 13:16:07 +0000
Message-Id: <1131714967.3174.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-11-10 at 16:49 -0800, Ulrich Drepper wrote:
> On 11/10/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > No. The poll POSIX libc call takes an int. What the kernel ones does
> > with the top bits is irrelevant to applications.
> 
> The issue is that if the high bits are not handled special then
> somebody might cause problems.  E.g., overflowing the division or so. 
> Therefore the kernel has to sanitize the argument and then why not use
> the easiest way to do this?

Why does the kernel have to sanitize the input. Last time I checked
undefined inputs gave undefined outputs in the standards. fopen(NULL,
NULL) seems to crash glibc for example.

The kernel has to behave correctly given valid sensible inputs. Masking
the top bits is not behaving correctly

	"sleep ages"
	"no I'll sleep a short time"

Surely it would be far better to do

	if((timeout >> 31) >> 1) 
		return -EINVAL;

for 64bit systems

