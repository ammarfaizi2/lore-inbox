Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268511AbUIFUMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268511AbUIFUMc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 16:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268515AbUIFUMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 16:12:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:54429 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268511AbUIFUMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 16:12:30 -0400
Date: Mon, 6 Sep 2004 13:10:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ray Bryant <raybry@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com,
       piggin@cyberone.com.au, mbligh@aracnet.com, kernel@kolivas.org
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
Message-Id: <20040906131027.227b99ac.akpm@osdl.org>
In-Reply-To: <413CB661.6030303@sgi.com>
References: <413CB661.6030303@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Bryant <raybry@sgi.com> wrote:
>
> A scan of the change logs for swappiness related changes shows nothing that 
>  might explain these changes.  My question is:  "Is this change in behavior
>  deliberate, or just a side effect of other changes that were made in the vm?" 

It'll be accidental side-effects arising from changes to other parts of the
page reclaim code.

>  and "What kind of swappiness behavior might I expect to find in future kernels?".

Hopefully very little.  Unless we choose to deliberately change the swapout
behaviour.  The code in there is complex and as you've seen, has surprising
interactions.  And changes have been made without sufficiently broad testing.

So I'll be setting the bar much higher for changes to vmscan.c.  It takes a
*lot* of work to demonstrate that a change in there does what it's supposed
to do without breaking other things.


That being said, your tests are interesting.  There's a wide spread of
results across different kernel versions and across different swappiness
settings.  But the question is: which behaviour is correct for your users,
and why?


