Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264859AbTE1USQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 16:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264860AbTE1USQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 16:18:16 -0400
Received: from elaine24.Stanford.EDU ([171.64.15.99]:27608 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id S264859AbTE1USP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 16:18:15 -0400
Date: Wed, 28 May 2003 13:31:29 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Hollis Blanchard <hollisb@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER][PATCH] cmpci user-pointer fix
In-Reply-To: <5C5CFB74-9149-11D7-8297-000A95A0560C@us.ibm.com>
Message-ID: <Pine.GSO.4.44.0305281318350.27390-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ---------------------------------------------------------
>
> I believe the attached patch fixes it. cm_write was calling access_ok,
> but after that you must still access user space through the
> get/put/copy*_user functions. It should be safe to return -EFAULT at
> these points in cm_write, since there are other returns already in the
> code above and below that. Compile-tested only.

Thanks a lot for the fixes!

>
> Junfeng, the checker seems to have missed the "*dst0++ = *src++;" bits
> at the bottom of the patch... or at least it wasn't in the mail I saw
> ("4 potential user-pointer errors", 2 May 2003).

I deliberately surpressed 'redudant' error reports.  When the checker saw
multiple errors caused by the same user pointer in one function, it'll
only report one error for this user pointer in this function.  if I don't
do so, people tend to get bored by the 'repeated' messages, and leave
error reports in other functions uninspected. ;) I'll re-run the checker
soon with the suppression off.

-Junfeng

