Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262482AbVEMSmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbVEMSmW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 14:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbVEMSmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 14:42:21 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:25864 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262478AbVEMSkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 14:40:52 -0400
To: linuxram@us.ibm.com
CC: viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1116005355.6248.372.camel@localhost> (message from Ram on Fri,
	13 May 2005 10:29:16 -0700)
Subject: Re: [PATCH] namespace.c: fix bind mount from foreign namespace
References: <E1DWXeF-00017l-00@dorka.pomaz.szeredi.hu>
	 <20050513170602.GI1150@parcelfarce.linux.theplanet.co.uk>
	 <E1DWdn9-0004O2-00@dorka.pomaz.szeredi.hu> <1116005355.6248.372.camel@localhost>
Message-Id: <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 13 May 2005 20:40:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Bind mount from a foreign namespace results in
> > > 
> > > ... -EINVAL
> > 
> > Wrong answer.  Look again, you wrote the code, so you _should_ know ;)
> 
> I guess Al agrees that bind mount from foreign namespace must be
> disallowed.
> 
> Which means what Jamie pointed to was right. Attached the patch which
> fixes it.

You are very quick fixing things which are not broken :)

And BTW Jamie was saying, the checks should be removed, not that more
checks should be added (as your patch does).

Jamie Lokier wrote:
> I agree about the bug (and it's why I think the current->namespace
> checks in fs/namespace.c should be killed - the _only_ effect is to
> make un-removable mounts like the above, and the checks are completely
> redundant for "normal" namespace operations).

The checks are actually not redundant, but only because of locking
reasons, not because of security reasons.  So I agree with Jamie, that
in the long run it makes sense to relax those checks.

Miklos

