Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWEIWaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWEIWaW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 18:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWEIWaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 18:30:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58775 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751286AbWEIWaV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 18:30:21 -0400
Date: Tue, 9 May 2006 15:27:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, pavel@suse.cz
Subject: Re: [PATCH -mm] swsusp: support creating bigger images (rev. 2)
Message-Id: <20060509152713.36bb94f0.akpm@osdl.org>
In-Reply-To: <200605100015.53455.rjw@sisk.pl>
References: <200605021200.37424.rjw@sisk.pl>
	<20060509003334.70771572.akpm@osdl.org>
	<200605091219.17386.rjw@sisk.pl>
	<200605100015.53455.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> Now if the mapped pages that are not mapped by the
>  current task are considered, it turns out that they would change only if they
>  were reclaimed by try_to_free_pages().  Thus if we take them out of reach
>  of try_to_free_pages(), for example by (temporarily) moving them out of their
>  respective LRU lists after creating the image, we will be able to include them
>  in the image without copying.

I'm a bit curious about how this is true.  There are all sorts of way in
which there could be activity against these pages - interrupt-time
asynchronous network Tx completion, async interrupt-time direct-io
completion, tasklets, schedule_work(), etc, etc.

So...  could we check your homework on this please?  How come only page
reclaim can disturb these pages?
