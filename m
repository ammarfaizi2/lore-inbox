Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261554AbTCKTDG>; Tue, 11 Mar 2003 14:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261556AbTCKTDG>; Tue, 11 Mar 2003 14:03:06 -0500
Received: from web41003.mail.yahoo.com ([66.218.93.2]:19225 "HELO
	web41003.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261554AbTCKTDE>; Tue, 11 Mar 2003 14:03:04 -0500
Message-ID: <20030311191342.18575.qmail@web41003.mail.yahoo.com>
Date: Tue, 11 Mar 2003 11:13:42 -0800 (PST)
From: Jason Li <zhjl000@yahoo.com>
Subject: out_of_memory called to often
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are running an embedded linux (2.4.19) with no swap
sapce. And we haven't applied any rmap yet.

Currely when the system runs low (reached the
pages_low water-mark), kswapd kicks in. But soon after
kswapd kicks in, the out_of_memory is called due to
swapd not being able to reclaim enough pages from the
page cache from each run of it. I don't understand why
sometimes swapd can't reclaim the SWAP_CLUSTER_MAX
number of pages.

We know there are still some number of cache pages
that can be reclaimed if we run the following c
program:

int main() {
 int i, j;
 char *tmp[10000]

 for (i=0; i<NUMBER_OF_PAGES_LEFT_BEFORE_pages_low;
i++) tmp[i]=malloc(4k);
 for (i=0; i<NUMBER_OF_PAGES_LEFT_BEFORE_pages_low;
i++) free(tmp[i]);
}
To solve this problem, I am trying to make a
conditional call to the out_of_memory() -- only if the
pages_min is reached, then the out_of_memory() can be
called.

If we can solve the swapd livelock problem, is this a
feasible solution? If you have a better idea, can you
please share with us?

Any input will be greatly appreciated.

Thanks very much in advance! Please include my email
address in your reply.

-Jason



__________________________________________________
Do you Yahoo!?
Yahoo! Web Hosting - establish your business online
http://webhosting.yahoo.com
