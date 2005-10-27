Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbVJ0S0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbVJ0S0o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 14:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbVJ0S0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 14:26:44 -0400
Received: from xproxy.gmail.com ([66.249.82.205]:31659 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751434AbVJ0S0o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 14:26:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bLXZ/hfh8qbJa4utyNhkhNZhZW4ilQJmM2SDMs1KL+fJdfrBhVEZ+fYgEGCUfozGPato2Jbf80nwh4ketz21c/rY1o752CxGOVhntaJlhmRndhAl/eqvs2muh4iej1VLFz0G+BzrVyTFjeR0XZ4zu+NIoWk23z5uVLamSUNP3JU=
Message-ID: <1e62d1370510271126i73cd94ebwc66f8d7583fa75c2@mail.gmail.com>
Date: Thu, 27 Oct 2005 23:26:41 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: Paulo da Silva <psdasilva@esoterica.pt>
Subject: Re: Learning ext2 fs
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <436116DC.6030104@esoterica.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436116DC.6030104@esoterica.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/05, Paulo da Silva <psdasilva@esoterica.pt> wrote:
> I am reading the ext2 fs code. One of my purposes
> is to save the original data of a file to another file
> just before it is changed by write/mmap/whatever.
> Because of mmap (any other reasons?) I thought
> of doing this at "ext2-writepage" or/and
> "ext2-writepages".
>
> Is this the right place?

ya, AFAIK ext2-writepage/s and ext2-readpage/s are the functions
actually dealing with the file data and you can also see
generic_file_write/read assigned to the fields in ext2_file_operations
variable because they also deals with the file data ...

> Is there a lower level where I can read/write blocks
> of data from/to hd instead of full pages?
>

I think at the lower-level you can deal with the block-layer but at
this layer AFAIK you won't be able to distinguish between file data
and file system data/structures because you will be dealing with just
the blocks/chunks of data for block devices.

> How do I tell the really file data from other data?
>

the functions readpage/writepage deals with the file data only not
with the file-system data/structures. Here I am considering by saying
other data you mean file-system data/structures


> I traced these functions but I only got
> "ext2-writepages" to be called. "ext2-writepage"
> was never called using the programs
> I wrote to test this. When is "ext2-writepage" called?
>

I think it doesn't matter that writepage or writepages are called
because both almost do the same thing and the writepages version deals
with more data and in your case the data may be big enough to handle
by the writepages.

> Thanks for any help.
> Any readings advice is also welcome.
>

I think you can first get some detailed understanding of VFS layer and
then you can easily understand the code of the file-system like EXT2 !

--
Fawad Lateef
