Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbVJGL4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbVJGL4i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 07:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbVJGL4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 07:56:38 -0400
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:21125 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S932373AbVJGL4h (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 07:56:37 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17222.25180.191039.128718@gargle.gargle.HOWL>
Date: Fri, 7 Oct 2005 15:56:12 +0400
To: Block Device <blockdevice@gmail.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: Block I/O Mystery
In-Reply-To: <64c763540510070436s681a3e00q511fb68c1c876aa9@mail.gmail.com>
References: <64c763540510062301v2ac65a47p953038b8b674cf1d@mail.gmail.com>
	<17222.18470.744354.727641@gargle.gargle.HOWL>
	<64c763540510070436s681a3e00q511fb68c1c876aa9@mail.gmail.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Block Device writes:
 > Hi,
 > 
 >    After some more toying around, I have seen that it works correctly
 > on ext2 fs but not
 > on etx3. :) ...
 > 
 >   My questions inline ..
 > 
 > On 10/7/05, Nikita Danilov <nikita@clusterfs.com> wrote:
 > 
 > > Blocks read by bread() and friends are cached in block device (not you
 > > :-) struct address_space. File data are cached in the per-inode struct
 > > address_space.
 > 
 > But even if I'm reading blocks from a device directly, they are
 > finally blocks from  the same inode. Why then are they stored
 > separately ?

bread() has no idea about "inode". It just reads block number N from
device D. And this is how it is stored in the cache (and can later be
found there): "device D, block N".

read(), on the other hand, reads logical block i from file F, and this
is how that block (page actually) is cached: "file F, page with logical
number i within file".

These two caching mechanisms are disjoint and almost no form of
coherency is maintained between them.

All this, of course, is up to file system to implement, and different
file systems do this slightly differently.

Nikita.
