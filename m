Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbUBRFeX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 00:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264441AbUBRFeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 00:34:23 -0500
Received: from hera.kernel.org ([63.209.29.2]:56208 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S264437AbUBRFeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 00:34:21 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: UTF-8 and case-insensitivity
Date: Wed, 18 Feb 2004 05:33:52 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c0utg0$5b4$1@terminus.zytor.com>
References: <16433.38038.881005.468116@samba.org> <16434.41376.453823.260362@samba.org> <Pine.LNX.4.58.0402171531570.2154@home.osdl.org> <16434.56190.639555.554525@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1077082432 5477 63.209.29.3 (18 Feb 2004 05:33:52 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 18 Feb 2004 05:33:52 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <16434.56190.639555.554525@samba.org>
By author:    tridge@samba.org
In newsgroup: linux.dev.kernel
> 
> In Samba that's not sparse enough that its worth saving the single
> mmap of 128k to encode it sparsely in memory, but in UCS-4 land you
> would obviously use a sparse mapping, and that mapping table would
> probably be just a few k in size. If you allow for extents then I
> expect you could encode it in a couple of hundred bytes.
> 

If all you care about is the UTF-16-compatible range, you only need
1088K entries in your table; small enough that it can be reasonably
had in userspace.

> (I experimented with using a sparse mapping in Samba, and it was a
> slight loss on the machine I was testing on compared to just doing the
> mmap, so I went with the mmap. Maybe someone else can do a better
> sparse encoding than I did and actually get a win due to better cache
> behaviour.)

The thing is, you're probably only touching small parts of your table,
so the kernel and the CPU cache works quite well on the large table as
it is.

Wouldn't work in kernel space, though.

	-hpa
