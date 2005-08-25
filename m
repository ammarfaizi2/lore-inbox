Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbVHYMNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbVHYMNl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 08:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbVHYMNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 08:13:41 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:23877 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S964951AbVHYMNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 08:13:40 -0400
Message-ID: <430DB5E2.9060103@tu-harburg.de>
Date: Thu, 25 Aug 2005 14:13:22 +0200
From: Jan Blunck <j.blunck@tu-harburg.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RESEND] don't allow sys_readahead() on files opened with
 O_DIRECT
References: <4305D437.4000703@tu-harburg.de> <20050825012440.66b61cca.akpm@osdl.org>
In-Reply-To: <20050825012440.66b61cca.akpm@osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton schrieb:
> 
> a) It doesn't hurt, it's just a bit of a silly thing to do.

IMO it may hurt the performance.

> 
> b) posix_fadvise(POSIX_FADV_WILLNEED) should get the same treatment (and
>    it's the preferred way of doing readahead).

Yes, of course.

> 
> c) O_DIRECT fd's should, as much as possible, offer the same ABI as
>    buffered fd's.

Hmm, with XIP fd's we agreed on the following behavior: fadvise() and
madvise() just return without reading anything to the page cache. Since
XIP fd's are similar to O_DIRECT fd's their behavior should be similar,
too. If we don't honor the advises we might also ignore the syscall. At
least redhat's readahead is using them.

Maybe we should agree on one behavior that makes sense. And I don't see
any point in filling the page cache when it is not needed.

> 
> d) The patch could break existing apps.

Since it could break applications that are already (some kind of) broken
that shouldn't be a problem.

So you think it is better to read nothing to the page cache and return
zero instead? This seems like "lying" to the user-space :)
