Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbWCJNCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWCJNCN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 08:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWCJNCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 08:02:12 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:23374 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1750888AbWCJNCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 08:02:12 -0500
Message-ID: <441178CF.7040705@tls.msk.ru>
Date: Fri, 10 Mar 2006 16:02:07 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@openvz.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext3: ext3_symlink should use GFP_NOFS allocations inside
References: <44106393.2050207@openvz.org>
In-Reply-To: <44106393.2050207@openvz.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
> This patch fixes illegal __GFP_FS allocation inside ext3
> transaction in ext3_symlink().
> Such allocation may re-enter ext3 code from
> try_to_free_pages. But JBD/ext3 code keeps a pointer to current
> journal handle in task_struct and, hence, is not reentrable.
> 
> This bug led to "Assertion failure in journal_dirty_metadata()" messages.
> 
> http://bugzilla.openvz.org/show_bug.cgi?id=115

Is it the same bug as http://marc.theaimsgroup.com/?t=113870577100003&r=1&w=2 ?

Thanks.

/mjt
