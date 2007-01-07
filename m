Return-Path: <linux-kernel-owner+w=401wt.eu-S932469AbXAGKUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbXAGKUl (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 05:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbXAGKUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 05:20:41 -0500
Received: from gw.goop.org ([64.81.55.164]:41112 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932469AbXAGKUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 05:20:40 -0500
Message-ID: <45A0C977.4070800@goop.org>
Date: Sun, 07 Jan 2007 02:20:39 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Rene Herman <rene.herman@gmail.com>
CC: Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] romsignature/checksum cleanup
References: <458EEDF7.4000200@gmail.com>  <458F20FB.7040900@gmail.com> <1167179512.16175.4.camel@localhost.localdomain> <459310A3.4060706@vmware.com> <459ABA2F.6070907@gmail.com> <459EDDD1.6060208@goop.org> <459F1B82.6000808@gmail.com> <45A0B660.4060505@goop.org> <45A0B71F.1080704@gmail.com>
In-Reply-To: <45A0B71F.1080704@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:
> How is it for efficiency? I thought it was for correctness.
> romsignature is using probe_kernel_adress() while all other accesses
> to the ROMs there aren't.
>
> If nothing else, anyone reading that code is likely to ask himself the
> very same question -- why the one, and not the others.

Well, I was wondering about all the uses of __get_user; why not
probe_kernel_address() everywhere?

I think its reasonable to assume that if the signature is mapped and
correct, then everything else is mapped.  That's certainly the case for
Xen, which is why I added it.  If you think this is unclear, then I
think a comment to explain this rather than code changes is the
appropriate fix.

    J
