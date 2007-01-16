Return-Path: <linux-kernel-owner+w=401wt.eu-S1751287AbXAPTb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbXAPTb1 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 14:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbXAPTb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 14:31:27 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34079 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbXAPTb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 14:31:26 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Containers <containers@lists.osdl.org>,
       Tony Luck <tony.luck@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 0/59] Cleanup sysctl
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
	<45AD02FF.605@zytor.com> <m164b6den7.fsf@ebiederm.dsl.xmission.com>
	<45AD1AD7.7030804@zytor.com>
	<m1ac0iby5q.fsf@ebiederm.dsl.xmission.com>
	<45AD2042.9090701@zytor.com>
	<m164b6bxpz.fsf@ebiederm.dsl.xmission.com>
	<45AD2439.6000406@zytor.com>
Date: Tue, 16 Jan 2007 12:30:53 -0700
In-Reply-To: <45AD2439.6000406@zytor.com> (H. Peter Anvin's message of "Tue,
	16 Jan 2007 11:15:05 -0800")
Message-ID: <m11wlubwgi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
>>>
>>> Agreed.  *Furthermore*, if the number isn't in <linux/sysctl.h> it shouldn't
>>> exist anywhere else, either.
>>
>> That would be a good habit.  Feel free to send the patches to ensure that
>> is so.
>>
>> I'm a practical fix it when it is in my way kind of guy ;)
>
> That's fine.  However, I am wondering if there are things in <linux/sysctl.h>
> which really doesn't need architectural numbers, i.e. which should be removed
> from the binary interface.

As a practical measure the 32bit hierarchical numeric namespace is extremely
sparsely populated.  So even if there are things that we never intend to export
again it doesn't hurt to reserve the number for them so we don't confuse something
that thought the number actually meant something.

In the worst case we want to comment out the entry so we keep the number
reserved even if we don't use it.

To see if there are entries we are not currently using just requires
going through the loop.

<pseudo shell>
For DEFINE in sysctl.h ; do
   if ! grep -r DEFINE /usr/src/linux/ ; then
   	echo DEFINE not used.
   fi
done
</pseudo shell>

Eric
