Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbVKAMip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVKAMip (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 07:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVKAMip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 07:38:45 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7385 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750776AbVKAMip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 07:38:45 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Doug Thompson <dthompson@lnxi.com>
Subject: Re: PATCH: EDAC - clean up atomic stuff
References: <1129902050.26367.50.camel@localhost.localdomain>
	<m164rhbnyk.fsf@ebiederm.dsl.xmission.com>
	<1130772628.9145.35.camel@localhost.localdomain>
	<m1oe55abm4.fsf@ebiederm.dsl.xmission.com>
	<20051031120254.4579dc9a.akpm@osdl.org>
	<m18xw88thu.fsf@ebiederm.dsl.xmission.com>
	<1130849199.9145.94.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 01 Nov 2005 05:38:07 -0700
In-Reply-To: <1130849199.9145.94.camel@localhost.localdomain> (Alan Cox's
 message of "Tue, 01 Nov 2005 12:46:39 +0000")
Message-ID: <m1zmoo7dcg.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> There is a much more serious bug there as well.  The code as it
>> exists is flatly impossible on x86_64 and some other architectures
>> as they do not support kmap.  It is also broken on x86 as grain can
>
> All platforms have kmap. On systems without "highmem" the kmap functions
> simply return the page address of the existing permanent physical
> mapping for the page. See include/linux/highmem.h

Duh, I just looked again.  I knew we had kmap, I had thought kmap_atomic
was special enough that it wasn't always there.  I'm wrong. 

> So it's all fine and larger than page sized scrubs can be added to the
> core code when they are needed.

The set of memory controllers where software scrubbing is interesting
and the set of memory controllers that need larger than page sized scrubs
intersect quite strongly.  Although I don't think any of those
memory controllers ever migrated over from the old ecc.c code base.
We should at least have a BUG_ON((offset+size) > PAGE_SIZE) so we
don't forget to fix it.

Eric

