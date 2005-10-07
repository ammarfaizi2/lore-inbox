Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbVJGLgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbVJGLgj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 07:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbVJGLgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 07:36:39 -0400
Received: from xproxy.gmail.com ([66.249.82.201]:32088 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751383AbVJGLgi convert rfc822-to-8bit
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 07:36:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s1BTrETEcjjb8W3PXWgTtCVhZMp+KkqHjDYdTNjpdGBX483X5qUjB+/A9f3sJ7It9i2JAUbBVcOGS2IBbk29XXds3T8tTGEkWnQUXZ9N4f9DCJa02MO5XFp3QaV6tMCNHQ9iRni3aDRWb16ogD2BuUEpiAziRztCq/9+3yO2OWE=
Message-ID: <64c763540510070436s681a3e00q511fb68c1c876aa9@mail.gmail.com>
Date: Fri, 7 Oct 2005 17:06:37 +0530
From: Block Device <blockdevice@gmail.com>
Reply-To: Block Device <blockdevice@gmail.com>
To: Nikita Danilov <nikita@clusterfs.com>
Subject: Re: Block I/O Mystery
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
In-Reply-To: <17222.18470.744354.727641@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <64c763540510062301v2ac65a47p953038b8b674cf1d@mail.gmail.com>
	 <17222.18470.744354.727641@gargle.gargle.HOWL>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   After some more toying around, I have seen that it works correctly
on ext2 fs but not
on etx3. :) ...

  My questions inline ..

On 10/7/05, Nikita Danilov <nikita@clusterfs.com> wrote:

> Blocks read by bread() and friends are cached in block device (not you
> :-) struct address_space. File data are cached in the per-inode struct
> address_space.

But even if I'm reading blocks from a device directly, they are
finally blocks from  the same inode. Why then are they stored
separately ?

> You are bypassing normal file sysetm caching and results can be
> unpredictable.

Is there then a safe way to do it w/o going through the filesystem caching ?

If not, I guess the following steps will be required :
a) Find out the page in the mapping corresponding to the blocks I need
to write.
b) Lock the page. Make changes. Mark it dirty and sync write it ?

Is there something in the kernel which does this already ?

Thanks for the help :) !

-Regards
 BD
