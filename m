Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVERABU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVERABU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 20:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVERABU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 20:01:20 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:26254 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262020AbVERABA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 20:01:00 -0400
Subject: Re: CONFIG_KALLSYMS_EXTRA_PASS
From: Steven Rostedt <rostedt@goodmis.org>
To: pmarques@grupopie.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1116372428.428a7dccec930@webmail.grupopie.com>
References: <1116365006.9737.42.camel@localhost.localdomain>
	 <1116372428.428a7dccec930@webmail.grupopie.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 17 May 2005 20:00:51 -0400
Message-Id: <1116374451.9737.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-18 at 00:27 +0100, pmarques@grupopie.com wrote:

> You can try the very crude (but effective) way to check if this is your problem
> or not. Go to scripts/kallsyms.c and change:
> 
> #define WORKING_SET             1024
> 
> to:
> 
> #define WORKING_SET             65536
> 

Yep, that did the trick. Thanks.  And just to make sure, I put it back
to 1024, recompiled, and got the error again.

> This will force kallsyms to use *all* the symbols for the compression, and the
> size of the result won't be affected by the symbol positions.
> 
> Don't forget to turn off KALLSYMS_EXTRA_PASS to test this.
> 
> If this turns out to be the problem _again_, I'll post a patch to fix this for
> good by storing the token data from the first pass and use it on the second
> pass. This will not only speed up compression, it will also guarantee that this
> kind of problems will never bite us again.

Your patch sounds too good to not be included even if this wasn't the
case. How come it hasn't been applied before?

-- Steve

