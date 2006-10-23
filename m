Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWJWPfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWJWPfp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 11:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWJWPfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 11:35:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45953 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964959AbWJWPfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 11:35:44 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Yinghai Lu" <yinghai.lu@amd.com>
Cc: "Andi Kleen" <ak@muc.de>, "Muli Ben-Yehuda" <muli@il.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Adrian Bunk" <bunk@stusta.de>
Subject: Re: [PATCH] x86_64 irq: reuse vector for set_xxx_irq_affinity in phys flat mode
References: <86802c440610230002x340e3f95pa8ee98caa02e7e@mail.gmail.com>
Date: Mon, 23 Oct 2006 09:32:57 -0600
In-Reply-To: <86802c440610230002x340e3f95pa8ee98caa02e7e@mail.gmail.com>
	(Yinghai Lu's message of "Mon, 23 Oct 2006 00:02:44 -0700")
Message-ID: <m1ac3nvyhi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Yinghai Lu" <yinghai.lu@amd.com> writes:

> in phys flat mode, when using set_xxx_irq_affinity to irq balance from
> one cpu to another,  _assign_irq_vector will get to increase last used
> vector and get new vector. this will use up the vector if enough
> set_xxx_irq_affintiy are called. and end with using same vector in
> different cpu for different irq. (that is not what we want, we only
> want to use same vector in different cpu for different irq when more
> than 0x240 irq needed). To keep it simple, the vector should be resued
> from one cpu to another instead of getting new vector.
>
> Signed-off-by: Yinghai Lu <yinghai.lu@amd.com>

YH.  I think the concept is sound.  I don't think this is a bug fix, just
an optimization so this may not be 2.6.19 material.  But we are thrashing
things so much it may make sense to include it, and it likely to keeps
us from running into problems, so it can be called a bug preventative :)

Beyond that I have a few nits to pick with the patch.
- We duplicate the code that claims a new vector which makes
  maintenance a pain.
- The comments are specific to phys_flat but the code is not.
- The test for being able to use the old_vector in the new domain
  should be: ...[old_vector] == vector || ...[old_vector] == -1

Eric
