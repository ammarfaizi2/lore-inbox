Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161201AbVICJhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161201AbVICJhW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 05:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161191AbVICJhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 05:37:22 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:9134 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750824AbVICJhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 05:37:21 -0400
Message-ID: <43196EB8.9090207@jp.fujitsu.com>
Date: Sat, 03 Sep 2005 18:36:56 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Brent Casavant <bcasavan@sgi.com>, linux-ia64@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.13] IOCHK interface for I/O error handling/detecting
 (for ia64)
References: <431694DB.90400@jp.fujitsu.com> <20050901172917.I10072@chenjesu.americas.sgi.com> <20050902182453.GB28254@parisc-linux.org>
In-Reply-To: <20050902182453.GB28254@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Thu, Sep 01, 2005 at 05:45:54PM -0500, Brent Casavant wrote:
> 
>>I am extremely concerned about the performance implications of this
>>implementation.  These changes have several deleterious effects on I/O
>>performance.
> 
> 
> I agree.  I think the iochk patches should be abandoned and the feature
> reimplemented on top of the asynchronous PCI error notification patches
> from Linas Vepstas.

Do you mean that all architecture especially other than PPC64 already
have enough synchronization point or enough infrastructure to invoke
those notifiers effectively?  I don't think so.

As far as I know, PPC64 is enveloped by a favorable situation.
At least in situation of readX and inX on PPC64, they already have
a error check point, and the EEH technology and the firmware make their
error recovery easier.
Because PPC64 firmware (or hardware? - I'm not sure) automatically detects
errors, isolates erroneous device and returns "(type)~0" to kernel,
readX/inX doesn't need to do any expensive thing unless it get "(type)~0."
Therefore PPC64 can have a nice chance to invoke notifiers by extending
the codes in the error check point.
It is clear that doing same thing on other architecture will be quite
painful and expensive.

Why don't you think that it would be useful if the error notifier
could be invoked from iochk_read()?  I believe the iochk patches
will help implementing PCI error notification on not only IA64 but
also i386 and so on.
Or do you mean we would be happy if we all have a PPC64 box?


Thanks,
H.Seto

