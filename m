Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264643AbSKRS2V>; Mon, 18 Nov 2002 13:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264620AbSKRS2V>; Mon, 18 Nov 2002 13:28:21 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:14982 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264643AbSKRS1A>; Mon, 18 Nov 2002 13:27:00 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 18 Nov 2002 10:34:23 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Andrew Morton <akpm@digeo.com>
cc: Dave Hansen <haveblue@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
       <riel@surriel.com>, <akpm@zip.com.au>
Subject: Re: unusual scheduling performance
In-Reply-To: <3DD92E92.EEB9ECD6@digeo.com>
Message-ID: <Pine.LNX.4.44.0211181031400.979-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Andrew Morton wrote:

> Dave Hansen wrote:
> >
> > ...
> >      rwsem_down_write_failed:           133    133
>
> Possible culprit.
>
> Please stick a dump_stack() in rwsem_down_write_failed(), and add the below.
> Suggest you stick with 2.5.47 to diagnose this.  The loss of kksymoops
> is a pain.
>
>
>  fs/eventpoll.c |    2 ++
>  1 files changed, 2 insertions(+)
>
> --- 25/fs/eventpoll.c~hey	Mon Nov 18 10:13:40 2002
> +++ 25-akpm/fs/eventpoll.c	Mon Nov 18 10:14:01 2002
> @@ -328,6 +328,8 @@ void eventpoll_release(struct file *file
>  	if (list_empty(lsthead))
>  		return;
>
> +	printk("hey!\n");
> +

Andrew, if you don't use epoll there's no way you get there. The function
eventpoll_file_init() initialize the list at each file* init in
fs/file_table.c
If you're not using epoll and you get there, someone is screwing up the
data inside the struct file



- Davide


