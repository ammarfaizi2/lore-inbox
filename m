Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965102AbWGKDnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbWGKDnM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 23:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbWGKDnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 23:43:12 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8942 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965102AbWGKDnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 23:43:12 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Fernando Luis =?iso-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>,
       vgoyal@in.ibm.com, akpm@osdl.org, ak@suse.de,
       linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: [PATCH 1/3] stack overflow safe kdump (2.6.18-rc1-i386) - safe_smp_processor_id
References: <1152517852.2120.107.camel@localhost.localdomain>
	<1152540988.7275.7.camel@mulgrave.il.steeleye.com>
	<m1irm5nwyw.fsf@ebiederm.dsl.xmission.com>
	<1152565096.4027.4.camel@mulgrave.il.steeleye.com>
Date: Mon, 10 Jul 2006 21:42:09 -0600
In-Reply-To: <1152565096.4027.4.camel@mulgrave.il.steeleye.com> (James
	Bottomley's message of "Mon, 10 Jul 2006 15:58:16 -0500")
Message-ID: <m18xn0lsdq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> writes:

>
>> To some extent this also shows the mess that the x86 subarch code is
>> because it is never clear if code is implemented in a subarchitecture
>> or not.
>
> Erm, it does?  How?  My statement is that introducing subarch specific
> #defines into subarch independent header files is a problem (which it
> is).  If you grep for subarch defines in the rest of the arch
> independent headers, I don't believe you'll find any.  This would rather
> tend to show that for the last seven years, the subarch interface has
> been remarkably effective ....

They are remarkably brittle, because it is very hard to tell which code
is in a subarch and which code is not.  There have been several iterations
where people have broken subarchitectures by mistake.

This whole conversation is funny in one sense because the code under
discussion won't even compile on voyager right now.  Someone else
caught that and the patch that came out of that conversation was sent
to Andrew earlier today.

All I know for certain is that I have submitted patches that have
changed the entire kernel and the only thing that broke was x86
subarches because it is so non-obvious how they are different.

But I do agree the subarch header files are clean.
And no this case except for the fact no one realized that the
code doesn't even compile on voyager does not show how brittle
the x86 subarch code is.    Except for the fact that it seems
obvious that kernel/smp.c is generic code that every smp subarch
would use.


Eric


