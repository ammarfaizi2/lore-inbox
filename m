Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265054AbTFRHQb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 03:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbTFRHQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 03:16:31 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:17672 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265054AbTFRHQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 03:16:28 -0400
Date: Wed, 18 Jun 2003 00:31:10 -0700
From: Andrew Morton <akpm@digeo.com>
To: Paul Mackerras <paulus@samba.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: copy_from_user
Message-Id: <20030618003110.6a9751a5.akpm@digeo.com>
In-Reply-To: <16112.2991.972670.344808@cargo.ozlabs.ibm.com>
References: <16112.2991.972670.344808@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jun 2003 07:30:24.0570 (UTC) FILETIME=[7B7761A0:01C3356B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
>
> Some time ago (in the 2.1 series IIRC) we added code to copy_from_user
>  to zero the remainder of the destination buffer if we faulted on the
>  source.  The motive was to eliminate some potential security holes
>  that could arise if callers didn't check the return value from
>  copy_from_user and continued on to pass the contents of the
>  destination buffer back to userspace in one way or another.
> 
>  However, I notice that copy_from_user on i386 in 2.5 doesn't clear the
>  destination if the access_ok() check fails,

This was not deliberate - the memset simply got lost.

It is simple enough to fix.  Do we remember the details of the
security hole?

> or if the size is 1, 2 or 4.

This one is OK - __get_user_asm() does the zeroing in the fixup code.



