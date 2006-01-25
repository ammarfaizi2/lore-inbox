Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWAYDRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWAYDRF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 22:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWAYDRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 22:17:05 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:22103 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750992AbWAYDRE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 22:17:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ehc9TnxNsFcWwzwr8CKOhRvLwGj2tow/JwNlsULOaqIMakc55YmKEjADV1Y6GniGasET8PipnWMJGn5gwdkh3hUkN/2v7W5O33zKzyz46eqSQV5WGQ+S8dHxzjFqkKOHlIBngCUMilbWLw9aKSzrSgM+9JVdoaf6xZYD6ah4rDs=
Message-ID: <1e62d1370601241917l4c53cf3fud34835c4dc5c1526@mail.gmail.com>
Date: Wed, 25 Jan 2006 08:17:02 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: Joshua Hudson <joshudson@gmail.com>
Subject: Re: Block device API
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <bda6d13a0601241858g260b915bs5370d34ac90321de@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bda6d13a0601241858g260b915bs5370d34ac90321de@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/06, Joshua Hudson <joshudson@gmail.com> wrote:
> I am working on a kernel filesystem driver. I have found plenty of
> documentation on
> how to communicate between the VFS and the filesystem driver, but nothing
> on how to communicate between the block device and the filesystem driver.
>

AFAIK there isn't any documentation/article for block and filesystem
layer interaction (or till now me also not able to find any) :)

> I found sb_bread() but there is no corrisponding sb_bwrite().
> I presume that if ((struct superblock *)s) -> bdev is the block
> device handle, but I cannot find the read/write pair of functions.
> -

sb_bread is the function used for reading a block (especially
superblock) from the storage. For reading/writing do look at
generic_file_read/write functions found in mm/filemap.c and when going
through the code you will see its ends up in calling
mappings->a_ops->readpage(s)/writepage(s) of filesystem in which
normal filesystems (like ext2) just call function
mpage_readpages/writepages found in fs/mpage.c which performs actual
read/write on the block device.

I hope this helps !

--
Fawad Lateef
