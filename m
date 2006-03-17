Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWCQQGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWCQQGq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 11:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWCQQGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 11:06:46 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53632 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751217AbWCQQGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 11:06:45 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Michael Kerrisk <mtk-manpages@gmx.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, janak@us.ibm.com, viro@ftp.linux.org.uk,
       hch@lst.de, ak@muc.de, paulus@samba.org
Subject: Re: [PATCH] unshare: Cleanup up the sys_unshare interface before we
 are committed.
References: <Pine.LNX.4.64.0603161555210.3618@g5.osdl.org>
	<29085.1142557915@www064.gmx.net>
	<Pine.LNX.4.64.0603162140190.3618@g5.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 17 Mar 2006 09:04:41 -0700
In-Reply-To: <Pine.LNX.4.64.0603162140190.3618@g5.osdl.org> (Linus
 Torvalds's message of "Thu, 16 Mar 2006 21:42:53 -0800 (PST)")
Message-ID: <m1y7z93vmu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 17 Mar 2006, Michael Kerrisk wrote:
>> 
>> >  - it's all the same issues that clone() has
>> 
>> At the moment, but possibly not in the future (if one day
>> usnhare() needs a flag that has no analogue in clone()).
>
> I don't believe that.
>
> If we have something we might want to unshare, that implies by definition 
> that it was something we wanted to conditionally share in the first place.
>
> IOW, it ends up being something that would be a clone() flag.
>
> So I really do believe that there is a fundamental 1:1 between the flags. 
> They aren't just "similar". They are very fundamentally about the same 
> thing, and giving two different names to the same thing is CONFUSING.

The scary thing is that with only 7 things we can share or not,
and a 32bit field we have only 7 bits left that we can define.
Last count I think I know of at least that many additional global
namespaces in the kernel.



On the confusing side.  Unshare largely because it doesn't default to
unsharing all of the thread state.  Has the weird issue that unshare
will automatically add bits you didn't ask for (so it can satisfy your
request) and unsharing more than you requested.  Clone when presented
with the same situation returns an error.

So even while the resources are the same the interaction of the
bits really is quite different between the two calls.

Eric
