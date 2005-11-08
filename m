Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbVKHDYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbVKHDYT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 22:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbVKHDYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 22:24:19 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:2202 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965019AbVKHDYT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 22:24:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rrzvHRoMx7rpnDNQ2uRtEX3toysBGPn9wkGQRbQr8+1cJEuslG9WLQ+UGFUgOJbB9igzU+4RhVR+OdiIMxyb8Xwkwl6+Egy8Lu92dWF0AUHKf9RLvildD2U4kKi9Xa7cJuhTkhxwc9Y5mTG5nQIEJKL3DILgx8u/RWmXi9SIamI=
Message-ID: <1e62d1370511071924u4e23c3fdjec82f1713ff8d131@mail.gmail.com>
Date: Tue, 8 Nov 2005 08:24:17 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: "ext3crypt@comcast.net" <ext3crypt@comcast.net>
Subject: Re: Am I thinking correctly?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <110720051724.6127.436F8DDF0006D246000017EF22007348309B9F979D0CCC9B980A@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <110720051724.6127.436F8DDF0006D246000017EF22007348309B9F979D0CCC9B980A@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/05, ext3crypt@comcast.net <ext3crypt@comcast.net> wrote:
>
> Kernel Version:  2.6.13
>
> The API will be used, but I am using a simple xor to test with.
>
> The data is getting written to disk, but NOT the buffer I'm sending to submit_bh().  It is writing the buffers from the page I copied???
>
> No messages.  I just do the following:
>
> mount the filesystem
> cd to it's root
> cp foo foo2
> sync
> (at this point everything looks fine)
>
> cd ..
> umount the filesystem
> mount the filesystem
> cd to it's root
> cat foo2 (which is now the wrong data)
>

Have you tried your code by writing the data with-out performing any
operation on data (like xor) ? This will tell you whether your
__block_write_full_page is working fine or not because you will get
exactly the same data as of the original file !

And are you also taking care of write operation other than
address_space_operations->writepages ? Because there is also
file_operations->write which ext3 is assgining do_sync_write
(http://sosdg.org/~coywolf/lxr/source/fs/ext3/file.c#L111), so are you
handling this too ?

> I'll attach the code tonight when I have access to it.
>

That will be much better !

And Please Don't do Top-Posting !

--
Fawad Lateef
