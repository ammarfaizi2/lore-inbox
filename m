Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262440AbUK3X0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbUK3X0Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbUK3XWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:22:47 -0500
Received: from rev.193.226.233.139.euroweb.hu ([193.226.233.139]:22401 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262459AbUK3XTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:19:44 -0500
To: avi@argo.co.il
CC: alan@lxorguk.ukuu.org.uk, torvalds@osdl.org, hbryan@us.ibm.com,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
In-reply-to: <41ACFAE7.2050002@argo.co.il> (message from Avi Kivity on Wed, 01
	Dec 2004 00:57:43 +0200)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>	 <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu>	 <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org> <1100798975.6018.26.camel@localhost.localdomain> <41A47B67.6070108@argo.co.il> <E1CWwqF-0007Ng-00@dorka.pomaz.szeredi.hu> <41ACBF87.4040206@argo.co.il> <E1CZDUf-0004jM-00@dorka.pomaz.szeredi.hu> <41ACD03C.9010300@argo.co.il> <E1CZFJP-0004uZ-00@dorka.pomaz.szeredi.hu> <41ACE816.50104@argo.co.il> <E1CZG1J-0004zW-00@dorka.pomaz.szeredi.hu> <41ACFAE7.2050002@argo.co.il>
Message-Id: <E1CZHH7-0005Ev-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 01 Dec 2004 00:19:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If you plan on partitioning system memory into none-fuse and fuse 
> memory, yes, that could work. but it's horribly inflexible - right now 
> memory is balanced dynamically according to actual use. 

No partitioning is needed.  If fuse doesn't consume too much memory
for dirty data buffers that memory is free to use for other purposes.

But fuse would be limited in the number of pages which it can use for
dirty buffers exactly to prevent it from causing OOM.

> you may also have a hard time with mmap.

What sort?  You can mmap a 4G file on a machine with 32M memory.  More
memory can improve performance, of course, but otherwise the amount of
memory doesn't matter.

> my proposal (with the per-process allocation thredsholds) only reserves 
> a small amount of memory to the fuse(s), with the rest allocated 
> dynamically using the normal kernel policies, with no special 
> restrictions on fuse.

Yes, but what you reserve (which may be large for some filesystems) is
totally unusable memory except in the special case of helping writeout
in low memory situation, while in my solution the rest of the system
is not limited only the fuse filesystem.

There's not that much difference between what we are saying, but as I
said, I detest the thought, that the filesystem process has to be
special, and I'm prepared to give up some flexibility and performance
for this.

Miklos
