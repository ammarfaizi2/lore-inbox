Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313075AbSDKHlj>; Thu, 11 Apr 2002 03:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313172AbSDKHli>; Thu, 11 Apr 2002 03:41:38 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:62220 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S313075AbSDKHlh>;
	Thu, 11 Apr 2002 03:41:37 -0400
Date: Thu, 11 Apr 2002 16:41:34 +0900 (JST)
Message-Id: <20020411.164134.85392767.taka@valinux.co.jp>
To: davem@redhat.com
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20020410.234821.122842406.davem@redhat.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

davem> Consider truncate() to 1 byte left in that page.  To handle mmap()'s
davem> of this file the kernel will memset() rest of the page to zero.
davem> Now, in the sendfile() case the NFS client sees some page filled
davem> mostly of zeros instead of file contents.

Hmmm... I realize clearly.

davem> In sendmsg() knfd case, client sees something reasonable.  He will
davem> see something that was actually in the file at some point in time.
davem> The sendfile() case sees pure garbage, contents that never were in
davem> the file at any point in time.
davem> 
davem> We could make knfsd take the write semaphore on the inode until client
davem> is known to get the packet but that is the kind of overhead we'd like
davem> to avoid.

Yes, the write semaphore would be good solution if TCP/IP stack never
get stuck.

Now I wonder if we could make these pages COW mode.
When some process try to update the pages, they should be duplicated.
I's easy to implement it in write(), truncate() and so on.
But mmap() is little bit difficult if there no reverse mapping page to PTE.

How do you think about this idea?

Regards,
Hirokazu Takahashi
